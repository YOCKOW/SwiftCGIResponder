/* *************************************************************************************************
 String+CFString.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import CoreFoundation

// Note: On Linux, `String` <-> `CFString` is NOT implicitly casted.
// Note: "Convenience initializers are not supported in extensions of CF types"

extension String {
  public init?(_ cfString:CFString) {
    let bufferSize = CFStringGetMaximumSizeForEncoding(CFStringGetLength(cfString),
                                                       CFString.Encoding.utf8.rawValue) + 1
    let buffer = UnsafeMutablePointer<CChar>.allocate(capacity:bufferSize)
    defer { buffer.deallocate() }
    
    
    guard CFStringGetCString(cfString, buffer, bufferSize, CFString.Encoding.utf8.rawValue) else {
      return nil
    }
    self.init(utf8String:buffer)
  }

  public var coreFoundationString: CFString {
    return self.withCString { (cString:UnsafePointer<CChar>) -> CFString in
      return CFStringCreateWithCString(nil, cString, CFString.Encoding.utf8.rawValue)
    }
  }
}

