/***************************************************************************************************
 TemporaryFileTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class TemporaryFileTests: XCTestCase {
  func testCreation() {
    let manager = FileManager.default
    
    let data = "Hello, World!".data(using:.utf8)!
    let tmpDir = TemporaryDirectory.temporaryDirectory()
    XCTAssertNotNil(tmpDir)
    
    let tmpFile1 = TemporaryFile(in:tmpDir!, prefix:"Test1-", suffix:".txt", contents:nil)
    XCTAssertEqual(tmpDir!.temporaryFiles.count, 1)
    XCTAssertNotNil(tmpFile1)
    tmpFile1!.write(data)
    XCTAssertEqual(tmpFile1!.offsetInFile, UInt64(data.count))
    tmpFile1!.seek(toFileOffset:0)
    XCTAssertEqual(tmpFile1!.availableData, data)
    
    let tmpFile2 = TemporaryFile(in:tmpDir!, prefix:"Test2-", suffix:".txt", contents:data)
    XCTAssertEqual(tmpDir!.temporaryFiles.count, 2)
    XCTAssertNotNil(tmpFile2)
    tmpFile2!.seek(toFileOffset:0)
    XCTAssertEqual(tmpFile2!.availableData, data)
    
    XCTAssertTrue(tmpDir!.close())
    // When directory is closing, the temporary files in it are also closing.
    XCTAssertEqual(tmpDir!.temporaryFiles.count, 0)
    XCTAssertTrue(tmpFile1!.isClosed)
    XCTAssertTrue(tmpFile2!.isClosed)
    
    XCTAssertFalse(manager.fileExists(at:tmpFile1!.url)!.exists)
    XCTAssertFalse(manager.fileExists(at:tmpFile2!.url)!.exists)
    XCTAssertFalse(manager.fileExists(at:tmpDir!.url)!.exists)
  }
  
  static var allTests: [(String, (TemporaryFileTests) -> () -> Void)] = [
    ("testCreation", testCreation),
  ]
}




