/***************************************************************************************************
 Dictionary+Hashable.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/**
 
 Let Dictionary be Hashable.
 
 */
internal extension Dictionary where Value: Hashable {
  var hashValue : Int {
    var hh = 0
    for (key, value) in self {
      hh ^= key.hashValue
      hh ^= value.hashValue
    }
    return hh
  }
}
