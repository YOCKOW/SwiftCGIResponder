/***************************************************************************************************
 String+LastIndex.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

extension String {
  public func lastIndex(of element:Character) -> String.Index? {
    return self.range(of:String(element), options:.backwards)?.lowerBound
  }
  
  public func lastIndex(where predicate: (Character) throws -> Bool) rethrows -> String.Index? {
    var ii = self.endIndex
    while true {
      if ii == self.startIndex { break }
      ii = self.index(before:ii)
      if try predicate(self[ii]) { return ii }
    }
    return nil
  }
}
