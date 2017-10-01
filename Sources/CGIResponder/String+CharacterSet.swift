/***************************************************************************************************
 String+CharacterSet.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
extension String {
  public func trimmingCharacters(in set: CGICharacterSet) -> String {
    var ii: String.Index
    
    // search first character that is not contained in `set`
    var start: String.Index? = nil
    ii = self.startIndex
    while true {
      if ii == self.endIndex { break }
      defer { ii = self.index(after:ii) }
      if !set.contains(self[ii]) { start = ii; break }
    }
    if start == nil { return "" }
    
    // search last character that is not contained in `set`
    var end: String.Index = self.endIndex
    ii = self.endIndex
    while true {
      if ii == self.startIndex { break }
      ii = self.index(before: ii)
      if !set.contains(self[ii]) { end = ii; break }
    }
    
    return String(self[start!...end])
  }
}
