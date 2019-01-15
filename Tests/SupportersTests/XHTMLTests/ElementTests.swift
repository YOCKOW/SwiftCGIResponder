/* *************************************************************************************************
 ElementTests.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import XHTML

final class ElementTests: XCTestCase {
  func test_xhtmlString() {
    let element = Element(name:"element")
    element.attributes = ["name":"value&value"]
    
    XCTAssertEqual(element.xhtmlString, "<element name=\"value&amp;value\" />")
  }
  
  func test_classSelector() {
    let element =
      Element(name:"title", attributes:["xmlns":"http://www.w3.org/1999/xhtml"], parent:nil)
    XCTAssertTrue(element is TitleElement)
  }
  
  func test_namespace() {
    let grandchild = Element(name:"grandchild", attributes:["name":"value", "myns:name":"my value"])
    let child = Element(name:"child", attributes:["xmlns:myns":"http://my/ns"], children:[grandchild])
    let root = Element(name:"root", attributes:["xmlns":"http://default/ns"], children:[child])
    
    XCTAssertEqual(grandchild.attributes?[localName:"name", uri:nil], "value")
    XCTAssertEqual(grandchild.attributes?[localName:"name", uri:"http://default/ns"], "value")
    XCTAssertEqual(grandchild.attributes?[localName:"name", uri:"http://my/ns"], "my value")
    XCTAssertEqual(root._prefix(for:"http://default/ns"), "xmlns")
    XCTAssertEqual(root._prefix(for:"http://my/ns"), nil)
    XCTAssertEqual(child._prefix(for:"http://my/ns"), "myns")
    
    grandchild.attributes?[localName:"name", uri:"http://my/ns"] = "another value"
    XCTAssertEqual(grandchild.attributes?[localName:"name", uri:"http://my/ns"], "another value")
    
    child.attributes?[localName:"name", uri:"http://my/ns"] = "child value"
    XCTAssertEqual(child.attributes?["myns:name"], "child value")
  }
}




