/***************************************************************************************************
 UnicodeScalarSet+HTTP.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Ranges
import BonaFideCharacterSet

extension UnicodeScalarSet {
  private static let _space = UnicodeScalarSet(unicodeScalarsIn:"\u{0020}")
  private static let _horizontalTab = UnicodeScalarSet(unicodeScalarsIn:"\u{0009}")
  private static let _characters = UnicodeScalarSet(unicodeScalarsIn:UnicodeScalar(0x00)...UnicodeScalar(0x7F))
  private static let _controlCharacters = UnicodeScalarSet(unicodeScalarsIn:UnicodeScalar(0x00)...UnicodeScalar(0x1F)).union(UnicodeScalarSet(unicodeScalarsIn:"\u{007F}"))
  private static let _tspecials = UnicodeScalarSet(unicodeScalarsIn:"()<>@,;:\\\"/[]?=")
  
  // reference: [RFC 7230](https://tools.ietf.org/html/rfc7230#section-3.2)
  // RFC 7230 says `obs-fold` has been deprecated
  // and `obs-text` should not be used in historical reason. (#3.2.4)
  // `obs-` means obsoleted
  internal static let httpHeaderFieldDelimiterAllowed = UnicodeScalarSet(unicodeScalarsIn:"\"(),/:;<=>?@[\\]{}")
  internal static let visibleCharacterUnicodeScalars = UnicodeScalarSet(unicodeScalarsIn:UnicodeScalar(0x21)...UnicodeScalar(0x7E))
  public static let httpHeaderFieldNameAllowed = visibleCharacterUnicodeScalars.subtracting(httpHeaderFieldDelimiterAllowed)
  public static let httpHeaderFieldValueAllowed = visibleCharacterUnicodeScalars.union(_horizontalTab).union(_space)
  
  internal static let httpQuotedTextAllowed = UnicodeScalarSet(unicodeScalarsIn:"\u{0021}").union(UnicodeScalarSet(unicodeScalarsIn:"\u{0023}"..."\u{005B}")).union(UnicodeScalarSet(unicodeScalarsIn:"\u{005D}"..."\u{007E}")).union(_space).union(_horizontalTab)
  internal static let httpEscapableUnicodeScalars = visibleCharacterUnicodeScalars.union(_horizontalTab).union(_space)
  
  // https://tools.ietf.org/html/rfc2616#section-2.2
  public static let httpSeparatorAllowed = UnicodeScalarSet(unicodeScalarsIn:"()<>@,;:\\\"/[]?={}").union(_space).union(_horizontalTab)
  public static let httpTokenAllowed = _characters.subtracting(_controlCharacters).subtracting(httpSeparatorAllowed)
  
  // MIME Type
  public static let mimeTypeTokenAllowed = UnicodeScalarSet(unicodeScalarsIn:"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~").subtracting(_tspecials)
}

