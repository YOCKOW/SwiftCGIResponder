/***************************************************************************************************
 (Un)CountableRangeExpression.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # (Un)CountableRangeExpression
 Protocols for ranges to be devided depending on their `Bound`s.
 
 */
internal protocol CountableRangeExpression: RangeExpression {
  associatedtype CountableBound: _Strideable
}
internal protocol UncountableRangeExpression: RangeExpression {
  associatedtype UncountableBound: Comparable
}

// Countable Ranges
extension CountableClosedRange: CountableRangeExpression {
  typealias CountableBound = Bound
  var closedRange: ClosedRange<Bound> {
    return ClosedRange(uncheckedBounds:(lower:self.lowerBound, upper:self.upperBound))
  }
}
extension CountablePartialRangeFrom: CountableRangeExpression {
  typealias CountableBound = Bound
  var partialRangeFrom: PartialRangeFrom<Bound> {
    return PartialRangeFrom(self.lowerBound)
  }
}
extension CountableRange: CountableRangeExpression {
  typealias CountableBound = Bound
  var range: Range<Bound> {
    return Range(uncheckedBounds:(lower:self.lowerBound, upper:self.upperBound))
  }
}

// Uncountable Ranges
extension ClosedRange: UncountableRangeExpression {
  typealias UncountableBound = Bound
}
extension ClosedRange where Bound: Strideable, Bound.Stride: SignedInteger {
  var countableClosedRange: CountableClosedRange<Bound> {
    return CountableClosedRange(uncheckedBounds:(lower:self.lowerBound, upper:self.upperBound))
  }
}

extension PartialRangeFrom: UncountableRangeExpression {
  typealias UncountableBound = Bound
}
extension PartialRangeFrom where Bound: Strideable, Bound.Stride: SignedInteger {
  var countablePartialRangeFrom: CountablePartialRangeFrom<Bound> {
    return CountablePartialRangeFrom(self.lowerBound)
  }
}

extension PartialRangeThrough: UncountableRangeExpression {
  typealias UncountableBound = Bound
}

extension PartialRangeUpTo: UncountableRangeExpression {
  typealias UncountableBound = Bound
}

extension Range: UncountableRangeExpression {
  typealias UncountableBound = Bound
}
extension Range where Bound: Strideable, Bound.Stride: SignedInteger {
  var countableRange: CountableRange<Bound> {
    return CountableRange(uncheckedBounds:(lower:self.lowerBound, upper:self.upperBound))
  }
}


