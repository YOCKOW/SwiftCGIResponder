/***************************************************************************************************
 RangeSet.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/**
 
 # RangeSet
 Set of ranges.
 
 */
public struct RangeSet<Bound> where Bound: Comparable {
  public struct Element {
    fileprivate var range: CertainRange<Bound>
    private init(_ range:CertainRange<Bound>) { self.range = range }
    public init(_ range:ClosedRange<Bound>) { self.init(CertainRange<Bound>(range)) }
    public init(_ range:Range<Bound>) { self.init(CertainRange<Bound>(range)) }
    public init(_ range:PartialRangeFrom<Bound>) { self.init(CertainRange<Bound>(range)) }
    public init(_ range:PartialRangeThrough<Bound>) { self.init(CertainRange<Bound>(range)) }
    public init(_ range:PartialRangeUpTo<Bound>) { self.init(CertainRange<Bound>(range)) }
  }
  
  private var _elements: [Element]
  public init() { self._elements = [] }
}

extension RangeSet.Element: Equatable {
  public static func ==(lhs: RangeSet<Bound>.Element, rhs: RangeSet<Bound>.Element) -> Bool {
    return lhs.range == rhs.range
  }
}

extension RangeSet.Element: Comparable {
  public static func <(lhs: RangeSet<Bound>.Element, rhs: RangeSet<Bound>.Element) -> Bool {
    return lhs.range < rhs.range
  }
}

extension RangeSet.Element {
  public func joined(with other:RangeSet<Bound>.Element) -> RangeSet<Bound>.Element? {
    guard let joinedRange = self.range.joined(with:other.range) else { return nil }
    return RangeSet<Bound>.Element(joinedRange)
  }
  
  public func contains(_ value:Bound) -> Bool {
    return self.range.contains(value)
  }
}

extension RangeSet {
  /// Join ranges if they have overlap.
  private mutating func _normalize() {
    let elements = self._elements.sorted()
    self._elements.removeAll(keepingCapacity: true)
    appendElements: for element in elements {
      if self._elements.isEmpty {
        self._elements.append(element)
      } else {
        let last = self._elements.last!
        if let joined = last.joined(with:element) {
          self._elements.removeLast()
          self._elements.append(joined)
          
          // no more elements are required if `joined.range` is `.universal` or `.partialRangeFrom`
          switch joined.range {
          case .universal, .partialRangeFrom: break appendElements
          default: break
          }
        } else {
          self._elements.append(element)
        }
      }
    }
  }
  
  internal var elements: [RangeSet<Bound>.Element] {
    get { return self._elements }
    set { self._elements = newValue; self._normalize() }
  }
  
}

extension RangeSet {
  @discardableResult
  public mutating func insert(_ newMember:RangeSet<Bound>.Element) -> (inserted:Bool, memberAfterInsert:RangeSet<Bound>.Element) {
    if let index = self.elements.index(of:newMember) {
      return (inserted:false, memberAfterInsert:self.elements[index])
    } else {
      self.elements.append(newMember)
      return (inserted:true, memberAfterInsert:newMember)
    }
  }
  
  @discardableResult
  public mutating func insert(_ newMember:ClosedRange<Bound>) -> (inserted:Bool, memberAfterInsert:ClosedRange<Bound>) {
    let result = self.insert(RangeSet<Bound>.Element(newMember))
    if result.inserted {
      return (inserted:true, memberAfterInsert:newMember)
    } else {
      guard case .closedRange(let oldMember) = result.memberAfterInsert.range else { fatalError("Unexpected range.") }
      return (inserted:false, memberAfterInsert:oldMember)
    }
  }
  
  @discardableResult
  public mutating func insert(_ newMember:Range<Bound>) -> (inserted:Bool, memberAfterInsert:Range<Bound>) {
    let result = self.insert(RangeSet<Bound>.Element(newMember))
    if result.inserted {
      return (inserted:true, memberAfterInsert:newMember)
    } else {
      guard case .range(let oldMember) = result.memberAfterInsert.range else { fatalError("Unexpected range.") }
      return (inserted:false, memberAfterInsert:oldMember)
    }
  }
  
  @discardableResult
  public mutating func insert(_ newMember:PartialRangeFrom<Bound>) -> (inserted:Bool, memberAfterInsert:PartialRangeFrom<Bound>) {
    let result = self.insert(RangeSet<Bound>.Element(newMember))
    if result.inserted {
      return (inserted:true, memberAfterInsert:newMember)
    } else {
      guard case .partialRangeFrom(let oldMember) = result.memberAfterInsert.range else { fatalError("Unexpected range.") }
      return (inserted:false, memberAfterInsert:oldMember)
    }
  }
  
  @discardableResult
  public mutating func insert(_ newMember:PartialRangeThrough<Bound>) -> (inserted:Bool, memberAfterInsert:PartialRangeThrough<Bound>) {
    let result = self.insert(RangeSet<Bound>.Element(newMember))
    if result.inserted {
      return (inserted:true, memberAfterInsert:newMember)
    } else {
      guard case .partialRangeThrough(let oldMember) = result.memberAfterInsert.range else { fatalError("Unexpected range.") }
      return (inserted:false, memberAfterInsert:oldMember)
    }
  }
  
  @discardableResult
  public mutating func insert(_ newMember:PartialRangeUpTo<Bound>) -> (inserted:Bool, memberAfterInsert:PartialRangeUpTo<Bound>) {
    let result = self.insert(RangeSet<Bound>.Element(newMember))
    if result.inserted {
      return (inserted:true, memberAfterInsert:newMember)
    } else {
      guard case .partialRangeUpTo(let oldMember) = result.memberAfterInsert.range else { fatalError("Unexpected range.") }
      return (inserted:false, memberAfterInsert:oldMember)
    }
  }
  
  public func contains(_ member:RangeSet<Bound>.Element) -> Bool {
    return self.elements.contains(member)
  }
  
  public func contains(_ member:ClosedRange<Bound>) -> Bool {
    return self.contains(RangeSet<Bound>.Element(member))
  }
  
  public func contains(_ member:Range<Bound>) -> Bool {
    return self.contains(RangeSet<Bound>.Element(member))
  }
  
  public func contains(_ member:PartialRangeFrom<Bound>) -> Bool {
    return self.contains(RangeSet<Bound>.Element(member))
  }
  
  public func contains(_ member:PartialRangeThrough<Bound>) -> Bool {
    return self.contains(RangeSet<Bound>.Element(member))
  }
  
  public func contains(_ member:PartialRangeUpTo<Bound>) -> Bool {
    return self.contains(RangeSet<Bound>.Element(member))
  }
  
  public func contains(_ value:Bound) -> Bool {
    for range in self.elements {
      if range.contains(value) { return true }
    }
    return false
  }
}

