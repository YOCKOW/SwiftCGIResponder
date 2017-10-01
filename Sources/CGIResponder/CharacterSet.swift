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
  
  public init(charactersIn string:String) {
    self.init(Set<Character>(Array(string.characters)))
  }
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
