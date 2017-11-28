/***************************************************************************************************
 Substring+UnicodeScalarSet.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
extension Substring {
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

extension Substring {
  public func addingPercentEncoding(withAllowedUnicodeScalars allowedScalars:UnicodeScalarSet) -> String? {
    return String(self).addingPercentEncoding(withAllowedUnicodeScalars:allowedScalars)
  }
}
