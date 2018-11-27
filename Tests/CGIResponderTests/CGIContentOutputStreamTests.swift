/* *************************************************************************************************
 CGIContentOutputStreamTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import CGIResponder

final class CGIContentOutputStreamTests: XCTestCase {
  func test_pathForUnexistingFile() {
    let path = "--hoge/fuga/piyo--"
    let unexisting = CGIContent(fileAtPath:path)
    
    var output = Data()
    do {
      try checkWarning(.cannotOpenFileAtPath(path)) { try output.write(unexisting) }
    } catch CGIResponderError.illegalOperation {
      XCTAssertTrue(true)
    } catch {
      XCTFail("Must not be reached here.")
    }
  }
}


