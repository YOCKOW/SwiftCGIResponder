/***************************************************************************************************
 UnicodeScalarSet+MIMEType.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
 
extension UnicodeScalarSet {
  private static let _tspecials = UnicodeScalarSet(unicodeScalarsIn:"()<>@,;:\\\"/[]?=")
  public static let mimeTypeTokenAllowed = UnicodeScalarSet(unicodeScalarsIn:UnicodeScalar(0x21)...UnicodeScalar(0x7E)).subtracting(_tspecials)
}
