/***************************************************************************************************
 CFStringEncoding.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

// Note: `CFStringEncoding` is `UInt32` both on macOS and Linux, on the other hand,
//       `CFStringEncodings` is Swift-enum on macOS and is `Int` on Linux, and furthermore,
//       `CFStringBuiltInEncodings` is Swift-enum on macOS and is `UInt32` on Linux.

import CoreFoundation
import Foundation

extension CFString {
  public struct Encoding: RawRepresentable {
    public typealias RawValue = CFStringEncoding
    public let rawValue: CFStringEncoding // aka UInt32
    public init(rawValue: CFStringEncoding) { self.rawValue = rawValue }
    
    public static let invalidIdentifier = Encoding(rawValue:kCFStringEncodingInvalidId)
  }
}

extension CFString.Encoding: Equatable {
  public static func ==(lhs:CFString.Encoding, rhs:CFString.Encoding) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }
}

extension CFString.Encoding {
  /// Initialize with `CFStringBuiltInEncodings`
  ///
  /// Note: `CFStringBuiltInEncodings` is defined as Swift's enum on Darwin, howerver,
  ///       it is an alias of `UInt32` on Linux.
  public init(_ encoding:CFStringBuiltInEncodings) {
    #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
    self.init(rawValue:CFStringEncoding(encoding.rawValue))
    #else
    self.init(rawValue:CFStringEncoding(encoding))
    #endif
  }
  
  /// Initialize with `CFStringEncodings`
  ///
  /// Note: `CFStringEncodings` is defined as Swift's enum on Darwin, howerver,
  ///       it is an alias of `Int` on Linux.
  public init(_ encoding:CFStringEncodings) {
    #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
    self.init(rawValue:CFStringEncoding(encoding.rawValue))
    #else
    self.init(rawValue:CFStringEncoding(encoding))
    #endif
  }
  
  /// Initialize with `String.Encoding`
  public init(_ stringEncoding:String.Encoding) {
    self.init(rawValue:CFStringConvertNSStringEncodingToEncoding(stringEncoding.rawValue))
  }
}

extension CFString.Encoding {
  /// Initialize with the name of CharacterSet registered by IANA such as "UTF-8"
  public init(ianaCharacterSetName:CFString) {
    self.init(rawValue:CFStringConvertIANACharSetNameToEncoding(ianaCharacterSetName))
  }
  
  /// The name of CharacterSet registered by IANA.
  public var ianaCharacterSetName: CFString? {
    return CFStringConvertEncodingToIANACharSetName(self.rawValue)
  }
}

