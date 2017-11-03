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
  // For the purpose of some compatibility with `UnicodeScalarSet`
  fileprivate enum Container {
    case multirange(Multirange<Character>)
    case unicodeScalarSet(UnicodeScalarSet)
  }
  fileprivate var container: Container
  fileprivate init(_ container:Container) {
    self.container = container
  }
  public init() {
    self.init(.multirange(Multirange<Character>()))
  }
}

extension BonaFideCharacterSet.Container: Equatable {
  static func ==(lhs:BonaFideCharacterSet.Container, rhs:BonaFideCharacterSet.Container) -> Bool {
    switch (lhs, rhs) {
    case (.multirange(let lrange), .multirange(let rrange)) where lrange == rrange:
      return true
    case (.unicodeScalarSet(let lset), .unicodeScalarSet(let rset)) where lset == rset:
      return true
    default:
      return false
    }
  }
}

extension BonaFideCharacterSet.Container {
  mutating func insert(_ character:Character) {
    switch self {
    case .multirange(var ranges):
      ranges.insert(character)
      self = .multirange(ranges)
    case .unicodeScalarSet(var set):
      let scalars = character.unicodeScalars
      guard scalars.count == 1 else { fatalError("\(#function): `character` must be contain only one Unicode Scalar when `self` has been initialized with UnicodeScalarSet") }
      set.insert(scalars.first!)
      self = .unicodeScalarSet(set)
    }
  }
  
  mutating func insert<R>(_ range:R) where R: UncountableRangeExpression, R.UncountableBound == Character {
    guard case .multirange(var ranges) = self else { fatalError("\(#function): Any ranges cannot be inserted to BonaFideCharacterSet initialized with UnicodeScalarSet.") }
    let wrappedRange = Multirange<Character>.Range(CertainRange<Character>(range))
    ranges.insert(wrappedRange)
    self = .multirange(ranges)
  }
  
  func contains(_ character:Character) -> Bool {
    switch self {
    case .multirange(let ranges): return ranges.contains(character)
    case .unicodeScalarSet(let set):
      let scalars = character.unicodeScalars
      guard scalars.count == 1 else { fatalError("\(#function): `character` must be contain only one Unicode Scalar when `self` has been initialized with UnicodeScalarSet") }
      return set.contains(scalars.first!)
    }
  }
  
  mutating func subtract(_ character:Character) {
    switch self {
    case .multirange(var ranges):
      ranges.subtract(character)
      self = .multirange(ranges)
    case .unicodeScalarSet(var set):
      let scalars = character.unicodeScalars
      guard scalars.count == 1 else { fatalError("\(#function): `character` must be contain only one Unicode Scalar when `self` has been initialized with UnicodeScalarSet") }
      set.remove(scalars.first!)
      self = .unicodeScalarSet(set)
    }
  }
}

extension BonaFideCharacterSet: Equatable {
  public static func ==(lhs: BonaFideCharacterSet, rhs: BonaFideCharacterSet) -> Bool {
    return lhs.container == rhs.container
  }
}

extension BonaFideCharacterSet {
  public init<S>(_ sequence:S) where S:Sequence, S.Element == Character {
    var ranges: Multirange<Character> = []
    for character in sequence {
      ranges.insert(character)
    }
    self.init(.multirange(ranges))
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
  
  internal init(_ unicodeScalarSet:UnicodeScalarSet,
                convertingToMultirange convert: Bool = false) {
    if convert {
      warn("It takes a while to convert `UnicodeScalarSet` to `Multirange<Character>` ")
      var ranges: Multirange<Character> = []
      let data = unicodeScalarSet.bitmapRepresentation
      for ii in 0..<data.count {
        if (data[ii >> 3] & UInt8(1 << (ii & 7))) > 0 {
          let scalar = Unicode.Scalar(ii)!
          ranges.insert(Character(scalar))
        }
      }
      self.init(.multirange(ranges))
    } else {
      self.init(.unicodeScalarSet(unicodeScalarSet))
    }
  }
}

extension BonaFideCharacterSet {
  private init(_ ranges:[Multirange<Character>.Range]) {
    var multirange = Multirange<Character>()
    multirange.ranges = ranges
    self.init(.multirange(multirange))
  }
  
