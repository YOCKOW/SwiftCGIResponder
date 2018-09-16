/***************************************************************************************************
 ContentDisposition.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # HTTPHeaderFieldDelegate.ContentDisposition
 Representes for HTTP Header Field "Content-Disposition"
 
 */
extension HTTPHeaderFieldDelegate {
  public class ContentDisposition: SpecifiedHTTPHeaderFieldDelegate {
    public override class var name: HTTPHeaderFieldName { return HTTPHeaderFieldName.contentDisposition }
    public var contentDisposition: ContentDispositionRepresentation
    public override var hashValue: Int { return self.contentDisposition.hashValue }
    public override var value: HTTPHeaderFieldValue {
      get { return HTTPHeaderFieldValue(rawValue:self.contentDisposition.description)! }
      set {
        guard let newDisposition = ContentDispositionRepresentation(newValue.rawValue) else {
          fatalError("Invalid Content-Disposition.")
        }
        self.contentDisposition = newDisposition
      }
    }
    public override func isEqual(to another:HTTPHeaderFieldDelegate) -> Bool {
      guard case let anotherContentDisposition as ContentDisposition = another else { return false }
      return self.contentDisposition == anotherContentDisposition.contentDisposition
    }
    
    /// Initialize from an instance of `ContentDispositionRepresentation`
    public init(_ contentDisposition:ContentDispositionRepresentation) {
      self.contentDisposition = contentDisposition
      super.init(value:HTTPHeaderFieldValue(rawValue:"")!)! // dummy
    }
    
    public required convenience init?(value: HTTPHeaderFieldValue) {
      guard let contentDisposition = ContentDispositionRepresentation(value.rawValue) else {
        return nil
      }
      self.init(contentDisposition)
    }
  }
}

/// Extend `HTTPHeaderField` to be initialized with `contentDisposition`
extension HTTPHeaderField {
  public init(contentDisposition:ContentDispositionRepresentation) {
    self.init(delegate:HTTPHeaderFieldDelegate.ContentDisposition(contentDisposition))
  }
}



