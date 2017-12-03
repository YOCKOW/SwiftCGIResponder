/***************************************************************************************************
 ContentTransferEncodingRepresentation.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/**
 
 # ContentTransferEncodingRepresentation
 Represents for "Content-Transfer-Encoding".
 It may not be used directly, but you can use with `HTTPHeaderFieldDelegate.ContentTransferEncoding`.
 
 */
public enum ContentTransferEncodingRepresentation: String {
  case _7bit = "7bit"
  case _8bit = "8bit"
  case base64 = "base64"
  case binary = "binary"
  case quotedPrintable = "quoted-printable"
  public init?(rawValue:String) {
    switch rawValue.lowercased() {
    case "7bit": self = ._7bit
    case "8bit": self = ._8bit
    case "base64": self = .base64
    case "binary": self = .binary
    case "quoted-printable": self = .quotedPrintable
    default: return nil
    }
  }
}

/// You can also use `ContentTransferEncoding` as its type.
public typealias ContentTransferEncoding = ContentTransferEncodingRepresentation
