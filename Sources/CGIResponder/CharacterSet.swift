/***************************************************************************************************
 CharacterSet.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
 /**
 
 # CharacterSet
 A bona fide set of `Character` that is different from `Foundation.CharacterSet`.
 This will not be necessary in the future.
 See also [UnicodeScalarSet](UnicodeScalarSet.swift)
 
 */
public struct CharacterSet {
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

extension CharacterSet {
  public static let alphanumerics = CharacterSet(UnicodeScalarSet.alphanumerics)
  public static let capitalizedLetters = CharacterSet(UnicodeScalarSet.capitalizedLetters)
  public static let controlCharacters = CharacterSet(UnicodeScalarSet.controlCharacters)
  public static let decimalDigits = CharacterSet(UnicodeScalarSet.decimalDigits)
  public static let decomposables = CharacterSet(UnicodeScalarSet.decomposables)
  public static let illegalCharacters = CharacterSet(UnicodeScalarSet.illegalCharacters)
  public static let letters = CharacterSet(UnicodeScalarSet.letters)
  public static let lowercaseLetters = CharacterSet(UnicodeScalarSet.lowercaseLetters)
  public static let newlines = ({ () -> CharacterSet in  var cs = CharacterSet(UnicodeScalarSet.newlines); cs.insert("\r\n"); return cs })()
  public static let nonBaseCharacters = CharacterSet(UnicodeScalarSet.nonBaseCharacters)
  public static let punctuationCharacters = CharacterSet(UnicodeScalarSet.punctuationCharacters)
  public static let symbols = CharacterSet(UnicodeScalarSet.symbols)
  public static let uppercaseLetters = CharacterSet(UnicodeScalarSet.uppercaseLetters)
  public static let whitespaces = CharacterSet(UnicodeScalarSet.whitespaces)
  public static let whitespacesAndNewlines = whitespaces.union(newlines)
}

extension CharacterSet: Hashable {
  public var hashValue: Int {
    return self.set.hashValue
  }
  
  public static func ==(lhs: CharacterSet, rhs: CharacterSet) -> Bool {
    return lhs.set == rhs.set
  }
}

extension CharacterSet: CustomStringConvertible, CustomDebugStringConvertible {
  public var description: String {
    return self.set.description
  }
  public var debugDescription: String {
    return "<CGIResponder.CharacterSet>\(self.description)"
  }
}

extension CharacterSet: SetAlgebra {
  public typealias Element = Character
  
  public init() {
    self.init(Set<Character>())
  }
  
  public func contains(_ member: Character) -> Bool {
    return self.set.contains(member)
  }
  
  public func union(_ other: CharacterSet) -> CharacterSet {
    return CharacterSet(self.set.union(other.set))
  }
  
  public func intersection(_ other: CharacterSet) -> CharacterSet {
    return CharacterSet(self.set.intersection(other.set))
  }
  
  public func symmetricDifference(_ other: CharacterSet) -> CharacterSet {
    return CharacterSet(self.set.symmetricDifference(other.set))
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
  
  public mutating func formUnion(_ other: CharacterSet) {
    self.set.formUnion(other.set)
  }
  
  public mutating func formIntersection(_ other: CharacterSet) {
    self.set.formIntersection(other.set)
  }
  
  public mutating func formSymmetricDifference(_ other: CharacterSet) {
    self.set.formSymmetricDifference(other.set)
  }
  
}
