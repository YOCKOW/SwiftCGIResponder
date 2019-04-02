/* *************************************************************************************************
 CacheControlDirective.swift
   © 2017-2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
import BonaFideCharacterSet
import yExtensions

/**
 
 # CacheControlDirective
 Reporesents directives of Cache-Control
 
 ## References
 * [RFC7234](https://tools.ietf.org/html/rfc7234)
 * [Cache-Control - HTTP | MDN](https://developer.mozilla.org/en/docs/Web/HTTP/Headers/Cache-Control)
 
 */
public enum CacheControlDirective {
  case `public`
  case `private`
  case noCache
  case onlyIfCached
  case maxAge(UInt)
  case sMaxAge(UInt)
  case maxStale(UInt?)
  case minFresh(UInt)
  case staleWhileRevalidate(UInt)
  case staleIfError(UInt)
  case mustRevalidate
  case proxyRevalidate
  case immutable
  case noStore
  case noTransform
  case `extension`(name:String, value:String)
}

extension CacheControlDirective: RawRepresentable {
  public init?(rawValue:String) {
    let string = rawValue.lowercased()
    switch string {
    case "public": self = .public
    case "private": self = .private
    case "no-cache": self = .noCache
    case "only-if-cached": self = .onlyIfCached
    case "max-stale": self = .maxStale(nil)
    case "must-revalidate": self = .mustRevalidate
    case "proxy-revalidate": self = .proxyRevalidate
    case "immutable": self = .immutable
    case "no-store": self = .noStore
    case "no-transform": self = .noTransform
    default:
      let nameAndValue = string.splitOnce(separator:"=")
      let name = nameAndValue.0
      guard let value = nameAndValue.1 else { return nil }
      let nilableSeconds = UInt(value)
      switch name {
      case "max-age":
        guard let seconds = nilableSeconds else { return nil }
        self = .maxAge(seconds)
      case "s-maxage":
        guard let seconds = nilableSeconds else { return nil }
        self = .sMaxAge(seconds)
      case "max-stale":
        guard let seconds = nilableSeconds else { return nil }
        self = .maxStale(seconds)
      case "min-fresh":
        guard let seconds = nilableSeconds else { return nil }
        self = .minFresh(seconds)
      case "stale-while-revalidate":
        guard let seconds = nilableSeconds else { return nil }
        self = .staleWhileRevalidate(seconds)
      case "stale-if-error":
        guard let seconds = nilableSeconds else { return nil }
        self = .staleIfError(seconds)
      default:
        guard name.consists(of:.httpTokenAllowed) else { return nil }
        let unquotedValue = value._unquotedString ?? String(value)
        guard unquotedValue.consists(of:.httpEscapableUnicodeScalars) else { return nil }
        self = .extension(name:String(name), value:unquotedValue)
      }
    }
  }
  
  public var rawValue: String {
    switch self {
    case .public: return "public"
    case .private: return "private"
    case .noCache: return "no-cache"
    case .onlyIfCached: return "only-if-cached"
    case .maxAge(let seconds): return "max-age=\(seconds)"
    case .sMaxAge(let seconds): return "s-maxage=\(seconds)"
    case .maxStale(let seconds?): return "max-stale=\(seconds)"
    case .maxStale: return "max-stale"
    case .minFresh(let seconds): return "min-fresh=\(seconds)"
    case .staleWhileRevalidate(let seconds): return "stale-while-revalidate=\(seconds)"
    case .staleIfError(let seconds): return "stale-if-error=\(seconds)"
    case .mustRevalidate: return "must-revalidate"
    case .proxyRevalidate: return "proxy-revalidate"
    case .immutable: return "immutable"
    case .noStore: return "no-store"
    case .noTransform: return "no-transform"
    case .extension(let name, let value):
      guard name.consists(of:.httpTokenAllowed) &&
            value.consists(of:.httpEscapableUnicodeScalars) else
      {
        fatalError("Invalid unicode scalar is contained.")
      }
      return "\(name)=\(value._quotedString!)"
    }
  }
}

extension CacheControlDirective: Hashable {
  public static func ==(lhs:CacheControlDirective, rhs:CacheControlDirective) -> Bool {
    switch (lhs, rhs) {
    case (.public, .public): return true
    case (.private, .private): return true
    case (.noCache, .noCache): return true
    case (.onlyIfCached, .onlyIfCached): return true
    case (.mustRevalidate, .mustRevalidate): return true
    case (.proxyRevalidate, .proxyRevalidate): return true
    case (.immutable, .immutable): return true
    case (.noStore, .noStore): return true
    case (.noTransform, .noTransform): return true
    case (.maxAge(let lsec), .maxAge(let rsec)): return lsec == rsec
    case (.sMaxAge(let lsec), .sMaxAge(let rsec)): return lsec == rsec
    case (.maxStale(let lsec?), .maxStale(let rsec?)): return lsec == rsec
    case (.maxStale(let lsec), .maxStale(let rsec)): return lsec == nil && rsec == nil
    case (.minFresh(let lsec), .minFresh(let rsec)): return lsec == rsec
    case (.staleWhileRevalidate(let lsec), .staleWhileRevalidate(let rsec)): return lsec == rsec
    case (.staleIfError(let lsec), .staleIfError(let rsec)): return lsec == rsec
    case (.extension(let ln, let lv), .extension(let rn, let rv)): return ln == rn && lv == rv
    default: return false
    }
  }
  
  public func hash(into hasher:inout Hasher) {
    hasher.combine(self.rawValue)
  }
}

infix operator =~
infix operator !~
extension CacheControlDirective {
  internal static func =~(lhs:CacheControlDirective, rhs:CacheControlDirective) -> Bool {
    switch (lhs, rhs) {
    case (.public, .public): return true
    case (.private, .private): return true
    case (.noCache, .noCache): return true
    case (.onlyIfCached, .onlyIfCached): return true
    case (.maxAge, .maxAge): return true
    case (.sMaxAge, .sMaxAge): return true
    case (.maxStale, .maxStale): return true
    case (.minFresh, .minFresh): return true
    case (.staleWhileRevalidate, .staleWhileRevalidate): return true
    case (.staleIfError, .staleIfError): return true
    case (.mustRevalidate, .mustRevalidate): return true
    case (.proxyRevalidate, .proxyRevalidate): return true
    case (.immutable, .immutable): return true
    case (.noStore, .noStore): return true
    case (.noTransform, .noTransform): return true
    case (.extension(let ln, _), .extension(let rn, _)): return ln == rn
    default: return false
    }
  }
  
  internal static func !~(lhs:CacheControlDirective, rhs:CacheControlDirective) -> Bool {
    return (lhs =~ rhs) ? false : true
  }
}

