/* *************************************************************************************************
 CGIContentTests.swift
   © 2019-2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import CGIResponder

final class CGIContentTests: XCTestCase {
  func test_defaultContentType() {
    var content: CGIContent = .path("/my.image.png")
    XCTAssertEqual(content._defaultContentType, ContentType("image/png"))
    
    content = .string("CONTENT", encoding: .japaneseEUC)
    XCTAssertEqual(content._defaultContentType, ContentType("text/plain; charset=euc-jp"))
    
    content = .url(URL(fileURLWithPath: "/my.style.css"))
    XCTAssertEqual(content._defaultContentType, ContentType("text/css"))
    
    content = .xhtml(XHTMLDocument(rootElement: .init(name: "html")))
    XCTAssertEqual(content._defaultContentType, ContentType("application/xhtml+xml; charset=utf-8"))
  }
}
