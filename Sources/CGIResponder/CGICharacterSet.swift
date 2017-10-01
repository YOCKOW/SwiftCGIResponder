/***************************************************************************************************
 CGICharacterSet.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
 /**
 
 # CGICharacterSet
 A bona fide set of `Character` that is different from `Foundation.CharacterSet`.
 This will not be necessary in the future.
 See also [UnicodeScalarSet](UnicodeScalarSet.swift)
 
 */
public struct CGICharacterSet {
  fileprivate var set: Set<Character>
  fileprivate init(_ set: Set<Character>) {
    self.set = set
  }
  
  internal init(_ unicodeScalarSet:UnicodeScalarSet) {
    var set = Set<Character>()
    let data = unicodeScalarSet.bitmapRepresentation
    for ii in 0..<data.count {
      if (data[ii >> 3] & UInt8(1 << (ii & 7))) > 0 {
        let scalar = Unicode.Scalar(ii)!
        set.insert(Character(scalar))
      }
    }
    self.init(set)
  }
  
  public init(charactersIn string:String) {
    self.init(Set<Character>(Array(string.characters)))
  }
}

extension CGICharacterSet {
  public static let alphanumerics = CGICharacterSet(UnicodeScalarSet.alphanumerics)
  public static let capitalizedLetters = CGICharacterSet(UnicodeScalarSet.capitalizedLetters)
  public static let controlCharacters = CGICharacterSet(UnicodeScalarSet.controlCharacters)
  public static let decimalDigits = CGICharacterSet(UnicodeScalarSet.decimalDigits)
  public static let decomposables = CGICharacterSet(UnicodeScalarSet.decomposables)
  public static let illegalCharacters = CGICharacterSet(UnicodeScalarSet.illegalCharacters)
  public static let letters = CGICharacterSet(UnicodeScalarSet.letters)
  public static let lowercaseLetters = CGICharacterSet(UnicodeScalarSet.lowercaseLetters)
  public static let newlines = ({ () -> CGICharacterSet in  var cs = CGICharacterSet(UnicodeScalarSet.newlines); cs.insert("\r\n"); return cs })()
  public static let nonBaseCharacters = CGICharacterSet(UnicodeScalarSet.nonBaseCharacters)
  public static let punctuationCharacters = CGICharacterSet(UnicodeScalarSet.punctuationCharacters)
  public static let symbols = CGICharacterSet(UnicodeScalarSet.symbols)
  public static let uppercaseLetters = CGICharacterSet(UnicodeScalarSet.uppercaseLetters)
  public static let whitespaces = CGICharacterSet(UnicodeScalarSet.whitespaces)
  public static let whitespacesAndNewlines = whitespaces.union(newlines)
}

extension CGICharacterSet: Hashable {
  public var hashValue: Int {
    return self.set.hashValue
  }
  
  public static func ==(lhs: CGICharacterSet, rhs: CGICharacterSet) -> Bool {
    return lhs.set == rhs.set
  }
}

extension CGICharacterSet: CustomStringConvertible, CustomDebugStringConvertible {
  public var description: String {
    return self.set.description
  }
  public var debugDescription: String {
    return "<CGIResponder.CGICharacterSet>\(self.description)"
  }
}

extension CGICharacterSet: SetAlgebra {
  public typealias Element = Character
  
  public init() {
    self.init(Set<Character>())
  }
  
  public func contains(_ member: Character) -> Bool {
    return self.set.contains(member)
  }
  
  public func union(_ other: CGICharacterSet) -> CGICharacterSet {
    return CGICharacterSet(self.set.union(other.set))
  }
  
  public func intersection(_ other: CGICharacterSet) -> CGICharacterSet {
    return CGICharacterSet(self.set.intersection(other.set))
  }
  
  public func symmetricDifference(_ other: CGICharacterSet) -> CGICharacterSet {
    return CGICharacterSet(self.set.symmetricDifference(other.set))
  }
  
  @discardableResult
  public mutating func insert(_ newMember: Character) -> (inserted: Bool, memberAfterInsert: Character) {
    return self.set.insert(newMember)
  }
  
  @discardableResult
  public mutating func remove(_ member: Character) -> Character? {
    return self.set.remove(member)
  }
  
  @discardableResult
  public mutating func update(with newMember: Character) -> Character? {
    return self.set.update(with: newMember)
  }
  
  public mutating func formUnion(_ other: CGICharacterSet) {
    self.set.formUnion(other.set)
  }
  
  public mutating func formIntersection(_ other: CGICharacterSet) {
    self.set.formIntersection(other.set)
  }
  
  public mutating func formSymmetricDifference(_ other: CGICharacterSet) {
    self.set.formSymmetricDifference(other.set)
  }
  
}
