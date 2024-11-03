/* *************************************************************************************************
 CGIContentOutputStreamTests.swift
   © 2018,2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

@testable import CGIResponder
import Foundation

#if swift(>=6) && canImport(Testing)
import Testing

@Suite final class CGIContentOutputStreamTests {
  @Test func test_pathForUnexistingFile() {
    let path = "--hoge/fuga/piyo--"
    let unexisting = CGIContent(fileAtPath:path)

    var output = Data()
    #expect(throws: CGIResponderError.illegalOperation) {
      try output.write(unexisting)
    }
  }
}
#else
import XCTest

final class CGIContentOutputStreamTests: XCTestCase {
  func test_pathForUnexistingFile() {
    let path = "--hoge/fuga/piyo--"
    let unexisting = CGIContent(fileAtPath:path)
    
    var output = Data()
    do {
      try output.write(unexisting)
    } catch CGIResponderError.illegalOperation {
      XCTAssertTrue(true)
    } catch {
      XCTFail("Must not be reached here.")
    }
  }
}
#endif
