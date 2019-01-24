/* *************************************************************************************************
 ParserTests.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import XHTML

import TestResources

final class ParserTests: XCTestCase {
  func test_parseSimpleXHTML5() {
    let document = try! Parser.parse(TestResources.shared.data(for:"XHTML/SimpleXHTML5.utf8.xhtml")!)
    XCTAssertEqual(document.title, "XHTML5")
  }
}



