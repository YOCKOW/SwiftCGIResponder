/***************************************************************************************************
 HTTPHeaderFieldDelegate.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # HTTPHeaderFieldDelegate
 Holds an instance of `HTTPHeaderFieldName`, and computes an instance of `HTTPHeaderFieldValue`.
 
 */
open class HTTPHeaderFieldDelegate {
  open var name: HTTPHeaderFieldName
  open var value: HTTPHeaderFieldValue
  public init?(name: HTTPHeaderFieldName, value: HTTPHeaderFieldValue) {
    self.name = name
    self.value = value
  }
  public func isEqual(to another:HTTPHeaderFieldDelegate) -> Bool {
    return self.name == another.name && self.value == another.value
  }
}
extension HTTPHeaderFieldDelegate: CustomStringConvertible {
  public var description: String {
    return "\(self.name.rawValue): \(self.value.rawValue)\r\n"
  }
}
extension HTTPHeaderFieldDelegate: Hashable {
  open var hashValue: Int { return self.name.hashValue ^ self.value.hashValue }
  public static func ==(lhs: HTTPHeaderFieldDelegate, rhs: HTTPHeaderFieldDelegate) -> Bool {
    return lhs.isEqual(to:rhs)
  }
}

/**
 
 # UnspecifiedHTTPHeaderFieldDelegate
 Internal use for unspecified fields...
 
 */
internal class UnspecifiedHTTPHeaderFieldDelegate: HTTPHeaderFieldDelegate { }

/**
 
 # SpecifiedHTTPHeaderFieldDelegate
 Designed for implementation in subclasses
 
 */
open class SpecifiedHTTPHeaderFieldDelegate: HTTPHeaderFieldDelegate {
  open class var name: HTTPHeaderFieldName {
    return HTTPHeaderFieldName(rawValue:"X-CGIResponder-Requires-Concrete-Implementation")!
  }
  
  open override var name: HTTPHeaderFieldName {
    get { return type(of:self).name }
    set {
      guard newValue == type(of:self).name else { fatalError("Cannot change my name.") }
    }
  }
  
  public required init?(value:HTTPHeaderFieldValue) {
    super.init(name:type(of:self).name, value:value)
  }
}

/**
 
 # DuplicableHTTPHeaderFieldDelegate
 Duplicable header field, for example, "Set-Cookie:"
 
 */
open class DuplicableHTTPHeaderFieldDelegate: SpecifiedHTTPHeaderFieldDelegate { }

/**
 
 # AppendableHTTPHeaderFieldDelegate
 Appendable header field, for example, "Cache-Control:"
 
 */
open class AppendableHTTPHeaderFieldDelegate: SpecifiedHTTPHeaderFieldDelegate {
  public func append(_ value:HTTPHeaderFieldValue) throws {
    fatalError("append(_:) must be overriden in subclass implementations")
  }
  public func append(_ field:HTTPHeaderField) throws {
    fatalError("append(_:) must be overriden in subclass implementations")
  }
}

