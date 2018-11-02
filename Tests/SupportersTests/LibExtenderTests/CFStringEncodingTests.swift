/* *************************************************************************************************
 CFStringEncodingTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import LibExtender

import CoreFoundation
import Foundation

final class CFStringEncodingTests: XCTestCase {
  func test_initialization() {
    #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
    let utf8Value: CFStringBuiltInEncodings = CFStringBuiltInEncodings.UTF8
    #else
    let utf8Value: CFStringBuiltInEncodings = CFStringBuiltInEncodings(kCFStringEncodingUTF8)
    #endif
    
    let cfEncoding = CFString.Encoding(utf8Value)
    XCTAssertEqual(cfEncoding.rawValue, 0x08000100)
    
  }
  
  func test_constants() {
    XCTAssertEqual(CFString.Encoding(String.Encoding.utf8), .utf8)
  }
  
  
  static var allTests = [
    ("test_initialization", test_initialization),
    ("test_constants", test_constants)
  ]
}



