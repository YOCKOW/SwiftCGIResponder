/***************************************************************************************************
 TemporaryDirectoryTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class TemporaryDirectoryTests: XCTestCase {
  func testCreationAndClose() {
    let tmpDir = TemporaryDirectory.temporaryDirectory()
    XCTAssertNotNil(tmpDir)
    
    let url = tmpDir!.url
    XCTAssertTrue(url.isLocalDirectory)
    XCTAssertTrue(url.path.hasPrefix(URL.temporaryDirectory.path + "/"))
    
    tmpDir!.close()
    XCTAssertFalse(url.isLocalDirectory)
    XCTAssertFalse(url.isLocalFile)
  }
  
  static var allTests: [(String, (TemporaryDirectoryTests) -> () -> Void)] = [
    ("testCreationAndClose", testCreationAndClose),
  ]
}



