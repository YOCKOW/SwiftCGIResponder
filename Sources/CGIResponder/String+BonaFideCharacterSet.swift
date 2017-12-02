/***************************************************************************************************
 String+BonaFideCharacterSet.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
extension String {
  /// Returns true if all of characters are contained in `characters`
  public func consists(of characters:BonaFideCharacterSet) -> Bool {
    var ii = self.startIndex
    while true {
      if ii == self.endIndex { break }
      defer { ii = self.index(after:ii) }
      guard characters.contains(self[ii]) else { return false }
    }
    return true
  }
}

extension String {
  public func addingPercentEncoding(withAllowedCharacters allowedCharacters:BonaFideCharacterSet) -> String? {
    var result = ""
    for character in self {
      if allowedCharacters.contains(character) {
        result.append(character)
      } else {
        for value in String(character).utf8 {
          result += "%"
          result += String(value, radix:16).uppercased()
        }
      }
    }
    return result
  }
  
  public func trimmingCharacters(in set: BonaFideCharacterSet) -> String {
    var ii: String.Index
    
    // search first scalar that is not contained in `set`
    var start: String.Index? = nil
    ii = self.startIndex
    while true {
      if ii == self.endIndex { break }
      defer { ii = self.index(after:ii) }
      if !set.contains(self[ii]) { start = ii; break }
    }
    if start == nil { return "" }
    
    // search last scalar that is not contained in `set`
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
