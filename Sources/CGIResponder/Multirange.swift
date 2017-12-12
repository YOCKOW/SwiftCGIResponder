/***************************************************************************************************
 Multirange.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/**
 
 # Multirange
 Represents multiple ranges.
 
 */
public struct Multirange<Bound> where Bound: Comparable {
  public struct Range {
    fileprivate var range: CertainRange<Bound>
    internal init(_ range:CertainRange<Bound>) { self.range = range }
  }
  private var _ranges: [Range]
  public init() { self._ranges = [] }
}

extension Multirange.Range {
  public init(_ range:ClosedRange<Bound>) { self.init(CertainRange<Bound>(range)) }
  public init(_ range:LeftOpenRange<Bound>) { self.init(CertainRange<Bound>(range)) }
  public init(_ range:OpenRange<Bound>) { self.init(CertainRange<Bound>(range)) }
  public init(_ range:Range<Bound>) { self.init(CertainRange<Bound>(range)) }
  public init(_ range:PartialRangeFrom<Bound>) { self.init(CertainRange<Bound>(range)) }
  public init(_ range:PartialRangeGreaterThan<Bound>) { self.init(CertainRange<Bound>(range)) }
  public init(_ range:PartialRangeThrough<Bound>) { self.init(CertainRange<Bound>(range)) }
  public init(_ range:PartialRangeUpTo<Bound>) { self.init(CertainRange<Bound>(range)) }
  public init(singleValue value:Bound) { self.init(CertainRange<Bound>(singleValue:value)) }
}

extension Multirange.Range: Equatable {
  public static func ==(lhs: Multirange<Bound>.Range, rhs: Multirange<Bound>.Range) -> Bool {
    return lhs.range == rhs.range
  }
}

extension Multirange.Range: Comparable {
  public static func <(lhs: Multirange<Bound>.Range, rhs: Multirange<Bound>.Range) -> Bool {
    return lhs.range < rhs.range
  }
}

extension Multirange.Range {
  public func joined(with other:Multirange<Bound>.Range) -> Multirange<Bound>.Range? {
    guard let joinedRange = self.range.joined(with:other.range) else { return nil }
    return Multirange<Bound>.Range(joinedRange)
  }
  
  public func contains(_ value:Bound) -> Bool {
    return self.range.contains(value)
  }
  
  public func intersection(_ other:Multirange<Bound>.Range) -> Multirange<Bound>.Range {
    let intersection = self.range.intersection(other.range)
    return Multirange<Bound>.Range(intersection)
  }
}

extension Multirange {
  /// Join ranges if they have overlap.
  private mutating func _normalize() {
    let ranges = self._ranges.sorted(by:<)
    self._ranges.removeAll(keepingCapacity: true)
    appendRanges: for range in ranges {
      if self._ranges.isEmpty {
        self._ranges.append(range)
      } else {
        let last = self._ranges.last!
        if let joined = last.joined(with:range) {
          self._ranges.removeLast()
          self._ranges.append(joined)
          
          // no more elements are required if `joined.range` is `.universal` or `.partialRange(From|GreaterThan)`
          switch joined.range {
          case .universal, .partialRangeFrom, .partialRangeGreaterThan: break appendRanges
          default: break
          }
        } else {
          self._ranges.append(range)
        }
      }
    }
  }
  
  public internal(set) var ranges: [Multirange<Bound>.Range] {
    get { return self._ranges }
    set { self._ranges = newValue; self._normalize() } // Always normalized.
  }
}

extension Multirange: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements:Multirange<Bound>.Range...) {
    self.init()
    self.ranges = elements
  }
}

extension Multirange: Equatable {
  public static func ==(lhs:Multirange<Bound>, rhs:Multirange<Bound>) -> Bool {
    return lhs.ranges == rhs.ranges
  }
}

extension Multirange {
  public func contains(_ value:Bound) -> Bool {
    for range in self.ranges {
      if range.contains(value) { return true }
    }
    return false
  }
}

extension Multirange {
  public mutating func insert(_ newRange:Multirange<Bound>.Range) {
    self.ranges.append(newRange)
  }
  
  public mutating func insert(_ newRange:ClosedRange<Bound>) {
    self.insert(Multirange<Bound>.Range(newRange))
  }
  
  public mutating func insert(_ newRange:LeftOpenRange<Bound>) {
    self.insert(Multirange<Bound>.Range(newRange))
  }
  
  public mutating func insert(_ newRange:OpenRange<Bound>) {
    self.insert(Multirange<Bound>.Range(newRange))
  }
  
  public mutating func insert(_ newRange:Swift.Range<Bound>) {
    self.insert(Multirange<Bound>.Range(newRange))
  }
  
  public mutating func insert(_ newRange:PartialRangeFrom<Bound>) {
    self.insert(Multirange<Bound>.Range(newRange))
  }
  
  public mutating func insert(_ newRange:PartialRangeGreaterThan<Bound>) {
    self.insert(Multirange<Bound>.Range(newRange))
  }
  
  public mutating func insert(_ newRange:PartialRangeThrough<Bound>) {
    self.insert(Multirange<Bound>.Range(newRange))
  }
  
  public mutating func insert(_ newRange:PartialRangeUpTo<Bound>) {
    self.insert(Multirange<Bound>.Range(newRange))
  }
  
  public mutating func insert(_ newValue:Bound) {
    self.insert(Multirange<Bound>.Range(singleValue:newValue))
  }
}

extension Multirange {
  public mutating func formUnion(_ other:Multirange<Bound>) {
    self.ranges.append(contentsOf:other.ranges)
  }
  
