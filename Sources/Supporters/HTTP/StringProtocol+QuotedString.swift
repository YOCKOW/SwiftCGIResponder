/* *************************************************************************************************
 StringProtocol+QuotedString.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet

extension StringProtocol {
  /// See https://tools.ietf.org/html/rfc7230#section-3.2.6
  internal var _quotedString: String? {
    var quoted_scalars = String.UnicodeScalarView()
    quoted_scalars.append("\"")
    
    for scalar in self.unicodeScalars {
      guard UnicodeScalarSet.httpEscapableUnicodeScalars.contains(scalar) else { return nil }
      if !UnicodeScalarSet.httpQuotedTextAllowed.contains(scalar) {
        quoted_scalars.append(contentsOf:["\\", scalar])
      } else {
        quoted_scalars.append(scalar)
      }
    }
    
    quoted_scalars.append("\"")
    return String(quoted_scalars)
  }
  
  internal var _unquotedString: String? {
    let scalars = self.unicodeScalars
    guard scalars.count >= 2 else { return nil }
    guard let first = scalars.first, first == "\"", let last = scalars.last, last == "\"" else {
      return nil
    }
    
    let quoted_scalars =
      scalars[(scalars.index(after:scalars.startIndex)..<scalars.index(before:scalars.endIndex))]
    
    var unquoted_scalars = String.UnicodeScalarView()
    var escaped = false
    for scalar in quoted_scalars {
      if escaped || scalar != "\\" {
        guard UnicodeScalarSet.httpEscapableUnicodeScalars.contains(scalar) else { return nil }
        unquoted_scalars.append(scalar)
        escaped = false
      } else {
        escaped = true
      }
    }
    
    if escaped { return nil }
    
    return String(unquoted_scalars)
  }
}
