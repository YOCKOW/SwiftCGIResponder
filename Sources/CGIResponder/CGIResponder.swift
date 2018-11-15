/* *************************************************************************************************
 CGIResponder.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 

public struct CGIResponder {
  /// An instance of `HTTPStatusCode` that indicates the result of response.
  public var status: HTTPStatusCode = .ok
  
  /// Response header that contains some HTTP header fields.
  public var header: HTTPHeader = HTTPHeader([])
  
  /// The content.
  public var content: CGIContent = .string("", encoding:.utf8)
}
