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

/// Similar with `Foundation.CharacterSet`
extension BonaFideCharacterSet {
  /// ≒ Lt
  public static let capitalizedLetters: BonaFideCharacterSet = ._titlecaseLetter
  
  /// ≒ Cc + Cf
  public static let controlCharacters: BonaFideCharacterSet = BonaFideCharacterSet._control.union(._format)
  
  /// ≒ Nd
  public static let decimalDigits: BonaFideCharacterSet = ._decimalNumber
  
  /// ≒ L* + M*
  public static let letters: BonaFideCharacterSet = BonaFideCharacterSet._uppercaseLetter.union(._lowercaseLetter).union(._titlecaseLetter).union(._modifierLetter).union(._otherLetter).union(nonBaseCharacters)
  
  /// ≒ Ll
  public static let lowercaseLetters: BonaFideCharacterSet = ._lowercaseLetter
  
  /// new lines
  public static let newlines: BonaFideCharacterSet = ({ () -> BonaFideCharacterSet in
    var set = BonaFideCharacterSet()
    set.insert(charactersIn:"\u{000A}"..."\u{000D}")
    set.insert("\u{0085}")
    set.insert("\u{2028}")
    set.insert("\u{2029}")
    set.insert("\r\n") // This is also one `Character`. See https://www.unicode.org/reports/tr29/#GB3
    return set
  })()
  
  /// ≒ M*
  public static let nonBaseCharacters: BonaFideCharacterSet = BonaFideCharacterSet._nonspacingMark.union(._enclosingMark).union(._spacingMark)
  
  /// ≒ P*
  public static let punctuationCharacters: BonaFideCharacterSet = BonaFideCharacterSet._initialPunctuation.union(._finalPunctuation)
  
  /// ≒ S*
  public static let symbols: BonaFideCharacterSet = BonaFideCharacterSet._mathSymbol.union(._currencySymbol).union(._modifierSymbol).union(._otherSymbol)
  
  /// ≒ Lu + Lt
  public static let uppercaseLetters: BonaFideCharacterSet = capitalizedLetters.union(._uppercaseLetter)
  
  /// Same as `Foundation.CharacterSet.whitespaces`
  public static let whitespaces: BonaFideCharacterSet = ({ () -> BonaFideCharacterSet in
    var set = BonaFideCharacterSet()
    set.insert("\u{0009}")
    set.insert("\u{0020}")
    set.insert("\u{00A0}")
    set.insert("\u{1680}")
    set.insert(charactersIn:"\u{2000}"..."\u{200A}")
    set.insert("\u{202F}")
    set.insert("\u{205F}")
    set.insert("\u{3000}")
    return set
  })()
  
  public static let whitespacesAndNewlines = newlines.union(whitespaces)
}

/// Emoji
extension BonaFideCharacterSet {
  /// Flags
  public static let emojiFlags: BonaFideCharacterSet = BonaFideCharacterSet(charactersIn:"\u{1F1E6}\u{1F1E6}"..."\u{1F1FF}\u{1F1FF}")
  
  /// Keycaps
  public static let emojiKeycaps: BonaFideCharacterSet = ({ () -> BonaFideCharacterSet in
    var set = BonaFideCharacterSet()
    set.insert("\u{0023}\u{FE0F}\u{20E3}") // #️⃣
    set.insert("\u{002A}\u{FE0F}\u{20E3}") // *️⃣
    set.insert("\u{0030}\u{FE0F}\u{20E3}") // 0️⃣
    set.insert("\u{0031}\u{FE0F}\u{20E3}") // 1️⃣
    set.insert("\u{0032}\u{FE0F}\u{20E3}") // 2️⃣
    set.insert("\u{0033}\u{FE0F}\u{20E3}") // 3️⃣
    set.insert("\u{0034}\u{FE0F}\u{20E3}") // 4️⃣
    set.insert("\u{0035}\u{FE0F}\u{20E3}") // 5️⃣
    set.insert("\u{0036}\u{FE0F}\u{20E3}") // 6️⃣
    set.insert("\u{0037}\u{FE0F}\u{20E3}") // 7️⃣
    set.insert("\u{0038}\u{FE0F}\u{20E3}") // 8️⃣
    set.insert("\u{0039}\u{FE0F}\u{20E3}") // 9️⃣
    return set
  })()
}
