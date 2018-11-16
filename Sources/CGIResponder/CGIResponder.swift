/* *************************************************************************************************
 CGIResponder.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
import LibExtender

/// The principal structure that can respond to the client.
public struct CGIResponder {
  /// An instance of `HTTPStatusCode` that indicates the result of response.
  public var status: HTTPStatusCode
  
  /// Response header that contains some HTTP header fields.
  public var header: HTTPHeader
  
  /// The content.
  public var content: CGIContent
  
  public init(status: HTTPStatusCode  = .ok,
              header: HTTPHeader = HTTPHeader([]),
              content: CGIContent = .string("", encoding:.utf8))
  {
    self.status = status
    self.header = header
    self.content = content
  }
}

extension CGIResponder {
  /// The content type of the response.
  /// This property is computed from `HTTPHeader`.
  public var contentType: ContentType {
    get {
      guard let field = self.header[.contentType].first else {
        return ContentType(type:.application, subtype:"octet-stream")!
      }
      return field.source as! ContentType
    }
    set {
      self.header[.contentType] = [.contentType(newValue)]
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
      var params: ContentType.Parameters = contentType.parameters ?? [:]
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
  /// Estimate the expected status by checking ETag or Last-Modified.
  public var expectedStatus: HTTPStatusCode? {
    let header = self.header
    let req = Client.client.request
    
    if let eTagHeaderField = header[.eTag].first, let eTag = eTagHeaderField.source as? HTTPETag {
      if let ifMatch = req.ifMatch {
        if !ifMatch.contains(eTag, weakComparison:false) { return .preconditionFailed }
      } else if let ifNoneMatch = req.ifNoneMatch {
        if ifNoneMatch.contains(eTag, weakComparison:true) { return .notModified }
      }
    } else if let lastModifiedField = header[.lastModified].first,
              let lastModified = lastModifiedField.source as? Date
    {
      if let ifUnmodifiedSince = req.ifUnmodifiedSince {
        if lastModified > ifUnmodifiedSince { return .preconditionFailed }
      } else if let ifModifiedSince = req.ifModifiedSince {
        if lastModified <= ifModifiedSince { return .notModified }
      }
    }
    return nil
  }
}

extension CGIResponder {
  /**
   
   Respond to client; Print HTTP headers (including "Status") and content to standard output.
   Modifications may be made by Web Server.
   Just call this method after everything is ready.
   
   ```Swift
   import CGIResponder
   var responder = CGIResponder()
   responder.status = .ok
   responder.contentType = ContentType(pathExtension:.txt, parameters:["charset":"UTF-8"])!
   responder.content = .string("Hello, World!\n", encoding:.utf8)
   try! responder.respond()
   
   // -- Output --
   // Status: 200 OK
   // Content-Type: text/plain; charset=UTF-8
   //
   // Hello, World!
   //
   ```
   */
  public func respond() throws {
    var stdout = FileHandle.standardOutput
    try self.respond(to:&stdout)
  }
  
  /// For debug purpose, you can specify output.
  public func respond<Respondee:CGIContentOutputStream>(to output:inout Respondee) throws {
    let status = self.status
    
    // Check if there's mismatch about string encoding.
    if case let .string(_, encoding:encoding) = self.content,
      let expectedEncoding = self.stringEncoding,
      encoding != expectedEncoding
    {
      warn(message:.stringEncodingInconsistency(encoding, expectedEncoding))
    }
    
    // Check if `status` is an expected value or not using ETag or Last-Modified
    if let expectedStatus = self.expectedStatus, status != expectedStatus {
      warn(message:.statusCodeInconsistency(status, expectedStatus))
    }
    
    if status.rawValue / 100 == 3 {
      guard self.header[.location].count > 0 else {
        throw CGIResponderError.missingRequiredHTTPHeaderField(name:.location)
      }
    }
    
    // Status
    try output.write(
      CGIContent(string:"Status: \(status.rawValue) \(status.reasonPhrase)\u{000D}\u{000A}")
    )
    
    // Requires `Content-Type:`
    var header = self.header
    if header[.contentType].count < 1 {
      header.insert(.contentType(ContentType(type:.application, subtype:"octet-stream")!))
    }
    try output.write(CGIContent(string:header.description))
    
    // If the method is HEAD, the body is not required.
    if let method = Client.client.request.method, method == .head {
      return
    }
    
    // print contents
    try output.write(self.content)
  }
}
