/***************************************************************************************************
 BonaFideCharacterSet+SpecifiedSets.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/**
 
 
 # Convenient sets of `BonaFideCharacterSet`
 In some cases, you should use `UnicodeScalarSet` rather than this.
 
 
 */
extension BonaFideCharacterSet {
  public static let newlines: BonaFideCharacterSet = ({ () -> BonaFideCharacterSet in
    var set = BonaFideCharacterSet()
    set.insert(charactersIn:"\u{000A}"..."\u{000D}")
    set.insert("\u{0085}")
    set.insert("\u{2028}")
    set.insert("\u{2029}")
    set.insert("\r\n") // This is also one `Character`. See https://www.unicode.org/reports/tr29/#GB3
    return set
  })()
}
