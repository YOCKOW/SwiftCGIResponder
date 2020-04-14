/* *************************************************************************************************
 ClientTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import XCTest
@testable import CGIResponder

import Foundation
import TemporaryFile

final class ClientTests: XCTestCase {
  func test_cookies() {
    let cookies = "name1=value1; name2=value2; name1=another_value1"
    withEnvironmentVariables(["HTTP_COOKIE":cookies]) {
      let items = Client.client.request.cookies()
      XCTAssertNotNil(items)
      XCTAssertEqual(items?[0].name, "name1")
      XCTAssertEqual(items?[0].value, "value1")
      XCTAssertEqual(items?[1].name, "name2")
      XCTAssertEqual(items?[1].value, "value2")
      XCTAssertEqual(items?[2].name, "name1")
      XCTAssertEqual(items?[2].value, "another_value1")
    }
  }
  
  func test_queryItems() {
    let urlQuery = "name1=value1&name2=value2"
    let postData = "name3=value3&name4".data(using:.utf8)!
    let contentType = ContentType(type:.application, subtype:"x-www-form-urlencoded")!
    let contentLength = postData.count
    
    let env: [String:String] = [
      "QUERY_STRING":urlQuery,
      "CONTENT_TYPE":contentType.description,
      "CONTENT_LENGTH":String(contentLength),
      "REQUEST_METHOD":"POST",
    ]
    
    withEnvironmentVariables(env) {
      withStandardInput(data:postData) {
        let queryItems = Client.client.request.queryItems
        XCTAssertNotNil(queryItems)
        XCTAssertEqual(queryItems?.first(where:{$0.name == "name1"})?.value, "value1")
        XCTAssertEqual(queryItems?.first(where:{$0.name == "name2"})?.value, "value2")
        XCTAssertEqual(queryItems?.first(where:{$0.name == "name3"})?.value, "value3")
        XCTAssertEqual(queryItems?.first(where:{$0.name == "name4"})?.value, nil)
        XCTAssertNotNil(queryItems?.first(where:{$0.name == "name4"}))
      }
    }
  }
  
  func test_formDataItems() throws {
    let CRLF = "\u{0D}\u{0A}"
    let boundary = "----this-is-test-boundary----"
    let testString =
      "--\(boundary)\(CRLF)" +
      "Content-Disposition: form-data; name=\"Key\"\(CRLF)" +
      "\(CRLF)" +
      "Value\(CRLF)" +
      "--\(boundary)\(CRLF)" +
      "Content-Disposition: form-data; name=\"AnotherKey\"\(CRLF)" +
      "X-Ignorable-Field: You can ignore this line!\(CRLF)" +
      "\(CRLF)" +
      "AnotherValue\(CRLF)" +
      "--\(boundary)\(CRLF)" +
      "Content-Disposition: form-data; name=\"File\"; filename=\"Filename.txt\"\(CRLF)" +
      "Content-Type: text/plain; charset=\"UTF-8\"\(CRLF)" +
      "Content-Transfer-Encoding: binary\(CRLF)" +
      "\(CRLF)" +
      "Hello, World!\n" +
      "\(CRLF)" +
      "--\(boundary)--\(CRLF)" +
      "ここまでは読み込まないでね。"
    let testData = testString.data(using:.utf8)!
    
    try withEnvironmentVariables(["CONTENT_TYPE":"multipart/form-data; boundary=\(boundary)"]) {
      try withStandardInput(data: testData) {
        let tmpDir = try TemporaryDirectory(prefix: "CGIResponder-ClientTests-")
        
        var iterator = try Client.client.request.formDataIterator(savingUploadedFilesIn: tmpDir)
        XCTAssertNotNil(iterator)
        
        let firstItem = iterator.next()
        XCTAssertNotNil(firstItem)
        XCTAssertEqual(firstItem?.name, "Key")
        guard case .string(let firstValue, encoding:_)? = firstItem?.value.content else { XCTFail(); return }
        XCTAssertEqual(firstValue, "Value")
        
        let secondItem = iterator.next()
        XCTAssertNotNil(secondItem)
        XCTAssertEqual(secondItem?.name, "AnotherKey")
        guard case .string(let secondValue, encoding:_)? = secondItem?.value.content else { XCTFail(); return }
        XCTAssertEqual(secondValue, "AnotherValue")
        
        let thirdItem = iterator.next()
        XCTAssertNotNil(thirdItem)
        XCTAssertEqual(thirdItem?.name, "File")
        XCTAssertEqual(thirdItem?.value.filename, "Filename.txt")
        XCTAssertEqual(thirdItem?.value.contentType,
                       ContentType(pathExtension:.txt, parameters:["charset":"UTF-8"]))
        guard case .temporaryFile(let temporaryFile) = thirdItem?.value.content else { XCTFail(); return }
        try temporaryFile.seek(toOffset: 0)
        XCTAssertEqual(temporaryFile.availableData, "Hello, World!\n".data(using:.utf8))
        
        let fourthItem = iterator.next()
        XCTAssertNil(fourthItem)
        
        try tmpDir.close()
      }
    }
  }
}


