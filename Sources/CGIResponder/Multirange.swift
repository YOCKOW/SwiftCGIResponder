/***************************************************************************************************
 Multirange.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/**
 
 # Multirange
 Represents for multiple ranges.
 
 */
public struct Multirange<Bound> where Bound: Comparable {
  public struct Range {
    fileprivate var range: CertainRange<Bound>
    fileprivate init(_ range:CertainRange<Bound>) { self.range = range }
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
  public init(_ value:Bound) { self.init(CertainRange<Bound>(value)) }
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
    set { self._ranges = newValue; self._normalize() }
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
    self.insert(Multirange<Bound>.Range(newValue))
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

