/***************************************************************************************************
 PartialRangeGreaterThan.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # PartialRangeGreaterThan
 A partial interval extending upward from a lower bound, but excluding the lower bound.
 
 */
public struct PartialRangeGreaterThan<Bound: Comparable>: RangeExpression {
  public let lowerBound: Bound
  public init(_ lowerBound: Bound) { self.lowerBound = lowerBound }
  
  public func contains(_ element: Bound) -> Bool {
    return lowerBound < element
  }
  
  /// This method should not be used because `lowerBound` must not be included in the range.
  /// Furthermore, `Indexable` has been deprecated in Swift 4.
  public func relative<C>(to collection:C) -> Range<Bound> where C: _Indexable, Bound == C.Index {
    fatalError("\(#function) is not supported.")
  }
}

// `<..` cannot be defined.
// See https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html#//apple_ref/doc/uid/TP40014097-CH30-ID418
postfix operator <‥
postfix operator <--
public postfix func <‥ <T>(_ element:T) -> PartialRangeGreaterThan<T> where T:Comparable {
  return PartialRangeGreaterThan<T>(element)
}
public postfix func <-- <T>(_ element:T) -> PartialRangeGreaterThan<T> where T:Comparable {
  return element<‥
}

extension PartialRangeGreaterThan: UncountableRangeExpression {
  typealias UncountableBound = Bound
}

extension PartialRangeGreaterThan: CustomStringConvertible {
  public var description: String {
    return "\(self.lowerBound)<.."
  }
}
