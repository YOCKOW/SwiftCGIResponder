/* *************************************************************************************************
 UnicodeScalarSet+XML.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import BonaFideCharacterSet
import Ranges

extension UnicodeScalarSet {
  internal static let xmlCharacterScalars =
    UnicodeScalarSet(unicodeScalarsIn:"\u{09}\u{0A}\u{0D}").union(
      UnicodeScalarSet(unicodeScalarsIn:Unicode.Scalar(0x0020)!...Unicode.Scalar(0xD7FF)!)
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:Unicode.Scalar(0xE000)!...Unicode.Scalar(0xFFFD)!)
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:Unicode.Scalar(0x10000)!...Unicode.Scalar(0x10FFFF)!)
    )
  
  internal static let xmlWhitespaces = UnicodeScalarSet(unicodeScalarsIn:"\u{20}\u{09}\u{0D}\u{0A}")
  
  internal static let xmlNameStartCharacterScalars =
    UnicodeScalarSet(unicodeScalarsIn:":_").union(
      UnicodeScalarSet(unicodeScalarsIn:"A"..."Z")
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:"a"..."z")
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:"\u{C0}"..."\u{D6}")
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:"\u{D8}"..."\u{F6}")
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:"\u{F8}"..."\u{2FF}")
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:"\u{370}"..."\u{37D}")
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:"\u{37F}"..."\u{1FFF}")
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:"\u{200C}"..."\u{200D}")
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:"\u{2070}"..."\u{218F}")
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:"\u{2C00}"..."\u{2FEF}")
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:"\u{3001}"..."\u{D7FF}")
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:"\u{F900}"..."\u{FDCF}")
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:"\u{FDF0}"..."\u{FFFD}")
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:"\u{10000}"..."\u{EFFFF}")
    )
  
  internal static let xmlNameCharacterScalars = xmlNameStartCharacterScalars.union(
    UnicodeScalarSet(unicodeScalarsIn:"-.\u{B7}")
  ).union(
    UnicodeScalarSet(unicodeScalarsIn:"0"..."9")
  ).union(
    UnicodeScalarSet(unicodeScalarsIn:"\u{0300}"..."\u{036F}")
  ).union(
    UnicodeScalarSet(unicodeScalarsIn:"\u{203F}"..."\u{2040}")
  )
  
  internal static let xmlNoncolonizedNameScalars =
    xmlNameCharacterScalars.subtracting(UnicodeScalarSet(unicodeScalarsIn:":"))
}
