/***************************************************************************************************
 String+UnicodeScalarSet.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
extension String {
  /// Returns true if all of unicode code points are contained in `unicodeScalars`
  public func consists(of unicodeScalars:UnicodeScalarSet) -> Bool {
    let scalars = self.unicodeScalars
    var ii = scalars.startIndex
    while true {
      if ii == scalars.endIndex { break }
      defer { ii = scalars.index(after:ii) }
      guard unicodeScalars.contains(scalars[ii]) else { return false }
    }
    return true
  }
}
