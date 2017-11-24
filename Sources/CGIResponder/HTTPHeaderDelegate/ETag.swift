/***************************************************************************************************
 ETag.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # HTTPHeaderFieldDelegate.ETag
 Representes for HTTP Header Field "ETag"
 
 */
extension HTTPHeaderFieldDelegate {
  public class ETag: SpecifiedHTTPHeaderFieldDelegate {
    public override class var name: HTTPHeaderFieldName { return HTTPHeaderFieldName.eTag }
    
    public var eTag: HTTPETag
    public override var hashValue: Int { return self.eTag.hashValue }
    public override var value: HTTPHeaderFieldValue {
      get { return HTTPHeaderFieldValue(rawValue:self.eTag.description)! }
      set {
        guard let newETagValue = HTTPETag(newValue.rawValue) else { fatalError("Invalid ETag Value.") }
        self.eTag = newETagValue
      }
    }
    
    public override func isEqual(to another: HTTPHeaderFieldDelegate) -> Bool {
      guard case let anotherDelegate as ETag = another else { return false }
      return self.eTag == anotherDelegate.eTag
    }
    
    public init(_ eTag:HTTPETag) {
      self.eTag = eTag
      super.init(value:HTTPHeaderFieldValue(rawValue:"")!)! // dummy
    }
    
    public required convenience init?(value:HTTPHeaderFieldValue) {
      guard let eTag = HTTPETag(value.rawValue) else { return nil }
      self.init(eTag)
    }
  }
}

/// Extend `HTTPHeaderField` to be initialized with `directives`
public extension HTTPHeaderField {
  public init(eTag:HTTPETag) {
    self.init(delegate:HTTPHeaderFieldDelegate.ETag(eTag))
  }
}


