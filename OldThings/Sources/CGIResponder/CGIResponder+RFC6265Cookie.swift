/***************************************************************************************************
 CGIResponder+RFC6265Cookie.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
extension CGIResponder {
  /// Append `cookie` as HTTP header field "Set-Cookie:".
  public mutating func appendCookie<Cookie>(_ cookie:Cookie) where Cookie:RFC6265Cookie {
    let headerField = HTTPHeaderField(setCookie:cookie)
    try! self.header.append(headerField)
  }
  
  /// Set `cookie` as HTTP header field "Set-Cookie:".
  public mutating func setCookie<Cookie>(_ cookie:Cookie) where Cookie:RFC6265Cookie {
    let headerField = HTTPHeaderField(setCookie:cookie)
    self.header.set(headerField)
  }
}