  internal init(_ ranges:Multirange<Character>.Range...) {
    self.init(ranges)
  }
}

extension BonaFideCharacterSet {
  public mutating func insert(charactersIn range:ClosedRange<Character>) { self.container.insert(range) }
  public mutating func insert(charactersIn range:LeftOpenRange<Character>) { self.container.insert(range) }
  public mutating func insert(charactersIn range:OpenRange<Character>) { self.container.insert(range) }
  public mutating func insert(charactersIn range:Range<Character>) { self.container.insert(range) }
  public mutating func insert(charactersIn range:PartialRangeFrom<Character>) { self.container.insert(range) }
  public mutating func insert(charactersIn range:PartialRangeGreaterThan<Character>) { self.container.insert(range) }
  public mutating func insert(charactersIn range:PartialRangeThrough<Character>) { self.container.insert(range) }
  public mutating func insert(charactersIn range:PartialRangeUpTo<Character>) { self.container.insert(range) }
  
  public init(charactersIn range:ClosedRange<Character>) { self.init(); self.insert(charactersIn:range) }
  public init(charactersIn range:LeftOpenRange<Character>) { self.init(); self.insert(charactersIn:range) }
  public init(charactersIn range:OpenRange<Character>) { self.init(); self.insert(charactersIn:range) }
  public init(charactersIn range:Range<Character>) { self.init(); self.insert(charactersIn:range) }
  public init(charactersIn range:PartialRangeFrom<Character>) { self.init(); self.insert(charactersIn:range) }
  public init(charactersIn range:PartialRangeGreaterThan<Character>) { self.init(); self.insert(charactersIn:range) }
  public init(charactersIn range:PartialRangeThrough<Character>) { self.init(); self.insert(charactersIn:range) }
  public init(charactersIn range:PartialRangeUpTo<Character>) { self.init(); self.insert(charactersIn:range) }
}

extension BonaFideCharacterSet {
  public mutating func invert() {
    switch self.container {
    case .multirange(let ranges):
      let univ: Multirange<Character> = [Multirange<Character>.Range(CertainRange<Character>.universal)]
      let inverted: Multirange<Character> = univ.subtracting(ranges)
      self.container = .multirange(inverted)
    case .unicodeScalarSet(let set):
      self.container = .unicodeScalarSet(set.inverted())
    }
  }
  
  public func inverted() -> BonaFideCharacterSet {
    var set = self
    set.invert()
    return set
  }
  
  /// If `self` has been initialized with UnicodeScalarSet and `other` has not, or vise versa,
  /// this method will take a long time.
  public mutating func subtract(_ other: BonaFideCharacterSet) {
    switch (self.container, other.container) {
    case (.multirange(let sr), .multirange(let or)):
       self.container = .multirange(sr.subtracting(or))
    case (.unicodeScalarSet(let su), .unicodeScalarSet(let ou)):
       self.container = .unicodeScalarSet(su.subtracting(ou))
    case (.multirange, .unicodeScalarSet(let set)):
      let converted = BonaFideCharacterSet(set, convertingToMultirange:true)
      self.subtract(converted)
    case (.unicodeScalarSet(let set), .multirange):
      var converted = BonaFideCharacterSet(set, convertingToMultirange:true)
      converted.subtract(other)
      self.container = converted.container
    }
  }
  
  /// If `self` has been initialized with UnicodeScalarSet and `other` has not, or vise versa,
  /// this method will take a long time.
  public func subtracting(_ other: BonaFideCharacterSet) -> BonaFideCharacterSet {
    var set = self
    set.subtract(other)
    return set
  }
}

extension BonaFideCharacterSet: SetAlgebra {
  public typealias Element = Character
  
  public func contains(_ member: Character) -> Bool {
    return self.container.contains(member)
  }
  
