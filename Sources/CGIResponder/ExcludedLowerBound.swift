/***************************************************************************************************
 ExcludedLowerBound.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 

/**
 
 Workaround for operators of left-open ranges.
  "If an operator doesn’t begin with a dot, it can’t contain a dot elsewhere."
 So, ...
 
 */
public struct _ExcludedLowerBound<Bound> where Bound:Comparable {
  public let lowerBound:Bound
  public init(_ lowerBound:Bound) { self.lowerBound = lowerBound }
}

postfix operator <
public postfix func < <T>(_ lowerBound:T) -> _ExcludedLowerBound<T> where T:Comparable {
  return _ExcludedLowerBound<T>(lowerBound)
}

postfix operator ..
public postfix func .. <T>(_ excludingLowerBound:_ExcludedLowerBound<T>) -> PartialRangeGreaterThan<T> {
  return PartialRangeGreaterThan<T>(excludingLowerBound.lowerBound)
}

infix operator ..: RangeFormationPrecedence
public func .. <T>(lhs:_ExcludedLowerBound<T>, rhs:T) -> LeftOpenRange<T> {
  return lhs.lowerBound<--rhs
}

infix operator .<: RangeFormationPrecedence
public func .< <T>(lhs:_ExcludedLowerBound<T>, rhs:T) -> OpenRange<T> {
  return lhs.lowerBound<-<rhs
}
