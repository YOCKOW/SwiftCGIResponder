/***************************************************************************************************
 TemporaryDirectoryTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class TemporaryDirectoryTests: XCTestCase {
  func testCreation() {
    let tmpDir = TemporaryDirectory.temporaryDirectory()
    XCTAssertNotNil(tmpDir)
    XCTAssertTrue(tmpDir!.url.path.hasPrefix(FileManager.default.temporaryDirectoryURL.path + "/"))
    tmpDir!.close()
  }
  
  static var allTests: [(String, (TemporaryDirectoryTests) -> () -> Void)] = [
    ("testCreation", testCreation),
  ]
}



