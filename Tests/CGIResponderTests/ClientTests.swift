/* *************************************************************************************************
 ClientTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import XCTest
@testable import CGIResponder

import Foundation

final class ClientTests: XCTestCase {
  func test_cookies() {
    let cookies = "name1=value1; name2=value2; name1=another_value1"
    executeUnderTemporaryEnvironment(["HTTP_COOKIE":cookies]) {
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
    
    executeUnderTemporaryEnvironment(env) {
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
}


