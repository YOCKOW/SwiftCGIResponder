/***************************************************************************************************
 LeftOpenRange.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # OpenRange
 A range that does not include its endpoints.
 
 */
public struct LeftOpenRange<Bound: Comparable>: RangeExpression {
  public let lowerBound: Bound
  public let upperBound: Bound
  public init(uncheckedBounds bounds: (lower: Bound, upper: Bound)) {
    self.lowerBound = bounds.lower
    self.upperBound = bounds.upper
  }
  
  public func contains(_ element: Bound) -> Bool {
    return self.lowerBound < element && element <= self.upperBound
  }
  
  /// This method should not be used because `lowerBound` must not be included in the range.
  /// Furthermore, `Indexable` has been deprecated in Swift 4.
  public func relative<C>(to collection:C) -> Range<Bound> where C: _Indexable, Bound == C.Index {
    fatalError("\(#function) is not supported.")
  }
}

// `<.<` cannot be defined.
// See https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html#//apple_ref/doc/uid/TP40014097-CH30-ID418
infix operator <‥: RangeFormationPrecedence
infix operator <--: RangeFormationPrecedence
public func <‥ <T>(lhs:T, rhs:T) -> LeftOpenRange<T> where T:Comparable {
  guard lhs < rhs else { fatalError("OpenRange: `lower` must be less than `upper`") }
  return LeftOpenRange<T>(uncheckedBounds:(lower:lhs, upper:rhs))
}
public func <-- <T>(lhs:T, rhs:T) -> LeftOpenRange<T> where T:Comparable {
  return lhs<‥rhs
}

extension LeftOpenRange: UncountableRangeExpression {
  typealias UncountableBound = Bound
}

extension LeftOpenRange {
  public var isEmpty: Bool { return lowerBound >= upperBound }
}

extension LeftOpenRange: Equatable {
  public static func ==(lhs:LeftOpenRange<Bound>, rhs:LeftOpenRange<Bound>) -> Bool {
    return lhs.lowerBound == rhs.lowerBound && lhs.upperBound == rhs.upperBound
  }
}

extension LeftOpenRange: CustomStringConvertible {
  public var description: String {
    return "\(self.lowerBound)<..\(self.upperBound)"
  }
}

extension LeftOpenRange {
  public func overlaps(_ other:ClosedRange<Bound>) -> Bool {
    return (!other.isEmpty && self.contains(other.upperBound)) || (!self.isEmpty && other.contains(self.upperBound))
  }
  public func overlaps(_ other:Range<Bound>) -> Bool {
    return (!other.isEmpty && self.contains(other.upperBound)) ||
      (!self.isEmpty && other.contains(self.upperBound)) ||
      (!self.isEmpty && !other.isEmpty && self.upperBound == other.upperBound)
  }
  public func overlaps(_ other:LeftOpenRange<Bound>) -> Bool {
    return (!other.isEmpty && self.contains(other.upperBound)) || (!self.isEmpty && other.contains(self.upperBound))
  }
  public func overlaps(_ other:OpenRange<Bound>) -> Bool {
    return (!other.isEmpty && self.contains(other.upperBound)) ||
      (!self.isEmpty && other.contains(self.upperBound)) ||
      (!self.isEmpty && !other.isEmpty && self.upperBound == other.upperBound)
  }
}

extension ClosedRange {
  public func overlaps(_ other:LeftOpenRange<Bound>) -> Bool {
    return other.overlaps(self)
  }
}

extension Range {
  public func overlaps(_ other:LeftOpenRange<Bound>) -> Bool {
    return other.overlaps(self)
  }
}
