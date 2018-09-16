/***************************************************************************************************
 CacheControl.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
 
/**
 
 # HTTPHeaderFieldDelegate.CacheControl
 Representes for HTTP Header Field "Cache-Control"
 
 */
extension HTTPHeaderFieldDelegate {
  public class CacheControl: AppendableHTTPHeaderFieldDelegate {
    public override class var name: HTTPHeaderFieldName { return HTTPHeaderFieldName.cacheControl }
    
    private var _directives: [CacheControlDirective]
    public var directives: [CacheControlDirective] {
      get { return self._directives }
      set { self._directives = newValue.arranged() }
    }
    public override var hashValue: Int {
      var hh = 0
      for directive in self.directives { hh ^= directive.hashValue }
      return hh
    }
    public override var value: HTTPHeaderFieldValue {
      get {
        return HTTPHeaderFieldValue(rawValue: self.directives.map{ $0.rawValue }.joined(separator:", "))!
      }
      set {
        guard let newDirectives = Array<CacheControlDirective>(newValue) else {
          fatalError("Invalid Field Value: \(newValue.rawValue)")
        }
        self.directives = newDirectives
      }
    }
    
    public init(directives:[CacheControlDirective]) {
      self._directives = directives.arranged()
      super.init(value:HTTPHeaderFieldValue(rawValue:"")!)! // dummy
    }
    
    public required convenience init?(value:HTTPHeaderFieldValue) {
      guard let directives = Array<CacheControlDirective>(value) else { return nil }
      self.init(directives:directives)
    }
    
    public override func append(_ value:HTTPHeaderFieldValue) throws {
      guard let directive = CacheControlDirective(rawValue:value.rawValue) else {
        throw CGIResponderError.invalidArgument
      }
      self.directives.append(directive)
    }
    
    public func append(_ directive:CacheControlDirective) {
      self.directives.append(directive)
    }
  }
}

/// Extend `HTTPHeaderField` to be initialized with `directives`
public extension HTTPHeaderField {
  public init(cacheControlDirectives directives:[CacheControlDirective]) {
    self.init(delegate:HTTPHeaderFieldDelegate.CacheControl(directives:directives))
  }
}

