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
}
