/* *************************************************************************************************
 CacheControlDirective.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
import BonaFideCharacterSet

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
      let keyAndValue = string.components(separatedBy:"=")
      guard keyAndValue.count == 2 else  { return nil }
      guard let seconds = UInt(keyAndValue[1]) else { return nil }
      switch keyAndValue[0] {
      case "max-age": self = .maxAge(seconds)
      case "s-maxage": self = .sMaxAge(seconds)
      case "max-stale": self = .maxStale(seconds)
      case "min-fresh": self = .minFresh(seconds)
      case "stale-while-revalidate": self = .staleWhileRevalidate(seconds)
      case "stale-if-error": self = .staleIfError(seconds)
      default: return nil
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
    default: return false
    }
  }
  
  #if swift(>=4.2)
  public func hash(into hasher:inout Hasher) {
    hasher.combine(self.rawValue)
  }
  #else
  public var hashValue: Int {
    return self.rawValue.hashValue
  }
  #endif
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
    default: return false
    }
  }
  
  internal static func !~(lhs:CacheControlDirective, rhs:CacheControlDirective) -> Bool {
    return (lhs =~ rhs) ? false : true
  }
}

extension Array where Element == CacheControlDirective {
  private mutating func _normalize() {
    var result: [CacheControlDirective] = []
    scan: for ii in 0..<self.count {
      let item = self[ii]
      for jj in 0..<result.count {
        if item =~ result[jj] { continue scan }
      }
      result.append(item)
    }
    self = result
  }
  
  /// init with string
  internal init?(string:String) {
    let directiveStrings = string.components(separatedBy:",").map{ $0.trimmingUnicodeScalars(in:.whitespaces) }
    self.init()
    for ss in directiveStrings {
      guard let directive = CacheControlDirective(rawValue:ss) else {
        return nil
      }
      self.append(directive)
    }
    self._normalize()
  }
}

