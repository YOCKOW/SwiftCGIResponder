/* *************************************************************************************************
 StringEncodings+IANACharacterSetName.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import CoreFoundation

extension String.Encoding {
  /// Initialize with `CFString.Encoding`
  public init(_ cfStringEncoding:CFString.Encoding) {
    self.init(rawValue:CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(cfStringEncoding.rawValue)))
  }
  
  /// Get IANA Character Set Name
  public var ianaCharacterSetName: String? {
    guard let cfCharSetName = CFString.Encoding(self).ianaCharacterSetName else { return nil }
    return String(cfCharSetName)
  }
  
  /// Initialize with IANA Character Set Name
  public init?(ianaCharacterSetName charSetName:String) {
    let cfStringEncoding = CFString.Encoding(ianaCharacterSetName:charSetName.coreFoundationString)
    if cfStringEncoding == .invalidIdentifier { return nil }
    self.init(cfStringEncoding)
  }
}
