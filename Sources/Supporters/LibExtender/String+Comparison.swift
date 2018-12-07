/* *************************************************************************************************
 String+Comparison.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
extension String {
  /// Returns Boolean value that indecates whether the receiver has substring
  /// that matches `string` from `start`.
  public func matches(_ string:String, from start:String.Index? = nil) -> Bool {
    if self.isEmpty { return false }
    if string.isEmpty { return true }
    
    var si = start ?? self.startIndex
    var ci = string.startIndex
    
    while true {
      guard self[si] == string[ci] else { return false }
      si = self.index(after:si)
      ci = string.index(after:ci)
      
      switch (si, ci) {
      case (_, string.endIndex): return true
      case (self.endIndex, _): return false
      default: continue
      }
    }
  }
}
