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
    
    XCTAssertEqual(grandchild.namespace(for:nil), "http://default/ns")
    XCTAssertEqual(grandchild.namespace(for:NoncolonizedName("myns")), "http://my/ns")
    XCTAssertEqual(grandchild.prefix(for:"http://my/ns"), "myns")
    XCTAssertEqual(grandchild.prefix(for:"http://default/ns"), Optional<NoncolonizedName>.none)
    XCTAssertEqual(grandchild.prefix(for:"http://invalid/ns"),
                   Optional<Optional<NoncolonizedName>>.none)
    
    XCTAssertEqual(child.namespace(for:nil), "http://default/ns")
    XCTAssertEqual(child.namespace(for:NoncolonizedName("myns")), "http://my/ns")
    XCTAssertEqual(child.prefix(for:"http://my/ns"), "myns")
    XCTAssertEqual(child.prefix(for:"http://default/ns"), Optional<NoncolonizedName>.none)
    XCTAssertEqual(child.prefix(for:"http://invalid/ns"),
                   Optional<Optional<NoncolonizedName>>.none)
    
    XCTAssertEqual(root.namespace(for:nil), "http://default/ns")
    XCTAssertEqual(root.namespace(for:NoncolonizedName("myns")), nil)
    XCTAssertEqual(root.prefix(for:"http://my/ns"), Optional<Optional<NoncolonizedName>>.none)
    XCTAssertEqual(root.prefix(for:"http://default/ns"), Optional<NoncolonizedName>.none)
    XCTAssertEqual(root.prefix(for:"http://invalid/ns"), Optional<Optional<NoncolonizedName>>.none)
    
    XCTAssertEqual(grandchild.attributes?[localName:"name", uri:nil], "value")
    XCTAssertEqual(grandchild.attributes?[localName:"name", uri:"http://default/ns"], "value")
    XCTAssertEqual(grandchild.attributes?[localName:"name", uri:"http://my/ns"], "my value")
    
    grandchild.attributes?[localName:"name", uri:"http://my/ns"] = "another value"
    XCTAssertEqual(grandchild.attributes?[localName:"name", uri:"http://my/ns"], "another value")

    child.attributes?[localName:"name", uri:"http://my/ns"] = "child value"
    XCTAssertEqual(child.attributes?["myns:name"], "child value")
  }
}




