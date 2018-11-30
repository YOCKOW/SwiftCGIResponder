/* *************************************************************************************************
 RFC6265Cookie+HeaderFieldValue.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet
import Foundation
import Network

// Request
extension RFC6265Cookie {
  /// Returns a Boolean value that indicates whether the cookie can be sent to `url` or not.
  public func canBeSent(to url:URL) -> Bool {
    // Expiration
    if let expires = self.expiresDate {
      guard expires.timeIntervalSinceNow > 0 else { return false }
    }
    
    // Secure
    guard let scheme = url.scheme?.lowercased() else { return false }
    if self.isSecure {
      guard scheme == "https" || scheme == "shttp" else { return false }
    }
    
    // Host
    guard let urlHost = url.hostComponent else { return false }
    let cookieHost = URL.Host(string:self.domain)
    if self.isHostOnly {
      guard urlHost == cookieHost else { return false }
    } else {
      guard urlHost.domainMatches(cookieHost) else { return false }
    }
    
    // Path
    let path = url.path.isEmpty ? "/" : url.path
    guard ({ (requestPath:String, cookiePath:String) -> Bool in
      if requestPath == cookiePath { return true }
      if requestPath.hasPrefix(cookiePath) && cookiePath.hasSuffix("/") { return true }
      if requestPath.hasPrefix("\(cookiePath)/") { return true }
      return false
    })(path, self.path) else { return false }
    
    return true
  }
}
