/***************************************************************************************************
 CGIResponder.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

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
