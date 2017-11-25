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

/// Similar methods working with `Foundation.CharacterSet`
extension String {
  /// like `func components(separatedBy separator: CharacterSet) -> [String]`
  public func components(separatedBy separator:UnicodeScalarSet) -> [String] {
    var components: [String] = []
    var component = String.UnicodeScalarView()
    
    let scalars = self.unicodeScalars
    for scalar in scalars {
      if separator.contains(scalar) {
        components.append(String(component))
        component.removeAll(keepingCapacity:true)
      } else {
        component.append(scalar)
      }
    }
    components.append(String(component))
    
    return components
  }
  
  /// like `func trimmingCharacters(in set: CharacterSet) -> String`
  public func trimmingUnicodeScalars(in set: UnicodeScalarSet) -> String {
    let scalars = self.unicodeScalars
    
    var ii: String.UnicodeScalarView.Index
    
    // search first scalar that is not contained in `set`
    var start: String.UnicodeScalarView.Index? = nil
    ii = scalars.startIndex
    while true {
      if ii == scalars.endIndex { break }
      defer { ii = scalars.index(after:ii) }
      if !set.contains(scalars[ii]) { start = ii; break }
    }
    if start == nil { return "" }
    
    // search last scalar that is not contained in `set`
    var end: String.UnicodeScalarView.Index = scalars.endIndex
    ii = scalars.endIndex
    while true {
      if ii == scalars.startIndex { break }
      ii = scalars.index(before: ii)
      if !set.contains(scalars[ii]) { end = ii; break }
    }
    
    return String(scalars[start!...end])
  }
}
