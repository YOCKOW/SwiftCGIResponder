/***************************************************************************************************
 AnyIterator+FormDataItemTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class AnyIterator_FormDataItemTests: XCTestCase {
  func testParse() {
    let boundary = "----this-is-test-boundary----"
    let testString =
      "--\(boundary)\r\n" +
      "Content-Disposition: form-data; name=\"Key\"\r\n" +
      "\r\n" +
      "Value\r\n" +
      "--\(boundary)\r\n" +
      "Content-Disposition: form-data; name=\"AnotherKey\"\r\n" +
      "\r\n" +
      "AnotherValue\r\n" +
      "--\(boundary)\r\n" +
      "Content-Disposition: form-data; name=\"File\"; filename=\"Filename.txt\"\r\n" +
      "Content-Type: text/plain; charset=\"UTF-8\"\r\n" +
      "Content-Transfer-Encoding: binary\r\n"
      "\r\n" +
      "Hello, World!\n" +
      "\r\n" +
      "--\(boundary)--\r\n" +
      "ここまでは読み込まないでね。"
    let testData = testString.data(using:.utf8)!
    let expectedNumberOfItems = 3
    
    let testFile = TemporaryFile()!
    defer { testFile.close() }
    testFile.write(testData)
    testFile.seek(toFileOffset:0)
    
    let tmpDir = TemporaryDirectory.temporaryDirectory()!
    defer { tmpDir.close() }
    
    let iterator = AnyIterator<FormDataItem>(with:testFile.fileHandle,
                                             boundary:boundary,
                                             stringEncoding:.utf8,
                                             temporaryDirectory:tmpDir)
    var count = 0
    for item in iterator {
      defer { count += 1 }
      switch count {
      case 0:
        XCTAssertEqual(item.name, "Key")
        guard case .string(let string, _) = item.value.content else {
          XCTFail("Unexpected Content.")
          return
        }
        XCTAssertEqual(string, "Value")
      case 1:
        XCTAssertEqual(item.name, "AnotherKey")
        guard case .string(let string, _) = item.value.content else {
          XCTFail("Unexpected Content.")
          return
        }
        XCTAssertEqual(string, "AnotherValue")
      case 2:
        XCTAssertEqual(item.name, "File")
        XCTAssertEqual(item.value.filename, "Filename.txt")
        XCTAssertEqual(item.value.contentType, MIMEType(pathExtension:.txt, parameters:["charset":"UTF-8"]))
        guard case .temporaryFile(let tmp) = item.value.content else {
          XCTFail("Unexpected Content.")
          return
        }
        tmp.seek(toFileOffset:0)
        XCTAssertEqual(tmp.availableData, "Hello, World!\n".data(using:.utf8)!)
      default:
        XCTFail("Too much items...")
      }
    }
  }
  
  static var allTests: [(String, (AnyIterator_FormDataItemTests) -> () -> Void)] = [
    ("testParse", testParse),
  ]
}




