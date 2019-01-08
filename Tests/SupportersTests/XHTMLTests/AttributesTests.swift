/* *************************************************************************************************
 AttributesTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import XHTML

final class AttributesTests: XCTestCase {
  func test_initialzation() {
    let dic:[String:String] = ["xmlns":"http://foo/bar",
                               "xmlns:myns":"http://my/ns",
                               "name":"value"]
    let attributes = Attributes(dic)
    
    XCTAssertEqual(attributes["xmlns"], "http://foo/bar")
    XCTAssertEqual(attributes["xmlns:myns"], "http://my/ns")
    XCTAssertEqual(attributes["name"], "value")
    XCTAssertEqual(attributes[localName:"name", uri:nil], "value")
  }
}

