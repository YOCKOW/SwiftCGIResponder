/***************************************************************************************************
 SetCookie.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

extension HTTPHeaderFieldDelegate {
  /**
   
   # HTTPHeaderFieldDelegate.SetCookie
   Representes for HTTP Header Field "Set-Cookie:"
   
   ## Caution
   Although you can set the cookie from `HTTPHeaderFieldValue`(response header field value),
   in that way, an insecure and inaccurate cookie may be made or no cookie may be baked.
   That is the reason why you should set the cookie directly.
   
   */
  public class SetCookie<Cookie>: DuplicableHTTPHeaderFieldDelegate where Cookie: RFC6265Cookie {
    public override class var name: HTTPHeaderFieldName { return HTTPHeaderFieldName.setCookie }
    
    // Bake a cookie from `HTTPHeaderFieldValue` as far as possible.
    private enum _Ingredient {
      case cookie(Cookie)
      case attributes([String:String])
    }
    private enum _BakingError: Error { case error(String) }
    private static func _pseudoRequestURL(with ingredient:_Ingredient) throws -> URL {
      let scheme: String = ({
        switch $0 {
        case .cookie(let cookie): return cookie.isSecure ? true : false
        case .attributes(let attributes): return attributes.keys.contains("secure") ? true : false
        }
      })(ingredient) ? "https" : "http"
      
      let host: URL.Host = try ({
        switch $0 {
        case .cookie(let cookie): return URL.Host(string:cookie.domain)!
        case .attributes(let attributes):
          if let domain = attributes["domain"] {
            return URL.Host(string:domain)!
          } else {
            // !!
            // This way is insecure and inaccurate
            // because determine the domain from environment variables
            // !!
            if let hostname = Client.client.hostname {
              return URL.Host.name(hostname)
            } else if let serverName = Server.server.hostname {
              return URL.Host.name(serverName)
            } else if let requestIP = Client.client.ipAddress {
              return URL.Host.ipAddress(requestIP)
            } else if let serverIP = Server.server.ipAddress {
              return URL.Host.ipAddress(serverIP)
            }
          }
        }
        throw _BakingError.error("Cannot determine the expected domain name for the cookie.")
      })(ingredient)
      
      return URL(string:"\(scheme)://\(host.description)/")!
    }
    private static func _bakeCookie(from fieldValue:HTTPHeaderFieldValue,
                                    with ingredient:_Ingredient) throws -> Cookie {
      let url = try _pseudoRequestURL(with:ingredient)
      guard let cookie = Cookie(withResponseHeaderFieldValue:fieldValue, for:url) else {
        throw _BakingError.error("Failed to bake a cookie from \"\(fieldValue)\"")
      }
      return cookie
    }
    // end of "cookie baker"
    
    public var cookie: Cookie
    public override var hashValue: Int { return self.cookie.hashValue }
    public override var value: HTTPHeaderFieldValue {
      get {
        return self.cookie.responseHeaderFieldValue()!
      }
      set {
        self.cookie = try! SetCookie._bakeCookie(from:newValue, with:.cookie(self.cookie))
      }
    }

    public override func isEqual(to another: HTTPHeaderFieldDelegate) -> Bool {
      guard case let anotherDelegate as SetCookie = another else { return false }
      return self.cookie == anotherDelegate.cookie
    }

    public init(_ cookie:Cookie) {
      self.cookie = cookie
      super.init(value:HTTPHeaderFieldValue(rawValue:"")!)! // dummy
    }

    public required convenience init?(value:HTTPHeaderFieldValue) {
      do {
        guard let attributes = Cookie._itemAndAttributes(fromResponseHeaderFieldValue:value,
                                                         removingPercentEncoding:true)?.1 else {
           return nil
        }
        let cookie = try SetCookie._bakeCookie(from:value,
                                               with:.attributes(attributes))
        self.init(cookie)
      } catch _BakingError.error(let message) {
        warn(message)
        return nil
      } catch {
        return nil
      }
    }
  }
}

/// Extend `HTTPHeaderField` to be initialized with `cookie`
extension HTTPHeaderField {
  public init<Cookie: RFC6265Cookie>(setCookie cookie:Cookie) {
    self.init(delegate:DuplicableHTTPHeaderFieldDelegate.SetCookie(cookie))
  }
}
