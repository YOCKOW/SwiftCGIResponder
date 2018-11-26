/* *************************************************************************************************
 CacheControlDirectiveSet.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
/// A set for `CacheControlDirective`
public struct CacheControlDirectiveSet {
  fileprivate enum _Key: Hashable {
    case `public`
    case `private`
    case noCache
    case onlyIfCached
    case maxAge
    case sMaxAge
    case maxStale
    case minFresh
    case staleWhileRevalidate
    case staleIfError
    case mustRevalidate
    case proxyRevalidate
    case immutable
    case noStore
    case noTransform
    case `extension`(name:String)
    
    fileprivate init(_ directive:CacheControlDirective) {
      switch directive {
      case .public: self = .public
      case .private: self = .private
      case .noCache: self = .noCache
      case .onlyIfCached: self = .onlyIfCached
      case .maxAge(_): self = .maxAge
      case .sMaxAge(_): self = .sMaxAge
      case .maxStale(_): self = .maxStale
      case .minFresh(_): self = .minFresh
      case .staleWhileRevalidate(_): self = .staleWhileRevalidate
      case .staleIfError(_): self = .staleIfError
      case .mustRevalidate: self = .mustRevalidate
      case .proxyRevalidate: self = .proxyRevalidate
      case .immutable: self = .immutable
      case .noStore: self = .noStore
      case .noTransform: self = .noTransform
      case .extension(let name, _): self = .extension(name:name)
      }
    }
  }
  
  private var _store: [_Key:CacheControlDirective] = [:]
  
  /// Returns a Boolean value that indicates whether the given directive exists in the set.
  public func contains(_ directive:CacheControlDirective) -> Bool {
    return self._store[_Key(directive)] == directive
  }
  
  /// Returns a Boolean value that indicates whether the same-case directive  exists in the set.
  public func contains(sameCaseWith directive:CacheControlDirective) -> Bool {
    return self._store[_Key(directive)] != nil
  }
  
  @discardableResult
  public mutating func insert(_ directive:CacheControlDirective) -> CacheControlDirective {
    let key = _Key(directive)
    defer { self._store[key] = directive }
    
    if let oldDirective = self._store[_Key(directive)] {
      return oldDirective
    } else {
      return directive
    }
  }
  
  /// Initialize the set with `directives`
  public init(_ directives:CacheControlDirective...) {
    self._store = [:]
    for directive in directives {
      self.insert(directive)
    }
  }
}

extension CacheControlDirectiveSet: Hashable {}

extension CacheControlDirectiveSet: HeaderFieldValueConvertible {
  public init?(httpHeaderFieldValue: HeaderFieldValue) {
    guard let tokens = httpHeaderFieldValue.rawValue._tokens else { return nil }
    guard let dictionary = Dictionary<String,String>(_tokens:tokens, pairsAreSeparatedBy:",") else {
      return nil
    }
    
    self.init()
    for (key, value) in dictionary {
      if value.isEmpty {
        guard let directive = CacheControlDirective(rawValue:key) else { return nil }
        self.insert(directive)
      } else {
        if let directive = CacheControlDirective(rawValue:"\(key)=\(value)") {
          self.insert(directive)
        } else if let directive = CacheControlDirective(rawValue:"\(key)=\"\(value)\"") {
          self.insert(directive)
        } else {
          return nil
        }
      }
    }
  }
  
  public var httpHeaderFieldValue: HeaderFieldValue {
    return HeaderFieldValue(rawValue:self._store.values.map{ $0.rawValue }.joined(separator:", "))!
  }
}

extension CacheControlDirectiveSet {
  internal var _directives: [CacheControlDirective] {
    return Array(self._store.values)
  }
}

extension CacheControlDirectiveSet: ExpressibleByArrayLiteral {
  public typealias ArrayLiteralElement = CacheControlDirective
  public init(arrayLiteral elements: CacheControlDirective...) {
    self._store = [:]
    for directive in elements {
      self.insert(directive)
    }
  }
}
