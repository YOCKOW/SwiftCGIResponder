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

extension RFC6265Cookie {
  /// Create value of "Set-Cookie:"
  public func responseHeaderFieldValue(addingPercentEncoding:Bool = true) -> HTTPHeaderFieldValue? {
    guard var string = self.nameValuePair(addingPercentEncoding:addingPercentEncoding) else { return nil }
    
    if let expires = self.expiresDate {
      string += "; Expires=" + DateFormatter.rfc1123.string(from:expires)
    }
    
    string += "; Domain=" + self.domain
    string += "; Path=" + self.path
    
    if self.isSecure { string += "; Secure" }
    if self.isHTTPOnly { string += "; HttpOnly" }
    
    return HTTPHeaderFieldValue(rawValue:string)!
  }
}

extension RFC6265Cookie {
  /// Create stuff to make properties of cookies.
  internal static func _itemAndAttributes(
    fromResponseHeaderFieldValue value:HTTPHeaderFieldValue,
    removingPercentEncoding:Bool
  ) -> (HTTPCookieItem, [String:String])? {
    // First, split
    var parameters = value.rawValue.components(separatedBy:";").map {
      $0.trimmingCharacters(in:.whitespaces)
    }
    
    // cookie's name and value
    guard let cookieItem = HTTPCookieItem(string:parameters.removeFirst(),
                                          removingPercentEncoding:removingPercentEncoding)
      else {
        return nil
    }
    
    // handle remaining attributes
    var attributeList: [String:String] = [:]
    for parameter in parameters {
      let nameAndValue = parameter.splitOnce(separator:"=")
      
      let name = String(nameAndValue.0).trimmingCharacters(in:.whitespaces).lowercased()
      let value:String = (nameAndValue.1 != nil) ? String(nameAndValue.1!).trimmingCharacters(in:.whitespaces) : ""
      
      attributeList[name] = value
    }
    
    return (cookieItem, attributeList)
  }
}

extension RFC6265Cookie {
  /// Initialize from an instance of `HTTPHeaderFieldValue`
  public init?(withResponseHeaderFieldValue value:HTTPHeaderFieldValue,
               for url:URL,
               removingPercentEncoding:Bool = true) {
    guard let requestHostComponent = url.hostComponent else { return nil }
    
    guard let attributes = Self._itemAndAttributes(fromResponseHeaderFieldValue:value,
                                                   removingPercentEncoding:removingPercentEncoding) else {
      return nil
    }
    
    let (cookieItem, attributeList) = attributes
    
    // Expires
    var expires: Date? = nil
    var persistent: Bool = true
    if let maxAgeString = attributeList["max-age"], let maxAge = TimeInterval(maxAgeString) {
      expires = Date(timeIntervalSinceNow:maxAge)
    } else if let expiresString = attributeList["expires"] {
      expires = Date(cookieDateString:expiresString)
      if expires == nil { return nil } // unknown format
    } else {
      persistent = false
    }
    
    // Domain
    var domain: String = ""
    var hostOnly: Bool = true
    if let attrDomain = attributeList["domain"] {
      domain = attrDomain.trimmingCharacters(in:BonaFideCharacterSet(charactersIn:"."))
    }
    guard let attrHostComponent = URL.Host(string:domain) else { return nil }
    if case .name(let attrHostname) = attrHostComponent {
      if attrHostname.isPublicSuffix {
        guard attrHostComponent == requestHostComponent else { return nil }
        domain = ""
      } else {
        guard case .name(let requestHostname) = requestHostComponent else { return nil }
        guard requestHostname.domainMatches(attrHostname) else { return nil }
        domain = attrHostname._domainName
        hostOnly = false
      }
    } else {
      // It is an IP Address
      guard attrHostComponent == requestHostComponent else { return nil }
    }
    if domain.isEmpty {
      // `domain` is empty if:
      //   * There is no attribute named "Domain",
      //   * The value of "Domain" is an IP Address, or
      //   * The value of "Domain" is the public suffix and is equal to request host-name
      domain = requestHostComponent.description
      hostOnly = true
    }
    
    // Path
    var path: String = "/"
    if let attrPath = attributeList["path"] {
      path = attrPath
    } else {
      path = ({ (requestPath:String) -> String in
        guard !requestPath.isEmpty && requestPath.hasPrefix("/") else { return "/" }
        let indexOfLastSlash = requestPath.range(of:"/", options:.backwards)!.lowerBound
        if indexOfLastSlash == requestPath.startIndex { return "/" }
        return String(requestPath[requestPath.startIndex ..< indexOfLastSlash])
      })(url.path)
    }
    
    // Secure
    let secure: Bool = attributeList.keys.contains("secure") ? true : false
    
    // HttpOnly
    let httpOnly: Bool = attributeList.keys.contains("httponly") ? true : false
    
    let now = Date()
    
    var properties: [HTTPCookiePropertyKey:Any] = [
      .name:cookieItem.name,
      .value:cookieItem.value,
      .domain:domain,
      .path:path
    ]
    properties.creationDate = now
    properties.expiresDate = expires
    properties.lastAccessDate = now
    properties.persistent = persistent
    properties.hostOnly = hostOnly
    properties.secure = secure
    properties.httpOnly = httpOnly
    
    self.init(properties:properties)
  }
}
