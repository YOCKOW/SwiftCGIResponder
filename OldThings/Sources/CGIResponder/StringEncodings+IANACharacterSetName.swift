/***************************************************************************************************
 StringEncodings+IANACharacterSetName.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
// Require both of CoreFoundation and Foundation
import CoreFoundation
import Foundation

extension String.Encoding {
  /// Get String.Encoding from CFString.Encoding
  public init(_ cfStringEncoding:CFString.Encoding) {
    self.init(rawValue:CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfStringEncoding.rawValue)))
  }
  
  /// Get IANA Character Set Name
  public var ianaCharacterSetName: String? {
    guard let cfCharSetName = CFString.Encoding(self).ianaCharacterSetName else { return nil }
    return String(cfCharSetName)
  }
  
  /// Initialize from IANA Character Set Name
  public init?(ianaCharacterSetName charSetName:String) {
    let cfStringEncoding = CFString.Encoding(ianaCharacterSetName:charSetName.coreFoundationString)
    if cfStringEncoding == .invalidIdentifier { return nil }
    self.init(cfStringEncoding)
  }
}

