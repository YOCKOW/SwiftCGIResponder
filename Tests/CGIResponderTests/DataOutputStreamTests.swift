/* *************************************************************************************************
 DataOutputStreamTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import CGIResponder

import TemporaryFile

final class DataOutputStreamTests: XCTestCase {
  func test() {
    let source = TemporaryFile()
    var target = TemporaryFile()
    
    let data = "ABCD".data(using:.utf8)!
    
    source.write(data)
    source.seek(toFileOffset:0)
    
    source.write(to:&target)
    XCTAssertEqual(Int(target.offsetInFile), data.count)
    
    target.seek(toFileOffset:0)
    XCTAssertEqual(target.availableData, data)
  }
}


