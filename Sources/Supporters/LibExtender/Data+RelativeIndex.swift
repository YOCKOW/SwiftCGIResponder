/* *************************************************************************************************
 Data+RelativeIndex.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

extension Data {
  /// Represetnts the distance from `startIndex`.
  public struct RelativeIndex: Comparable {
    private var _distance: Data.Index
    fileprivate init(_ distance:Int) {
      assert(distance >= 0)
      self._distance = distance
    }
    
    public init?(distance:Int) {
      guard distance >= 0 else { return nil }
      self.init(distance)
    }
    
    fileprivate func actualIndex(for data:Data) -> Data.Index {
      return data.startIndex + self._distance
    }
    
    fileprivate static func +(lhs:RelativeIndex, rhs:Int) -> RelativeIndex {
      return RelativeIndex(lhs._distance + rhs)
    }
    
    public static func <(lhs:RelativeIndex, rhs:RelativeIndex) -> Bool {
      return lhs._distance < rhs._distance
    }
  }
  
  public var relativeStartIndex: RelativeIndex {
    return RelativeIndex(0)
  }
  
  public var relativeEndIndex: RelativeIndex {
    return RelativeIndex(self.endIndex - self.startIndex)
  }
  
  public func relativeIndex(_ relativeIndex:RelativeIndex, offsetBy distance:Int) -> RelativeIndex {
    return relativeIndex + distance
  }
  
  public func relativeIndex(after index:RelativeIndex) -> RelativeIndex {
    return self.relativeIndex(index, offsetBy:1)
  }
  
  public func relativeIndex(before index:RelativeIndex) -> RelativeIndex {
    return self.relativeIndex(index, offsetBy:-1)
  }
  
  public subscript(_ relativeIndex:RelativeIndex) -> UInt8 {
    get {
      return self[relativeIndex.actualIndex(for:self)]
    }
    set {
      self[relativeIndex.actualIndex(for:self)] = newValue
    }
  }
  
  public subscript(_ relativeBounds:Range<RelativeIndex>) -> Data {
    get {
      let lower = relativeBounds.lowerBound.actualIndex(for:self)
      let upper = relativeBounds.upperBound.actualIndex(for:self)
      return self[lower..<upper]
    }
    set {
      let lower = relativeBounds.lowerBound.actualIndex(for:self)
      let upper = relativeBounds.upperBound.actualIndex(for:self)
      self[lower..<upper] = newValue
    }
  }
}
