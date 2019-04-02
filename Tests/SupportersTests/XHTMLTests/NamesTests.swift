/* *************************************************************************************************
 NamesTests.swift
   © 2018-2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import XCTest
@testable import XHTML

final class NamesTests: XCTestCase {
  func test_NCName() {
    // Changed calling initializer due to [SR-10259](https://bugs.swift.org/browse/SR-10259).
    XCTAssertNotNil(NoncolonizedName(rawValue:"名前"))
    XCTAssertNil(NoncolonizedName(rawValue:"接頭辞:名前"))
  }
  
  func test_QName() {
    let qName: QualifiedName = "接頭辞:名前"
    XCTAssertEqual(qName.prefix, "接頭辞")
    XCTAssertEqual(qName.localName, "名前")
  }
  
  func test_attributeName() {
    XCTAssertEqual(AttributeName("xmlns"), .defaultNamespace)
    XCTAssertEqual(AttributeName("xmlns:mine"), .userDefinedNamespace("mine"))
    XCTAssertEqual(AttributeName("p:n"), .attributeName("p:n"))
  }
}


