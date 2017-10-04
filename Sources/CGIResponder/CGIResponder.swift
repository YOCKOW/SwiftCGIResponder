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
  
  public init(status: HTTPStatusCode = .ok,
              header: HTTPHeader = HTTPHeader(fields:[])) {
    self.status = status
    self.header = header
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
