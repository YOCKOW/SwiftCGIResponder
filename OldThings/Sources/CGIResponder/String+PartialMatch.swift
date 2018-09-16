/***************************************************************************************************
 String+PartialMatch.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
extension String {
  public func matches(_ string:String, from start:String.Index? = nil) -> Bool {
    if self.isEmpty { return false }
    if string.isEmpty { return true }
    
    var si = start == nil ? self.startIndex : start!
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