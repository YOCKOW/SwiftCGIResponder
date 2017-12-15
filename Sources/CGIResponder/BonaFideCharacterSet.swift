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
 
 ## Feature
 Unlike `Foundation.Character`, this may be really a set of `Character`s.
 However, in order to ensure compatibility, it can be initialized with `Multirange<Character>` or
 `UnicodeScalar`. When it is initialized with `UnicodeScalar`, each of its members (`Character`s) is
 assumed to have only one `Unicode.Scalar`.
 
 ### Note
 Although you can convert `UnicodeScalarSet` to `BonaFideCharacterSet` whose container is
 `Multirange<Character>`, it will take a while.
 
 ## Reference
 [Character and CharacterSet](https://github.com/apple/swift/blob/swift-4.0-RELEASE/docs/StringManifesto.md#character-and-characterset)
 > Despite its name, CharacterSet currently operates on the Swift UnicodeScalar type.
 > This means it is usable on String, but only by going through the unicode scalar view.
 > To deal with this clash in the short term, CharacterSet should be renamed to UnicodeScalarSet.
 > In the longer term, it may be appropriate to introduce a CharacterSet that provides similar
 > functionality for extended grapheme clusters.
 
 */
public struct BonaFideCharacterSet {
  /// For the purpose of some compatibility with `UnicodeScalarSet`,
  /// there are two kinds of containers for `Character`.
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
      guard scalars.count == 1 else { fatalError("\(#function): `character` must contain only one Unicode Scalar when `self` has been initialized with UnicodeScalarSet") }
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
      guard scalars.count == 1 else { fatalError("\(#function): `character` must contain only one Unicode Scalar when `self` has been initialized with UnicodeScalarSet") }
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
      guard scalars.count == 1 else { fatalError("\(#function): `character` must contain only one Unicode Scalar when `self` has been initialized with UnicodeScalarSet") }
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
  
  /// Initialize with the characters in the given string.
  public init(charactersIn string:String) {
    var characters: [Character] = []
    var index = string.startIndex
    while index < string.endIndex {
      defer { index = string.index(after:index) }
      characters.append(string[index])
    }
    self.init(characters)
  }
  
  /// Initialize with `UnicodeScalarSet`. When an instance is initialized with this initializer,
  /// each of its members (`Character`s) is assumed to have only one `Unicode.Scalar`.
  /// Although you can convert `UnicodeScalarSet` to `Multirange<Character>` passing `true` to
  /// `convertingToMultirange`, it will take a while.
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
  /// Insert the values from the specified `range` into the `BonaFideCharacterSet`.
  public mutating func insert(charactersIn range:ClosedRange<Character>) { self.container.insert(range) }
  /// Insert the values from the specified `range` into the `BonaFideCharacterSet`.
  public mutating func insert(charactersIn range:LeftOpenRange<Character>) { self.container.insert(range) }
  /// Insert the values from the specified `range` into the `BonaFideCharacterSet`.
  public mutating func insert(charactersIn range:OpenRange<Character>) { self.container.insert(range) }
  /// Insert the values from the specified `range` into the `BonaFideCharacterSet`.
  public mutating func insert(charactersIn range:Range<Character>) { self.container.insert(range) }
  /// Insert the values from the specified `range` into the `BonaFideCharacterSet`.
  public mutating func insert(charactersIn range:PartialRangeFrom<Character>) { self.container.insert(range) }
  /// Insert the values from the specified `range` into the `BonaFideCharacterSet`.
  public mutating func insert(charactersIn range:PartialRangeGreaterThan<Character>) { self.container.insert(range) }
  /// Insert the values from the specified `range` into the `BonaFideCharacterSet`.
  public mutating func insert(charactersIn range:PartialRangeThrough<Character>) { self.container.insert(range) }
  /// Insert the values from the specified `range` into the `BonaFideCharacterSet`.
  public mutating func insert(charactersIn range:PartialRangeUpTo<Character>) { self.container.insert(range) }
  
  /// Initialize with the characters in the given `range`.
  public init(charactersIn range:ClosedRange<Character>) { self.init(); self.insert(charactersIn:range) }
  /// Initialize with the characters in the given `range`.
  public init(charactersIn range:LeftOpenRange<Character>) { self.init(); self.insert(charactersIn:range) }
  /// Initialize with the characters in the given `range`.
  public init(charactersIn range:OpenRange<Character>) { self.init(); self.insert(charactersIn:range) }
  /// Initialize with the characters in the given `range`.
  public init(charactersIn range:Range<Character>) { self.init(); self.insert(charactersIn:range) }
  /// Initialize with the characters in the given `range`.
  public init(charactersIn range:PartialRangeFrom<Character>) { self.init(); self.insert(charactersIn:range) }
  /// Initialize with the characters in the given `range`.
  public init(charactersIn range:PartialRangeGreaterThan<Character>) { self.init(); self.insert(charactersIn:range) }
  /// Initialize with the characters in the given `range`.
  public init(charactersIn range:PartialRangeThrough<Character>) { self.init(); self.insert(charactersIn:range) }
  /// Initialize with the characters in the given `range`.
  public init(charactersIn range:PartialRangeUpTo<Character>) { self.init(); self.insert(charactersIn:range) }
}

extension BonaFideCharacterSet {
  /// Invert the contents of the `BonaFideCharacterSet`.
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
  
  /// Returns an inverted copy of the `BonaFideCharacterSet`.
  public func inverted() -> BonaFideCharacterSet {
    var set = self
    set.invert()
    return set
  }
  
  /// Removes the elements of the given set from this set.
  /// If this set has been initialized with `UnicodeScalarSet` and `other` has not, or vise versa,
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
  
  /// Returns a new set containing the elements of this set that do not occur in the given set.
  /// If this set has been initialized with `UnicodeScalarSet` and `other` has not, or vise versa,
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
  
  /// Returns a new set with the elements of both this and the given set.
  /// If this set has been initialized with `UnicodeScalarSet` and `other` has not, or vise versa,
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
  
  /// Returns an intersection of the `BonaFideCharacterSet` with another `BonaFideCharacterSet`.
  /// If this set has been initialized with `UnicodeScalarSet` and `other` has not, or vise versa,
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
  
  /// Returns an exclusive or of the `BonaFideCharacterSet` with another `BonaFideCharacterSet`.
  /// If this set has been initialized with `UnicodeScalarSet` and `other` has not, or vise versa,
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
  
  /// Adds the elements of the given set to the set.
  /// If this set has been initialized with `UnicodeScalarSet` and `other` has not, or vise versa,
  /// this method will take a long time.
  public mutating func formUnion(_ other: BonaFideCharacterSet) {
    self.container = self.union(other).container
  }
  
  /// Sets the value to an intersection of the `BonaFideCharacterSet` with another `BonaFideCharacterSet`.
  /// If this set has been initialized with `UnicodeScalarSet` and `other` has not, or vise versa,
  /// this method will take a long time.
  public mutating func formIntersection(_ other: BonaFideCharacterSet) {
    self.container = self.intersection(other).container
  }
  
  /// Sets the value to an exclusive or of the `BonaFideCharacterSet` with another `BonaFideCharacterSet`.
  /// If this set has been initialized with `UnicodeScalarSet` and `other` has not, or vise versa,
  /// this method will take a long time.
  public mutating func formSymmetricDifference(_ other: BonaFideCharacterSet) {
    self.container = self.symmetricDifference(other).container
  }
  
}