  public func union(_ other:Multirange<Bound>) -> Multirange<Bound> {
    var set = self
    set.formUnion(other)
    return set
  }
}

extension Multirange {
  public func intersection(_ other:Multirange<Bound>) -> Multirange<Bound> {
    var intersection = Multirange<Bound>()
    for otherRange in other.ranges {
      var ir: [Multirange<Bound>.Range] = []
      for myRange in self.ranges {
        ir.append(myRange.intersection(otherRange))
      }
      intersection.ranges.append(contentsOf:ir)
    }
    return intersection
  }
  
  public mutating func formIntersection(_ other:Multirange<Bound>) {
    self.ranges = self.intersection(other).ranges
  }
}

extension Multirange {
  public func symmetricDifference(_ other:Multirange<Bound>) -> Multirange<Bound> {
    // symmetric diferrence == union - intersection
    return self.union(other).subtracting(self.intersection(other))
  }
  public mutating func formSymmetricDifference(_ other:Multirange<Bound>) {
    self.ranges = self.symmetricDifference(other).ranges
  }
}

extension Multirange {
  public mutating func subtract(_ otherRange:Multirange<Bound>.Range) {
    var subtracted = false
    var skipJudgment = false
    var newRanges: [Multirange<Bound>.Range] = []
    for range in self.ranges {
      if skipJudgment {
        newRanges.append(range)
      } else {
        let sr = range.range.subtracting(otherRange.range)
        if sr.0 == range.range && sr.1 == nil { // no range subtracted
          if subtracted {
            // If there are more than one ranges already subtracted and
            // this `range` cannot subtract `otherRange`,
            // the next ranges also cannot subtract `otherRange`,
            // because `self.ranges` is sorted.
            skipJudgment = true
          }
        }
        newRanges.append(Multirange<Bound>.Range(sr.0))
        if let another = sr.1 {
          subtracted = true
          newRanges.append(Multirange<Bound>.Range(another))
        }
      }
    }
    self.ranges = newRanges
  }
  public func subtracting(_ otherRange:Multirange<Bound>.Range) -> Multirange<Bound> {
    var set = self
    set.subtract(otherRange)
    return set
  }
  
  public mutating func subtract(_ otherRange:ClosedRange<Bound>) {
    self.subtract(Multirange<Bound>.Range(otherRange))
  }
  public func subtracting(_ otherRange:ClosedRange<Bound>) -> Multirange<Bound> {
    return self.subtracting(Multirange<Bound>.Range(otherRange))
  }
  
  public mutating func subtract(_ otherRange:LeftOpenRange<Bound>) {
    self.subtract(Multirange<Bound>.Range(otherRange))
  }
  public func subtracting(_ otherRange:LeftOpenRange<Bound>) -> Multirange<Bound> {
    return self.subtracting(Multirange<Bound>.Range(otherRange))
  }
  
  public mutating func subtract(_ otherRange:OpenRange<Bound>) {
    self.subtract(Multirange<Bound>.Range(otherRange))
  }
  public func subtracting(_ otherRange:OpenRange<Bound>) -> Multirange<Bound> {
    return self.subtracting(Multirange<Bound>.Range(otherRange))
  }
  
  public mutating func subtract(_ otherRange:Swift.Range<Bound>) {
    self.subtract(Multirange<Bound>.Range(otherRange))
  }
  public func subtracting(_ otherRange:Swift.Range<Bound>) -> Multirange<Bound> {
    return self.subtracting(Multirange<Bound>.Range(otherRange))
  }
  
  public mutating func subtract(_ otherRange:PartialRangeFrom<Bound>) {
    return self.subtract(Multirange<Bound>.Range(otherRange))
  }
  public func subtracting(_ otherRange:PartialRangeFrom<Bound>) -> Multirange<Bound> {
    return self.subtracting(Multirange<Bound>.Range(otherRange))
  }
  
  public mutating func subtract(_ otherRange:PartialRangeGreaterThan<Bound>) {
    self.subtract(Multirange<Bound>.Range(otherRange))
  }
  public func subtracting(_ otherRange:PartialRangeGreaterThan<Bound>) -> Multirange<Bound> {
    return self.subtracting(Multirange<Bound>.Range(otherRange))
  }
  
  public mutating func subtract(_ otherRange:PartialRangeThrough<Bound>) {
    return self.subtract(Multirange<Bound>.Range(otherRange))
  }
  public func subtracting(_ otherRange:PartialRangeThrough<Bound>) -> Multirange<Bound> {
    return self.subtracting(Multirange<Bound>.Range(otherRange))
  }
  
  public mutating func subtract(_ otherRange:PartialRangeUpTo<Bound>) {
    self.subtract(Multirange<Bound>.Range(otherRange))
  }
  public func subtracting(_ otherRange:PartialRangeUpTo<Bound>) -> Multirange<Bound> {
    return self.subtracting(Multirange<Bound>.Range(otherRange))
  }
  
  public mutating func subtract(_ value:Bound) {
    self.subtract(Multirange<Bound>.Range(singleValue:value))
  }
  public func subtracting(_ value:Bound) -> Multirange<Bound> {
    return self.subtracting(Multirange<Bound>.Range(singleValue:value))
  }
  
  public mutating func subtract(_ other:Multirange<Bound>) {
    for range in other.ranges {
      self.subtract(range)
    }
  }
  public func subtracting(_ other:Multirange<Bound>) -> Multirange<Bound> {
    var set = self
    set.subtract(other)
    return set
  }
}

