/* *************************************************************************************************
 Names.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet
import yExtensions

private func _validateNCName(_ string:String) -> Bool {
  guard
    let firstScalar = string.unicodeScalars.first,
    UnicodeScalarSet.xmlNameStartCharacterScalars.contains(firstScalar) else { return false }
  guard string.consists(of:.xmlNoncolonizedNameScalars) else { return false }
  return true
}

/// Represents [NCName](https://www.w3.org/TR/REC-xml-names/#NT-NCName).
public struct NoncolonizedName: CustomStringConvertible,
                                RawRepresentable,
                                ExpressibleByStringLiteral,
                                Hashable
{
  public typealias RawValue = String
  public typealias StringLiteralType = String
  
  private let _string:String
  public var description: String { return self._string }
  public var rawValue: String { return self._string }
  
  private init(uncheckedString:String) {
    self._string = uncheckedString
  }
  
  public init?(_ string:String) {
    guard _validateNCName(string) else { return nil }
    self.init(uncheckedString:string)
  }
  public init?(rawValue:String) { self.init(rawValue) }
  
  public init(stringLiteral value:String) {
    guard _validateNCName(value) else { fatalError("Invalid String as NCName: \(value)") }
    self.init(uncheckedString:value)
  }
}


/// Represents [QName](https://www.w3.org/TR/REC-xml-names/#NT-QName).
public struct QualifiedName: CustomStringConvertible, Hashable, ExpressibleByStringLiteral {
  public typealias StringLiteralType = String
  
  public var prefix: NoncolonizedName?
  public var localName: NoncolonizedName
  
  public var description: String {
    var desc = ""
    if let prefix = self.prefix { desc += prefix.description + ":" }
    desc += self.localName.description
    return desc
  }
  
  public init(prefix:NoncolonizedName? = nil, localName:NoncolonizedName) {
    self.prefix = prefix
    self.localName = localName
  }
  
  public init?(_ string:String) {
    let splittedByColon = string.splitOnce(separator:":")
    
    if let localPartSource = splittedByColon.1 {
      guard let prefix = NoncolonizedName(String(splittedByColon.0)) else { return nil }
      guard let localPart = NoncolonizedName(String(localPartSource)) else { return nil }
      self.init(prefix:prefix, localName:localPart)
    } else {
      guard let localPart = NoncolonizedName(String(splittedByColon.0)) else { return nil }
      self.init(prefix:nil, localName:localPart)
    }
  }
  
  public init(stringLiteral:String) {
    guard let instance = QualifiedName(stringLiteral) else {
      fatalError("\"\(stringLiteral)\" is invalid for QName.")
    }
    self = instance
  }
}


/// Represents the name of [Attribute](https://www.w3.org/TR/REC-xml-names/#NT-Attribute).
public enum AttributeName: CustomStringConvertible, Hashable, ExpressibleByStringLiteral {
  /// Default namespace
  case defaultNamespace
  
  /// Namespace declaration; "prefix" is the associated value.
  case userDefinedNamespace(NoncolonizedName)
  
  /// Ordinary attribute
  case attributeName(QualifiedName)
  
  public var description: String {
    switch self {
    case .defaultNamespace:
      return "xmlns"
    case .userDefinedNamespace(let ncName):
      return "xmlns:\(ncName.description)"
    case .attributeName(let qName):
      return qName.description
    }
  }
  
  public init?(_ string:String) {
    if string == "xmlns" {
      self = .defaultNamespace
    } else if let qName = QualifiedName(string) {
      if let prefix = qName.prefix, prefix == "xmlns" {
        self = .userDefinedNamespace(qName.localName)
      } else {
        self = .attributeName(qName)
      }
    } else {
      return nil
    }
  }
  
  public init(stringLiteral:String) {
    guard let instance = AttributeName(stringLiteral) else {
      fatalError("\"\(stringLiteral)\" is invalid for attribute name.")
    }
    self = instance
  }
}
