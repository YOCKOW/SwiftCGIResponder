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

/// Similar (not same) with `Foundation.CharacterSet`
extension BonaFideCharacterSet {
  /// ≒ L* + M* + N*
  public static let alphanumerics = BonaFideCharacterSet(UnicodeScalarSet.alphanumerics)
  
  /// ≒ Lt
  public static let capitalizedLetters = BonaFideCharacterSet(UnicodeScalarSet.capitalizedLetters)

  /// ≒ Cc + Cf
  public static let controlCharacters = BonaFideCharacterSet(UnicodeScalarSet.controlCharacters)

  /// ≒ Nd
  public static let decimalDigits = BonaFideCharacterSet(UnicodeScalarSet.decimalDigits)

  /// ≒ L* + M*
  public static let letters = BonaFideCharacterSet(UnicodeScalarSet.letters)

  /// ≒ Ll
  public static let lowercaseLetters = BonaFideCharacterSet(UnicodeScalarSet.lowercaseLetters)

  /// new lines
  public static let newlines: BonaFideCharacterSet = BonaFideCharacterSet(
    Multirange<Character>.Range("\u{000A}"..."\u{000D}"),
    Multirange<Character>.Range(singleValue:"\u{0085}"),
    Multirange<Character>.Range(singleValue:"\u{2028}"),
    Multirange<Character>.Range(singleValue:"\u{2029}"),
    Multirange<Character>.Range(singleValue:"\r\n") // This is also one `Character`. See https://www.unicode.org/reports/tr29/#GB3
  )

  /// ≒ M*
  public static let nonBaseCharacters = BonaFideCharacterSet(UnicodeScalarSet.nonBaseCharacters)

  /// ≒ P*
  public static let punctuationCharacters = BonaFideCharacterSet(UnicodeScalarSet.punctuationCharacters)

  /// ≒ S*
  public static let symbols = BonaFideCharacterSet(UnicodeScalarSet.symbols)

  /// ≒ Lu + Lt
  public static let uppercaseLetters = BonaFideCharacterSet(UnicodeScalarSet.uppercaseLetters)

  /// Same as `Foundation.CharacterSet.whitespaces`
  public static let whitespaces: BonaFideCharacterSet = BonaFideCharacterSet(
    Multirange<Character>.Range(singleValue:"\u{0009}"),
    Multirange<Character>.Range(singleValue:"\u{0020}"),
    Multirange<Character>.Range(singleValue:"\u{00A0}"),
    Multirange<Character>.Range(singleValue:"\u{1680}"),
    Multirange<Character>.Range("\u{2000}"..."\u{200A}"),
    Multirange<Character>.Range(singleValue:"\u{202F}"),
    Multirange<Character>.Range(singleValue:"\u{205F}"),
    Multirange<Character>.Range(singleValue:"\u{3000}")
  )

  public static let whitespacesAndNewlines = newlines.union(whitespaces)
}

/// Emoji
extension BonaFideCharacterSet {
  /// Flags
  public static let emojiFlags: BonaFideCharacterSet = BonaFideCharacterSet(charactersIn:"\u{1F1E6}\u{1F1E6}"..."\u{1F1FF}\u{1F1FF}")
  
  /// Keycaps
  public static let emojiKeycaps: BonaFideCharacterSet = BonaFideCharacterSet(
    Multirange<Character>.Range(singleValue:"\u{0023}\u{FE0F}\u{20E3}"), // #️⃣
    Multirange<Character>.Range(singleValue:"\u{002A}\u{FE0F}\u{20E3}"), // *️⃣
    Multirange<Character>.Range(singleValue:"\u{0030}\u{FE0F}\u{20E3}"), // 0️⃣
    Multirange<Character>.Range(singleValue:"\u{0031}\u{FE0F}\u{20E3}"), // 1️⃣
    Multirange<Character>.Range(singleValue:"\u{0032}\u{FE0F}\u{20E3}"), // 2️⃣
    Multirange<Character>.Range(singleValue:"\u{0033}\u{FE0F}\u{20E3}"), // 3️⃣
    Multirange<Character>.Range(singleValue:"\u{0034}\u{FE0F}\u{20E3}"), // 4️⃣
    Multirange<Character>.Range(singleValue:"\u{0035}\u{FE0F}\u{20E3}"), // 5️⃣
    Multirange<Character>.Range(singleValue:"\u{0036}\u{FE0F}\u{20E3}"), // 6️⃣
    Multirange<Character>.Range(singleValue:"\u{0037}\u{FE0F}\u{20E3}"), // 7️⃣
    Multirange<Character>.Range(singleValue:"\u{0038}\u{FE0F}\u{20E3}"), // 8️⃣
    Multirange<Character>.Range(singleValue:"\u{0039}\u{FE0F}\u{20E3}")  // 9️⃣
  )
}
