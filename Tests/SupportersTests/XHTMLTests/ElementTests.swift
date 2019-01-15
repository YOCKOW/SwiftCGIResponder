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
}




