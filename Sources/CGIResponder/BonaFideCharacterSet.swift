/***************************************************************************************************
 BonaFideCharacterSet.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # BonaFideCharacterSet
 A set of characters.
 This will not be necessary in the future.
 
 ## Reference
 [Character and CharacterSet](https://github.com/apple/swift/blob/swift-4.0-RELEASE/docs/StringManifesto.md#character-and-characterset)
 > Despite its name, CharacterSet currently operates on the Swift UnicodeScalar type.
 > This means it is usable on String, but only by going through the unicode scalar view.
 > To deal with this clash in the short term, CharacterSet should be renamed to UnicodeScalarSet.
 > In the longer term, it may be appropriate to introduce a CharacterSet that provides similar
 > functionality for extended grapheme clusters.
 
 */
public struct BonaFideCharacterSet {
  private var _ranges: Multirange<Character>
  public init() { self._ranges = Multirange<Character>() }
}

extension BonaFideCharacterSet: Equatable {
  public static func ==(lhs: BonaFideCharacterSet, rhs: BonaFideCharacterSet) -> Bool {
    return lhs._ranges == rhs._ranges
  }
}

extension BonaFideCharacterSet {
  public init<S>(_ sequence:S) where S:Sequence, S.Element == Character {
    self.init()
    for character in sequence {
      self._ranges.insert(character)
    }
  }
  
  public init(charactersIn string:String) {
    var characters: [Character] = []
    var index = string.startIndex
    while index < string.endIndex {
      defer { index = string.index(after:index) }
      characters.append(string[index])
    }
    self.init(characters)
  }
}

extension BonaFideCharacterSet {
  public mutating func invert() {
    let univ: Multirange<Character> = [Multirange<Character>.Range(CertainRange<Character>.universal)]
    let inverted: Multirange<Character> = univ.subtracting(self._ranges)
    self._ranges = inverted
  }
  public func inverted() -> BonaFideCharacterSet {
    var set = self
    set.invert()
    return set
  }
}

extension BonaFideCharacterSet: SetAlgebra {
  public typealias Element = Character
  
  public func contains(_ member: Character) -> Bool {
    return self._ranges.contains(member)
  }
  
  public func union(_ other: BonaFideCharacterSet) -> BonaFideCharacterSet {
    var newSet = BonaFideCharacterSet()
    newSet._ranges = self._ranges.union(other._ranges)
    return newSet
  }
  
  public func intersection(_ other: BonaFideCharacterSet) -> BonaFideCharacterSet {
    var newSet = BonaFideCharacterSet()
    newSet._ranges = self._ranges.intersection(other._ranges)
    return newSet
  }
  
  public func symmetricDifference(_ other: BonaFideCharacterSet) -> BonaFideCharacterSet {
    var newSet = BonaFideCharacterSet()
    newSet._ranges = self._ranges.symmetricDifference(other._ranges)
    return newSet
  }
  
  @discardableResult
  public mutating func insert(_ newMember: Character) -> (inserted: Bool, memberAfterInsert: Character) {
    if self.contains(newMember) {
      return (inserted:false, memberAfterInsert:newMember)
    } else {
      self._ranges.insert(newMember)
      return (inserted:true, memberAfterInsert:newMember)
    }
  }
  
  @discardableResult
  public mutating func remove(_ member: Character) -> Character? {
    if !self.contains(member) { return nil }
    self._ranges.subtract(member)
    return member
  }
  
  @discardableResult
  public mutating func update(with newMember: Character) -> Character? {
    let result = self.insert(newMember)
    return !result.inserted ? newMember : nil
  }
  
  public mutating func formUnion(_ other: BonaFideCharacterSet) {
    self._ranges.formUnion(other._ranges)
  }
  
  public mutating func formIntersection(_ other: BonaFideCharacterSet) {
    self._ranges.formIntersection(other._ranges)
  }
  
  public mutating func formSymmetricDifference(_ other: BonaFideCharacterSet) {
    self._ranges.formSymmetricDifference(other._ranges)
  }
  
  
}
