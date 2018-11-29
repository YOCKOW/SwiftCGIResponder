/* *************************************************************************************************
 RFC6265Cookie+HeaderFieldValue.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet
import Foundation
import Network

extension RFC6265Cookie {
  /// returns "name=value".
  /// Name and Value will be encoded when `addingPercentEncoding` is true.
  fileprivate func _nameAndValue(addingPercentEncoding: Bool = true) -> String? {
    if addingPercentEncoding {
      guard let name = self.name.addingPercentEncoding(withAllowedUnicodeScalars:.httpTokenAllowed)
        else { return nil }
      guard let value = self.value.addingPercentEncoding(withAllowedUnicodeScalars:.cookieValueAllowed)
        else { return nil }
      return "\(name)=\(value)"
    } else {
      return "\(self.name)=\(self.value)"
    }
  }
}

// Request Header
extension RFC6265Cookie {
  /// Create an instance of `HeaderFieldValue` for request header from a single cookie.
  /// Returns `nil` if `self` should not be sent to `url`.
  public func requestHeaderFieldValue(for url:URL,
                                      addingPercentEncoding:Bool = true) -> HeaderFieldValue?
  {
    if let expires = self.expiresDate {
      guard expires.timeIntervalSinceNow > 0 else { return nil }
    }
    
    guard let scheme = url.scheme?.lowercased() else { return nil }
    if self.isSecure {
      guard scheme == "https" || scheme == "shttp" else { return nil }
    }
    
    guard let urlHost = url.hostComponent else { return nil }
    let cookieHost = URL.Host(string:self.domain)
    if self.isHostOnly {
      guard urlHost == cookieHost else { return nil }
    } else {
      guard urlHost.domainMatches(cookieHost) else { return nil }
    }
    
    let path = url.path.isEmpty ? "/" : url.path
    guard ({ (requestPath:String, cookiePath:String) -> Bool in
      if requestPath == cookiePath { return true }
      if requestPath.hasPrefix(cookiePath) && cookiePath.hasSuffix("/") { return true }
      if requestPath.hasPrefix("\(cookiePath)/") { return true }
      return false
    })(path, self.path) else { return nil }
    
    guard let string = self._nameAndValue(addingPercentEncoding:addingPercentEncoding) else {
      return nil
    }
    
    return HeaderFieldValue(rawValue:string)
  }
}