  /// If `self` has been initialized with UnicodeScalarSet and `other` has not, or vise versa,
  /// this method will take a long time.
  public func union(_ other: BonaFideCharacterSet) -> BonaFideCharacterSet {
    switch (self.container, other.container) {
    case (.multirange(let sr), .multirange(let or)):
      return BonaFideCharacterSet(.multirange(sr.union(or)))
    case (.unicodeScalarSet(let su), .unicodeScalarSet(let ou)):
      return BonaFideCharacterSet(.unicodeScalarSet(su.union(ou)))
    case (.multirange, .unicodeScalarSet(let set)):
      let converted = BonaFideCharacterSet(set, convertingToMultirange:true)
      return self.union(converted)
    case (.unicodeScalarSet(let set), .multirange):
      let converted = BonaFideCharacterSet(set, convertingToMultirange:true)
      return other.union(converted)
    }
  }
  
  /// If `self` has been initialized with UnicodeScalarSet and `other` has not, or vise versa,
  /// this method will take a long time.
  public func intersection(_ other: BonaFideCharacterSet) -> BonaFideCharacterSet {
    switch (self.container, other.container) {
    case (.multirange(let sr), .multirange(let or)):
      return BonaFideCharacterSet(.multirange(sr.intersection(or)))
    case (.unicodeScalarSet(let su), .unicodeScalarSet(let ou)):
      return BonaFideCharacterSet(.unicodeScalarSet(su.intersection(ou)))
    case (.multirange, .unicodeScalarSet(let set)):
      let converted = BonaFideCharacterSet(set, convertingToMultirange:true)
      return self.intersection(converted)
    case (.unicodeScalarSet(let set), .multirange):
      let converted = BonaFideCharacterSet(set, convertingToMultirange:true)
      return other.intersection(converted)
    }
  }
  
  /// If `self` has been initialized with UnicodeScalarSet and `other` has not, or vise versa,
  /// this method will take a long time.
  public func symmetricDifference(_ other: BonaFideCharacterSet) -> BonaFideCharacterSet {
    switch (self.container, other.container) {
    case (.multirange(let sr), .multirange(let or)):
      return BonaFideCharacterSet(.multirange(sr.symmetricDifference(or)))
    case (.unicodeScalarSet(let su), .unicodeScalarSet(let ou)):
      return BonaFideCharacterSet(.unicodeScalarSet(su.symmetricDifference(ou)))
    case (.multirange, .unicodeScalarSet(let set)):
      let converted = BonaFideCharacterSet(set, convertingToMultirange:true)
      return self.symmetricDifference(converted)
    case (.unicodeScalarSet(let set), .multirange):
      let converted = BonaFideCharacterSet(set, convertingToMultirange:true)
      return other.symmetricDifference(converted)
    }
  }
  
  @discardableResult
  public mutating func insert(_ newMember: Character) -> (inserted: Bool, memberAfterInsert: Character) {
    if self.contains(newMember) {
      return (inserted:false, memberAfterInsert:newMember)
    } else {
      self.container.insert(newMember)
      return (inserted:true, memberAfterInsert:newMember)
    }
  }
  
  @discardableResult
  public mutating func remove(_ member: Character) -> Character? {
    if !self.contains(member) { return nil }
    self.container.subtract(member)
    return member
  }
  
  @discardableResult
  public mutating func update(with newMember: Character) -> Character? {
    let result = self.insert(newMember)
    return !result.inserted ? newMember : nil
  }
  
  /// If `self` has been initialized with UnicodeScalarSet and `other` has not, or vise versa,
  /// this method will take a long time.
  public mutating func formUnion(_ other: BonaFideCharacterSet) {
    self.container = self.union(other).container
  }
  
  /// If `self` has been initialized with UnicodeScalarSet and `other` has not, or vise versa,
  /// this method will take a long time.
  public mutating func formIntersection(_ other: BonaFideCharacterSet) {
    self.container = self.intersection(other).container
  }
  
  /// If `self` has been initialized with UnicodeScalarSet and `other` has not, or vise versa,
  /// this method will take a long time.
  public mutating func formSymmetricDifference(_ other: BonaFideCharacterSet) {
    self.container = self.symmetricDifference(other).container
  }
  
}
