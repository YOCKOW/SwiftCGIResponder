/* *************************************************************************************************
 CookieProperties+HeaderFieldValue.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet
import Foundation
import Network

private func _trim<S>(_ string:S) -> String where S:StringProtocol {
  return string.trimmingUnicodeScalars(in:.whitespacesAndNewlines)
}

private func _attributes(_ string:String) -> [String:String] {
  let pairs = string.components(separatedBy:";").map { _trim($0) }
  return pairs.reduce(into:[:]) { (result:inout [String:String], string:String) -> Void in
    let (key, value) = string.splitOnce(separator:"=")
    result[_trim(key).lowercased()] = (value == nil) ? "" : _trim(value!)
  }
}

// Generate an instance from the value of "Set-Cookie:"
extension CookieProperties {
  private mutating func _setExpires(maxAge:String?, expires:String?, now:Date) -> Bool {
    if let maxAgeString = maxAge, let maxAge = TimeInterval(maxAgeString) {
      self.expiresDate = now.addingTimeInterval(maxAge)
      self.persistent = true
      return true
    }
    
    if let  expiresString = expires {
      guard let date = Date(cookieDateString:expiresString) else { return false }
      self.expiresDate = date
      self.persistent = true
      return true
    }
    
    // No expiration was given...
    self.expiresDate = nil
    self.persistent = false
    return true
  }
  
  private mutating func __setHostOnlyToTrue(requestHost:URL.Host) {
    // Host-Only-Flag is true when:
    //   * There is no attribute named "Domain",
    //   * The value of "Domain" is an IP Address, or
    //   * The value of "Domain" is the public suffix and is equal to request host-name
    self.domain = requestHost.description
    self.hostOnly = true
  }
  private mutating func _setDomain(domain:String?, requestHost:URL.Host) -> Bool {
    guard let responseDomainString = domain else {
      self.__setHostOnlyToTrue(requestHost:requestHost)
      return true
    }
    
    let responseHost = URL.Host(string:responseDomainString)
    if responseHost.isIPAddress {
      guard responseHost == requestHost else { return false }
      self.__setHostOnlyToTrue(requestHost:requestHost)
      return true
    }
    
    guard let responseDomain = Domain(responseDomainString, options:.loose) else { return false }
    if responseDomain.isPublicSuffix {
      guard responseHost == requestHost else { return false }
      self.__setHostOnlyToTrue(requestHost:requestHost)
      return true
    }
    
    guard requestHost.domainMatches(responseHost) else { return false }
    self.domain = responseDomain.description
    self.hostOnly = false
    return true
  }
  
  @discardableResult
  private mutating func _setPath(path:String?, requestPath:String) -> Bool {
    if let responsePath = path {
      self.path = responsePath
      return true
    } else {
      // If there's no attribute of "path"...
      if requestPath.isEmpty || !requestPath.hasPrefix("/") {
        self.path = "/"
      } else {
        let indexOfLastSlash = requestPath.range(of:"/", options:.backwards)!.lowerBound
        if indexOfLastSlash == requestPath.startIndex {
          self.path = "/"
        } else {
          self.path = String(requestPath[requestPath.startIndex..<indexOfLastSlash])
        }
      }
    }
    return true
  }
  
  /// If `url` is nil, no validity check for domain
  internal init?(_responseHeaderFieldValue:HeaderFieldValue,
                 for url:URL? = nil,
                 removingPercentEncoding:Bool = true)
  {
    let nilableRequestHost = url?.hostComponent
    if url != nil && nilableRequestHost == nil { return nil }
    
    let now = Date()
    let string = _responseHeaderFieldValue.rawValue
    let (nameValue, nilableAttributes) = string.splitOnce(separator:";")
    guard let item = CookieItem(string:String(nameValue),
                                removingPercentEncoding:removingPercentEncoding) else
    {
      return nil
    }
    
    self.init([:])
    self.name = item.name
    self.value = item.value
    self.creationDate = now
    self.lastAccessDate = now
    
    if let attributes_string = nilableAttributes {
      let attributes = _attributes(String(attributes_string))
      
      self.secure = attributes["secure"] != nil ? true: false
      self.httpOnly = attributes["httponly"] != nil ? true: false
      
      // Calc. Expiration
      guard self._setExpires(maxAge:attributes["max-age"], expires:attributes["expires"], now:now)
        else { return nil }
      
      // Domain
      if url != nil {
        guard self._setDomain(domain:attributes["domain"], requestHost:nilableRequestHost!) else {
          return nil
        }
      } else {
        self.domain = attributes["domain"]
      }
      
      // Path
      self._setPath(path:attributes["path"], requestPath:url?.path ?? "/")
    }
  }
  
  /// Initialize with the value of HTTP header "Set-Cookie:"
  public init?(responseHeaderFieldValue:HeaderFieldValue,
               for url:URL,
               removingPercentEncoding:Bool = true)
  {
    self.init(_responseHeaderFieldValue:responseHeaderFieldValue,
              for:url,
              removingPercentEncoding:removingPercentEncoding)
  }
}
