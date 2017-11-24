/***************************************************************************************************
 CGIResponder.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # CGIResponder
 The principal structure that can respond to the client.
 
 */
public struct CGIResponder {
  public var status: HTTPStatusCode
  public var header: HTTPHeader // response header
  public var content: CGIContent
  
  public init(status: HTTPStatusCode = .ok,
              header: HTTPHeader = HTTPHeader(fields:[]),
              content: CGIContent = .string("", encoding:.utf8)) {
    self.status = status
    self.header = header
    self.content = content
  }
}

extension CGIResponder {
  /**
   
   Set HTTP Header Field
   
   - returns: Nothing
   
   */
  public mutating func setHTTPHeaderField(_ newField:HTTPHeaderField) {
    self.header.set(newField)
  }
  
  /**
   
   Append HTTP Header Field
   
   - returns: Nothing
   
   */
  public mutating func appendHTTPHeaderField(_ newField:HTTPHeaderField) throws {
    try self.header.append(newField)
  }
  public mutating func appendHTTPHeaderField(name:HTTPHeaderFieldName, value:HTTPHeaderFieldValue) throws {
    guard let field = HTTPHeaderField(name:name, value:value) else {
      throw CGIResponderError.invalidArgument
    }
    try self.appendHTTPHeaderField(field)
  }
}

extension CGIResponder {
  /// Get and set Content-Type directly.
  public var contentType: MIMEType {
    get {
      guard let field = self.header.fields(forName:.contentType).first else {
        return MIMEType(type:.application, subtype:"octet-stream")!
      }
      return (field.delegate as! SpecifiedHTTPHeaderFieldDelegate.ContentType).contentType
    }
    set {
      self.setHTTPHeaderField(HTTPHeaderField(contentType:newValue))
    }
  }
  
  /// Get and set "charset" directly.
  public var stringEncoding: String.Encoding? {
    get {
      guard let params = self.contentType.parameters else { return nil }
      guard let name = params["charset"] else { return nil }
      guard let encoding = String.Encoding(ianaCharacterSetName:name) else { return nil }
      return encoding
    }
    set {
      var contentType = self.contentType
      var params: [String:String] = contentType.parameters != nil ? contentType.parameters! : [:]
      if let encoding = newValue {
        params["charset"] = encoding.ianaCharacterSetName! // error may occur
      } else {
        params.removeValue(forKey:"charset")
      }
      contentType.parameters = params
      self.contentType = contentType
    }
  }
}

extension CGIResponder {
  /// Check ETag or Last-Modified
  public var expectedStatus: HTTPStatusCode? {
    let header = self.header
    let env = EnvironmentVariables.default
    
    if let eTagHeaderField = header.fields(forName:.eTag).first {
      let eTag = (eTagHeaderField.delegate as! HTTPHeaderFieldDelegate.ETag).eTag
      if case let ifMatch as [HTTPETag] = env[.httpIfMatch] {
        if !eTag.matches(in:ifMatch) { return .preconditionFailed }
      } else if case let ifNoneMatch as [HTTPETag] = env[.httpIfNoneMatch] {
        if eTag.weaklyMatches(in:ifNoneMatch) { return .notModified }
      }
    } else if let lastModifiedHeaderField = header.fields(forName:.lastModified).first {
      let lastModified = (lastModifiedHeaderField.delegate as! HTTPHeaderFieldDelegate.LastModified).date
      if case let ifUnmodifiedSince as Date = env[.httpIfUnmodifiedSince] {
        if lastModified > ifUnmodifiedSince { return .preconditionFailed }
      } else if case let ifModifiedSince as Date = env[.httpIfModifiedSince] {
        if lastModified <= ifModifiedSince { return .notModified }
      }
    }
    return nil
  }
}

extension CGIResponder {
  /**
   
   Respond to client; Print HTTP headers (including "Status") and contents to standard output.
   Modifications may be made by Web Server.
   Just call this method after everything is ready.
   
   ```
   var responder = CGIResponder()
   responder.status = .ok
   responder.contentType = MIMEType(pathExtension:.txt, parameters:["charset":"UTF-8"])!
   responder.content = .string("Hello, World!\n", encoding:.utf8)
   
   // -- Output --
   // Status: 200 OK
   // Content-Type: text/plain; charset=UTF-8
   //
   // Hello, World!
   //
   ```
   
   - returns:
     Nothing
   
   - parameters:
     Nothing
   
   */
  public func respond() {
    var stdout = FileHandle.standardOutput
    do {
      try self.respond(to:&stdout)
    } catch CGIResponderError.missingRequiredHTTPHeaderField(let name) {
      warn("HTTP Header Field `\(name)` Required.")
    } catch {
      warn("Unexpected Error Occurred.")
    }
  }
  
  /// For debug purpose, you can specify output.
  public func respond<Respondee: CGIContentOutputStream>(to output:inout Respondee) throws {
    let status = self.status
    
    // Check if there's mismatch about string encoding.
    if case let .string(_, encoding:encoding) = self.content,
       let expectedEncoding = self.stringEncoding,
       encoding != expectedEncoding {
      viewMessage(.stringEncodingInconsistency(encoding, expectedEncoding))
    }
    
    // Check if `status` is an expected value or not using ETag or Last-Modified
    if let expectedStatus = self.expectedStatus, status != expectedStatus {
      viewMessage(.statusCodeInconsistency(status, expectedStatus))
    }
    
    // Status
    try output.write(CGIContent(string:"Status: \(status.rawValue) \(status.reasonPhrase)\r\n"))
    
    // Requires `Content-Type:`
    var header = self.header
    if header.fields(forName:.contentType).first == nil {
      header.set(HTTPHeaderField(contentType:MIMEType(type:.application, subtype:"octet-stream")!))
    }
    try output.write(CGIContent(string:header.description + "\r\n"))
    
    // print contents
    try output.write(self.content)
  }
}
