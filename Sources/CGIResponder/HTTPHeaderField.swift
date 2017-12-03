/***************************************************************************************************
 HTTPHeaderField.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # HTTPHeaderField
 Represents for each HTTP Header Field
 
 */

public struct HTTPHeaderField {
  public private(set) var delegate: HTTPHeaderFieldDelegate
  public init(delegate: HTTPHeaderFieldDelegate) { self.delegate = delegate }
}

extension HTTPHeaderField {
  public var name: HTTPHeaderFieldName { return self.delegate.name }
  public var value: HTTPHeaderFieldValue { return self.delegate.value }
  public var isAppendable: Bool { return self.delegate is AppendableHTTPHeaderFieldDelegate }
  public var isDuplicable: Bool { return self.delegate is DuplicableHTTPHeaderFieldDelegate }
}

extension HTTPHeaderField {
  /// Append field value to the header only if the header is able to have multiple values
  public mutating func append(_ value: HTTPHeaderFieldValue) throws {
    if case let delegate as AppendableHTTPHeaderFieldDelegate = self.delegate {
      try delegate.append(value)
    } else {
      warn("Unappendable header: \(delegate.name)")
      throw CGIResponderError.illegalOperation
    }
  }
}

extension HTTPHeaderField: CustomStringConvertible {
  public var description: String {
    return self.delegate.description
  }
}
