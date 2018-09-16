/***************************************************************************************************
 ContentTransferEncoding.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # HTTPHeaderFieldDelegate.ContentTransferEncoding
 Representes for HTTP Header Field "Content-Transfer-Encoding"
 
 */
extension HTTPHeaderFieldDelegate {
  public class ContentTransferEncoding: SpecifiedHTTPHeaderFieldDelegate {
    public override class var name: HTTPHeaderFieldName { return .contentTransferEncoding }
    public var contentTransferEncoding: ContentTransferEncodingRepresentation
    public override var hashValue: Int { return self.contentTransferEncoding.hashValue }
    public override var value: HTTPHeaderFieldValue {
      get { return HTTPHeaderFieldValue(rawValue:self.contentTransferEncoding.rawValue)! }
      set {
        guard let newEncoding = ContentTransferEncodingRepresentation(rawValue:newValue.rawValue) else {
          fatalError("Invalid Content-Transfer-Encoding.")
        }
        self.contentTransferEncoding = newEncoding
      }
    }
    public override func isEqual(to another:HTTPHeaderFieldDelegate) -> Bool {
      guard case let anotherContentTransferEncoding as ContentTransferEncoding = another else {
        return false
      }
      return self.contentTransferEncoding == anotherContentTransferEncoding.contentTransferEncoding
    }
    
    /// Initialize from an instance of `ContentTransferEncodingRepresentation`
    public init(_ contentTransferEncoding:ContentTransferEncodingRepresentation) {
      self.contentTransferEncoding = contentTransferEncoding
      super.init(value:HTTPHeaderFieldValue(rawValue:"")!)! // dummy
    }
    
    public required convenience init?(value: HTTPHeaderFieldValue) {
      guard let encoding = ContentTransferEncodingRepresentation(rawValue:value.rawValue) else {
        return nil
      }
      self.init(encoding)
    }
  }
}

/// Extend `HTTPHeaderField` to be initialized with `contentTransferEncoding`
extension HTTPHeaderField {
  public init(contentTransferEncoding:ContentTransferEncodingRepresentation) {
    self.init(delegate:HTTPHeaderFieldDelegate.ContentTransferEncoding(contentTransferEncoding))
  }
}




