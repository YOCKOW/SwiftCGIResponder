/***************************************************************************************************
 CFString+String.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import CoreFoundation

/// Note: On Linux, `String` <-> `CFString` is NOT implicitly casted.
/// Note: "Convenience initializers are not supported in extensions of CF types"

extension String {
  public init?(_ cfString:CFString) {
    let bufferSize = CFStringGetMaximumSizeForEncoding(CFStringGetLength(cfString), CFString.Encoding.UTF8.rawValue)
    let buffer = UnsafeMutablePointer<CChar>.allocate(capacity:bufferSize)
    defer { buffer.deallocate(capacity:bufferSize) }
    guard CFStringGetCString(cfString, buffer, bufferSize, CFString.Encoding.UTF8.rawValue) else { return nil }
    self.init(utf8String:buffer)
  }
  
  public var coreFoundationString: CFString {
    return self.withCString { (cString:UnsafePointer<CChar>) -> CFString in
      return CFStringCreateWithCString(nil, cString, CFString.Encoding.UTF8.rawValue)
    }
  }
}
