/***************************************************************************************************
 BonaFideCharacterSet+RFC6265Cookie.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
extension BonaFideCharacterSet {
  internal static let cookieValueAllowed = BonaFideCharacterSet(charactersIn:
    "!#$%&'()*+-./0123456789:<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[]^_`abcdefghijklmnopqrstuvwxyz{|}~"
  )
}
