/***************************************************************************************************
 ContentLength.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # HTTPHeaderFieldDelegate.ContentLength
 Representes for HTTP Header Field "Content-Length"
 
 */
extension HTTPHeaderFieldDelegate {
  public class ContentLength: SpecifiedHTTPHeaderFieldDelegate {
    public override class var name: HTTPHeaderFieldName { return HTTPHeaderFieldName.contentLength }
    public var length: UInt
    public override var hashValue: Int { return Int(self.length) }
    public override var value: HTTPHeaderFieldValue {
      get { return HTTPHeaderFieldValue(rawValue:String(self.length))! }
      set {
        guard let newLength = UInt(newValue.rawValue) else { self.length = 0; return }
        self.length = newLength
      }
    }
    public override func isEqual(to another:HTTPHeaderFieldDelegate) -> Bool {
      guard case let anotherContentLength as ContentLength = another else { return false }
      return self.length == anotherContentLength.length
    }
    
    public init(_ length:UInt) {
      self.length = length
      super.init(value:HTTPHeaderFieldValue(rawValue:"")!)! // dummy
    }
    
    public required convenience init?(value: HTTPHeaderFieldValue) {
      guard let length = UInt(value.rawValue) else { return nil }
      self.init(length)
    }
  }
}

/// Extend `HTTPHeaderField` to be initialized with `contentLength`
extension HTTPHeaderField {
  public init(contentLength:UInt) {
    self.init(delegate:HTTPHeaderFieldDelegate.ContentLength(contentLength))
  }
}

