/* *************************************************************************************************
 NamesTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import XCTest
@testable import XHTML

final class NamesTests: XCTestCase {
  func test_NCName() {
    XCTAssertNotNil(NoncolonizedName("名前"))
    XCTAssertNil(NoncolonizedName("接頭辞:名前"))
  }
  
  func test_QName() {
    let qName = QualifiedName("接頭辞:名前")
    XCTAssertEqual(qName?.prefix, "接頭辞")
    XCTAssertEqual(qName?.localName, "名前")
  }
  
  func test_attributeName() {
    XCTAssertEqual(AttributeName("xmlns"), .defaultNamespaceDeclaration)
    XCTAssertEqual(AttributeName("xmlns:mine"), .userDefinedNamespaceDeclaration("mine"))
    XCTAssertEqual(AttributeName("p:n"), .attributeName(QualifiedName("p:n")!))
  }
}


