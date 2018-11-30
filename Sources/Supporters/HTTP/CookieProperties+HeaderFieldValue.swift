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

extension CookieProperties {
  private mutating func _setExpires(_ attributes:[String:String], _ now:Date) -> Bool {
    let (expires, persistent):(Date?, Bool) = ({ () -> (Date?, Bool) in
      if let maxAgeString = attributes["max-age"], let maxAge = TimeInterval(maxAgeString) {
        return (now.addingTimeInterval(maxAge), true)
      } else if let expiresString = attributes["expires"] {
        return (Date(cookieDateString:expiresString), true)
      } else {
        return (nil, false)
      }
    })()
    if expires == nil && persistent { return false }
    self.expiresDate = expires
    self.persistent = persistent
    return true
  }
  
  private mutating func __setHostOnlyTrue(_ requestHost:URL.Host) {
    // Host-Only-Flag is true when:
    //   * There is no attribute named "Domain",
    //   * The value of "Domain" is an IP Address, or
    //   * The value of "Domain" is the public suffix and is equal to request host-name
    self.domain = requestHost.description
    self.hostOnly = true
  }
  private mutating func _setDomain(_ attributes:[String:String], _ requestHost:URL.Host) -> Bool {
    if let attrDomainString = attributes["domain"] {
      let attrHost = URL.Host(string:attrDomainString)
      if attrHost.isIPAddress {
        guard attrHost == requestHost else { return false }
        self.__setHostOnlyTrue(requestHost)
        return true
      }
      
      guard let attrDomain = Domain(attrDomainString, options:.loose) else { return false }
      if attrDomain.isPublicSuffix {
        guard attrHost == requestHost else { return false }
        self.__setHostOnlyTrue(requestHost)
        return true
      }
      
      guard requestHost.domainMatches(attrHost) else { return false }
      self.domain = attrDomain.description
      self.hostOnly = false
      return true
      
    } else {
      self.__setHostOnlyTrue(requestHost)
      return true
    }
  }
  
  private mutating func _setPath(_ attributes:[String:String], _ requestPath:String) {
    if let attrPath = attributes["path"] {
      self.path = attrPath
    } else {
      self.path = ({ (requestPath:String) -> String in
        guard !requestPath.isEmpty && requestPath.hasPrefix("/") else { return "/" }
        let indexOfLastSlash = requestPath.range(of:"/", options:.backwards)!.lowerBound
        if indexOfLastSlash == requestPath.startIndex { return "/" }
        return String(requestPath[requestPath.startIndex ..< indexOfLastSlash])
      })(requestPath)
    }
  }
  
  /// Initialize with the value of HTTP header "Set-Cookie:"
  public init?(responseHeaderFieldValue:HeaderFieldValue,
               for url:URL,
               removingPercentEncoding:Bool = true)
  {
    guard let requestHost = url.hostComponent else { return nil }
    
    let now = Date()
    let string = responseHeaderFieldValue.rawValue
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
      guard self._setExpires(attributes, now) else { return nil }
      
      // Domain
      guard self._setDomain(attributes, requestHost) else { return nil }
      
      // Path
      self._setPath(attributes, url.path)
    }
  }
}
