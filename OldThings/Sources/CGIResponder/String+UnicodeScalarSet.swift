/***************************************************************************************************
 String+UnicodeScalarSet.swift
   © 2017 YOCKOW.
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
  /// like `func addingPercentEncoding(withAllowedCharacters allowedCharacters: CharacterSet) -> String?`
  public func addingPercentEncoding(withAllowedUnicodeScalars allowedScalars:UnicodeScalarSet) -> String? {
    var output = String.UnicodeScalarView()
    for scalar in self.unicodeScalars {
      if allowedScalars.contains(scalar) {
        output.append(scalar)
      } else {
        let value = scalar.value
        if value <= 0x007F {
          output.append("%")
          output.append(contentsOf:String(value, radix:16).uppercased().unicodeScalars)
        } else if value <= 0x07FF {
          let bytes:(UInt8, UInt8) = (UInt8(0b11000000) | UInt8(value >> 6),
                                      UInt8(0b10000000) | UInt8(value & 0b00111111))
          output.append("%")
          output.append(contentsOf:String(bytes.0, radix:16).uppercased().unicodeScalars)
          output.append("%")
          output.append(contentsOf:String(bytes.1, radix:16).uppercased().unicodeScalars)
        } else if value <= 0xFFFF {
          let bytes:(UInt8, UInt8, UInt8) = (UInt8(0b11100000) | UInt8(value >> 12),
                                             UInt8(0b10000000) | UInt8(value >> 6 & 0b00111111),
                                             UInt8(0b10000000) | UInt8(value & 0b00111111))
          output.append("%")
          output.append(contentsOf:String(bytes.0, radix:16).uppercased().unicodeScalars)
          output.append("%")
          output.append(contentsOf:String(bytes.1, radix:16).uppercased().unicodeScalars)
          output.append("%")
          output.append(contentsOf:String(bytes.2, radix:16).uppercased().unicodeScalars)
        } else if value <= 0x1FFFFF {
          let bytes:(UInt8, UInt8, UInt8, UInt8) = (UInt8(0b11110000) | UInt8(value >> 18),
                                                    UInt8(0b10000000) | UInt8(value >> 12 & 0b00111111),
                                                    UInt8(0b10000000) | UInt8(value >> 6 & 0b00111111),
                                                    UInt8(0b10000000) | UInt8(value & 0b00111111))
          output.append("%")
          output.append(contentsOf:String(bytes.0, radix:16).uppercased().unicodeScalars)
          output.append("%")
          output.append(contentsOf:String(bytes.1, radix:16).uppercased().unicodeScalars)
          output.append("%")
          output.append(contentsOf:String(bytes.2, radix:16).uppercased().unicodeScalars)
          output.append("%")
          output.append(contentsOf:String(bytes.3, radix:16).uppercased().unicodeScalars)
        } else {
          return nil
        }
      }
    }
    return String(output)
  }
  
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
