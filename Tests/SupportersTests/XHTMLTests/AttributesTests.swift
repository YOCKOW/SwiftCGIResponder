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
  
  func test_namespace() {
    let attributes: Attributes = [
      "xmlns":"http://default/namespace",
      "xmlns:myns":"http://my/ns",
      "name":"value",
      "myns:name":"my value"
    ]
    
    // TODO: Add more tests
    XCTAssertEqual(attributes[localName:"name", uri:"http://default/namespace"], "value")
    XCTAssertEqual(attributes[localName:"name", uri:"http://my/ns"], "my value")
    XCTAssertNil(attributes[localName:"name", uri:"http://other/ns"])
  }
}

