/***************************************************************************************************
 RangeSet.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/**
 
 # RangeSet
 Set of ranges
 
 */
public struct RangeSet<Bound> where Bound: Comparable {
  private var _elements: [CertainRange<Bound>]
  public init() { self._elements = [] }
}
