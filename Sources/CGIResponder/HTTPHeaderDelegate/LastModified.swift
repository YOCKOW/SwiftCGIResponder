/***************************************************************************************************
 LastModified.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # HTTPHeaderFieldDelegate.LastModified
 Representes for HTTP Header Field "Last-Modified"
 
 */
extension HTTPHeaderFieldDelegate {
  public class LastModified: SpecifiedHTTPHeaderFieldDelegate {
    public override class var name: HTTPHeaderFieldName { return HTTPHeaderFieldName.lastModified }
    
    public var date: Date
    public override var hashValue: Int { return date.hashValue }
    public override var value: HTTPHeaderFieldValue {
      get { return HTTPHeaderFieldValue(rawValue:DateFormatter.rfc1123.string(from:self.date))! }
      set {
        guard let newDate = DateFormatter.rfc1123.date(from:newValue.rawValue) else {
          fatalError("Invalid Date String")
        }
        self.date = newDate
      }
    }
    
    public override func isEqual(to another:HTTPHeaderFieldDelegate) -> Bool {
      guard case let anotherDelegate as LastModified = another else { return false }
      return self.date == anotherDelegate.date
    }
    
    public init(_ date:Date) {
      self.date = date
      super.init(value:HTTPHeaderFieldValue(rawValue:"")!)! // dummy
    }
    
    public required convenience init?(value:HTTPHeaderFieldValue) {
      guard let date = DateFormatter.rfc1123.date(from:value.rawValue) else { return nil }
      self.init(date)
    }
  }
}

/// Extend `HTTPHeaderField` to be initialized with `date`
extension HTTPHeaderField {
  public init(lastModified date:Date) {
    self.init(delegate:HTTPHeaderFieldDelegate.LastModified(date))
  }
}


