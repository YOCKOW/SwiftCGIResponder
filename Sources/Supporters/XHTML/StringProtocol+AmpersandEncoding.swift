/* *************************************************************************************************
 StringProtocol+AmpersandEncoding.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet

private let _lt = "&lt;".unicodeScalars
private let _gt = "&gt;".unicodeScalars
private let _amp = "&amp;".unicodeScalars
private let _quot = "&quot;".unicodeScalars
private let _apos = "&apos;".unicodeScalars
private let _table: [UnicodeScalar:String.UnicodeScalarView] = [
  "<":_lt,
  ">":_gt,
  "&":_amp,
  "\"":_quot,
  "'":_apos
]

extension StringProtocol {
  public func
    addingAmpersandEncoding(withAllowedUnicodeScalars allowedScalars:UnicodeScalarSet) -> String
  {
    var resultScalars = String.UnicodeScalarView()
    for scalar in self.unicodeScalars {
      if let escapedScalars = _table[scalar] {
        resultScalars.append(contentsOf:escapedScalars)
      } else if allowedScalars.contains(scalar) {
        resultScalars.append(scalar)
      } else {
        resultScalars.append(
          contentsOf:"&#x\(String(scalar.value, radix:16, uppercase:true));".unicodeScalars
        )
      }
    }
    return String(resultScalars)
  }
}

private let _allowedScalars =
  UnicodeScalarSet.xmlNameCharacterScalars.union(.xmlWhitespaces).union(UnicodeScalarSet(unicodeScalarsIn:"\u{20}"..<"\u{7F}"))
extension StringProtocol {
  internal func _addingAmpersandEncoding() -> String {
    return self.addingAmpersandEncoding(withAllowedUnicodeScalars:_allowedScalars)
  }
}
