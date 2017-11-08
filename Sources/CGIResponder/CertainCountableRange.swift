/***************************************************************************************************
 CertainCountableRange.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # CertainCountableRange
 Wrapper for any ranges.
 Would be implemented in the distant future.
 
 */
internal enum CertainCountableRange<Bound> where Bound: Strideable, Bound.Stride: SignedInteger {
  case empty
  case universal
  case closedRange(ClosedRange<Bound>)
  case countableClosedRange(CountableClosedRange<Bound>)
  case range(Range<Bound>)
  case countableRange(CountableRange<Bound>)
  case partialRangeFrom(PartialRangeFrom<Bound>)
  case countablePartialRangeFrom(CountablePartialRangeFrom<Bound>)
  case partialRangeThrough(PartialRangeThrough<Bound>)
  case partialRangeUpTo(PartialRangeUpTo<Bound>)
  
  init<R>(_ someRange:R) where R: RangeExpression, R.Bound == Bound {
    switch someRange {
    case let closedRange as ClosedRange<Bound>:
      self = closedRange.isEmpty ? .empty : .closedRange(closedRange)
    case let countableClosedRange as CountableClosedRange<Bound>:
      self = countableClosedRange.isEmpty ? .empty : .countableClosedRange(countableClosedRange)
    case let range as Range<Bound>:
      self = range.isEmpty ? .empty : .range(range)
    case let countableRange as CountableRange<Bound>:
      self = countableRange.isEmpty ? .empty : .countableRange(countableRange)
    case let partialRangeFrom as PartialRangeFrom<Bound>:
      self = .partialRangeFrom(partialRangeFrom)
    case let countablePartialRangeFrom as CountablePartialRangeFrom<Bound>:
      self = .countablePartialRangeFrom(countablePartialRangeFrom)
    case let partialRangeThrough as PartialRangeThrough<Bound>:
      self = .partialRangeThrough(partialRangeThrough)
    case let partialRangeUpTo as PartialRangeUpTo<Bound>:
      self = .partialRangeUpTo(partialRangeUpTo)
    default:
      fatalError("Unknown kind of range.")
    }
  }
}
