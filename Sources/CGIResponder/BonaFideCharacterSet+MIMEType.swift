/***************************************************************************************************
 BonaFideCharacterSet+MIMEType.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
 
extension BonaFideCharacterSet {
  private static let _tspecials = BonaFideCharacterSet(charactersIn:"()<>@,;:\\\"/[]?=")
  public static let mimeTypeTokenAllowed = BonaFideCharacterSet(charactersIn:"!\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`abcdefghijklmnopqrstuvwxyz{|}~").subtracting(_tspecials)
}
