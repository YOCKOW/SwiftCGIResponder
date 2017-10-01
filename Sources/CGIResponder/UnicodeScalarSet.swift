/***************************************************************************************************
 UnicodeScalarSet.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/**
 
 # UnicodeScalarSet
 Set of Unicode Scalars.
 This will not be necessary in the future.
 
 ## Reference
 [Character and CharacterSet](https://github.com/apple/swift/blob/swift-4.0-RELEASE/docs/StringManifesto.md#character-and-characterset)
 > Despite its name, CharacterSet currently operates on the Swift UnicodeScalar type.
 > This means it is usable on String, but only by going through the unicode scalar view.
 > To deal with this clash in the short term, CharacterSet should be renamed to UnicodeScalarSet.
 > In the longer term, it may be appropriate to introduce a CharacterSet that provides similar
 > functionality for extended grapheme clusters.
 
 */

import Foundation

public struct UnicodeScalarSet {
  fileprivate var _legacyCharacterSet: Foundation.CharacterSet
  public init(_ legacyCharacterSet: Foundation.CharacterSet) {
    self._legacyCharacterSet = legacyCharacterSet
  }
  public init(unicodeScalarsIn string: String) {
    self.init(Foundation.CharacterSet(charactersIn:string))
  }
  public init(unicodeScalarsIn closedRange:ClosedRange<Unicode.Scalar>) {
    self.init(Foundation.CharacterSet(charactersIn:closedRange))
  }
  public init(unicodeScalarsIn range:Range<Unicode.Scalar>) {
    self.init(Foundation.CharacterSet(charactersIn:range))
  }
}

extension UnicodeScalarSet: CustomDebugStringConvertible, CustomStringConvertible {
  public var debugDescription: String {
    return self._legacyCharacterSet.debugDescription
  }
  public var description: String {
    return self._legacyCharacterSet.description
  }
}

extension UnicodeScalarSet: Hashable {
  public var hashValue: Int {
    return self._legacyCharacterSet.hashValue
  }
  public static func ==(lhs: UnicodeScalarSet, rhs: UnicodeScalarSet) -> Bool {
    return lhs._legacyCharacterSet == rhs._legacyCharacterSet
  }
}

extension UnicodeScalarSet: SetAlgebra {
  public typealias Element = Unicode.Scalar
  
  public init() {
    self.init(Foundation.CharacterSet())
  }
  
  public func contains(_ member: Unicode.Scalar) -> Bool {
    return self._legacyCharacterSet.contains(member)
  }
  
  public func union(_ other: UnicodeScalarSet) -> UnicodeScalarSet {
    return UnicodeScalarSet(self._legacyCharacterSet.union(other._legacyCharacterSet))
  }
  
  public func intersection(_ other: UnicodeScalarSet) -> UnicodeScalarSet {
    return UnicodeScalarSet(self._legacyCharacterSet.intersection(other._legacyCharacterSet))
  }
  
  public func symmetricDifference(_ other: UnicodeScalarSet) -> UnicodeScalarSet {
    return UnicodeScalarSet(self._legacyCharacterSet.symmetricDifference(other._legacyCharacterSet))
  }
  
  @discardableResult
  public mutating func insert(_ newMember: Unicode.Scalar) -> (inserted: Bool, memberAfterInsert: Unicode.Scalar) {
    return self._legacyCharacterSet.insert(newMember)
  }
  
  @discardableResult
  public mutating func remove(_ member: Unicode.Scalar) -> Unicode.Scalar? {
    return self._legacyCharacterSet.remove(member)
  }
  
  @discardableResult
  public mutating func update(with newMember: Unicode.Scalar) -> Unicode.Scalar? {
    return self._legacyCharacterSet.update(with:newMember)
  }
  
  public mutating func formUnion(_ other: UnicodeScalarSet) {
    self._legacyCharacterSet.formUnion(other._legacyCharacterSet)
  }
  
  public mutating func formIntersection(_ other: UnicodeScalarSet) {
    self._legacyCharacterSet.formIntersection(other._legacyCharacterSet)
  }
  
  public mutating func formSymmetricDifference(_ other: UnicodeScalarSet) {
    self._legacyCharacterSet.formSymmetricDifference(other._legacyCharacterSet)
  }
  
}
