/***************************************************************************************************
 ContentType.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # HTTPHeaderFieldDelegate.ContentType
 Representes for HTTP Header Field "Content-Length"
 
 */
extension HTTPHeaderFieldDelegate {
  public class ContentType: SpecifiedHTTPHeaderFieldDelegate {
    public override class var name: HTTPHeaderFieldName { return HTTPHeaderFieldName.contentType }
    public var contentType: MIMEType
    public override var hashValue: Int { return self.contentType.hashValue }
    public override var value: HTTPHeaderFieldValue {
      get { return HTTPHeaderFieldValue(rawValue:self.contentType.description)! }
      set {
        guard let newContentType = MIMEType(newValue.rawValue) else { fatalError("Invalid Content-Type.") }
        self.contentType = newContentType
      }
    }
    public override func isEqual(to another:HTTPHeaderFieldDelegate) -> Bool {
      guard case let anotherContentType as ContentType = another else { return false }
      return self.contentType == anotherContentType.contentType
    }
    
    /// Initialize from an instance of `MIMEType`
    public init(_ contentType:MIMEType) {
      self.contentType = contentType
      super.init(value:HTTPHeaderFieldValue(rawValue:"")!)! // dummy
    }
    
    public required convenience init?(value: HTTPHeaderFieldValue) {
      guard let contentType = MIMEType(value.rawValue) else { return nil }
      self.init(contentType)
    }
  }
}

/// Extend `HTTPHeaderField` to be initialized with `contentType`
extension HTTPHeaderField {
  public init(contentType:MIMEType) {
    self.init(delegate:HTTPHeaderFieldDelegate.ContentType(contentType))
  }
}


