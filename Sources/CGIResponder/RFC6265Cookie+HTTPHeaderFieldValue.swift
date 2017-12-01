/***************************************************************************************************
 RFC6265Cookie+HTTPHeaderFieldValue.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

extension RFC6265Cookie {
  /// returns "name=value".
  /// Name and Value will be encoded when `addingPercentEncoding` is true.
  fileprivate func nameValuePair(addingPercentEncoding: Bool = true) -> String? {
    if addingPercentEncoding {
      guard let name = self.name.addingPercentEncoding(withAllowedUnicodeScalars:.httpTokenAllowed) else { return nil }
      guard let value = self.value.addingPercentEncoding(withAllowedCharacters:.cookieValueAllowed) else { return nil }
      return "\(name)=\(value)"
    } else {
      return "\(self.name)=\(self.value)"
    }
  }
}

// Request Header.
extension RFC6265Cookie {
  /// Create an instance of `HTTPHeaderFieldValue` for request header from a single cookie.
  /// Returns `nil` if `self` should not be sent to `url`.
  public func requestHeaderFieldValue(for url:URL,
                                      addingPercentEncoding:Bool = true) -> HTTPHeaderFieldValue? {
    if let expires = self.expiresDate {
      guard expires.timeIntervalSinceNow > 0 else { return nil }
    }
    
    guard let scheme = url.scheme?.lowercased() else { return nil }
    if self.isSecure {
      guard scheme == "https" || scheme == "shttp" else { return nil }
    }
    
    guard let urlHost = url.hostComponent else { return nil }
    guard let cookieHost = URL.Host(string:self.domain) else { return nil }
    if self.isHostOnly {
      guard urlHost == cookieHost else { return nil }
    } else {
      guard case let .name(urlHostname) = urlHost,
        case let .name(cookieHostname) = cookieHost else { return nil }
      guard urlHostname.domainMatches(cookieHostname) else { return nil }
    }
    
    let path = url.path.isEmpty ? "/" : url.path
    guard ({ (requestPath:String, cookiePath:String) -> Bool in
      if requestPath == cookiePath { return true }
      if requestPath.hasPrefix(cookiePath) && cookiePath.hasSuffix("/") { return true }
      if requestPath.hasPrefix("\(cookiePath)/") { return true }
      return false
    })(path, self.path) else { return nil }
    
    guard let string = self.nameValuePair(addingPercentEncoding:addingPercentEncoding) else {
      return nil
    }
    
    return HTTPHeaderFieldValue(rawValue:string)
  }
  
  /// Create an instance of `HTTPHeaderFieldValue` for request header from multiple cookies.
  /// Call `func requestHeaderFieldValue(for url:URL, addingPercentEncoding:Bool) -> HTTPHeaderFieldValue?` internally.
  public static func requestHeaderFieldValue<Cookie: RFC6265Cookie>(with cookies:[Cookie],
                                                                    for url:URL,
                                                                    addingPercentEncoding:Bool = true) -> HTTPHeaderFieldValue {
    var values: [HTTPHeaderFieldValue] = []
    for cookie in cookies {
      guard let fieldValue = cookie.requestHeaderFieldValue(for:url,
                                                            addingPercentEncoding:addingPercentEncoding) else {
          continue
      }
      values.append(fieldValue)
    }
    return HTTPHeaderFieldValue(rawValue:values.map{ $0.rawValue }.joined(separator:"; "))!
  }
}
