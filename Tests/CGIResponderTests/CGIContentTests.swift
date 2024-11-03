/* *************************************************************************************************
 CGIContentTests.swift
   © 2019-2020,2023-2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

@testable import CGIResponder
import Foundation
import TemporaryFile
import XHTML

#if swift(>=6) && canImport(Testing)
import Testing

@Suite final class CGIContentTests {
  @Test func test_defaultContentType() throws {
    var content: CGIContent = .path("/my.image.png")
    #expect(content._defaultContentType == ContentType("image/png"))

    content = .string("CONTENT", encoding: .japaneseEUC)
    #expect(content._defaultContentType == ContentType("text/plain; charset=euc-jp"))

    content = .url(URL(fileURLWithPath: "/my.style.css"))
    #expect(content._defaultContentType == ContentType("text/css"))

    content = .xhtml(try XHTMLDocument(rootElement: .init(name: "html")))
    #expect(content._defaultContentType == ContentType("application/xhtml+xml; charset=utf-8"))

    content = .xhtml(try XHTMLDocument(rootElement: .init(name: "html")), asHTML: true)
    #expect(content._defaultContentType == ContentType("text/html; charset=utf-8"))
  }

  @Test func test_xhtml_html() throws {
    let xhtml = """
    <?xml version="1.0" encoding="UTF-8" ?>
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>YOCKOW</title>
      </head>
      <body>
        <div>Hi, I'm YOCKOW.</div>
      </body>
    </html>

    """
    let document = try XHTML.Parser.parse(Data(xhtml.utf8))

    XHTML: do {
      let content = CGIContent.xhtml(document, asHTML: false)
      var output = InMemoryFile()
      try output.write(content)
      try output.seek(toOffset: 0)

      let xhtmlExpected = try #require(output.readToEnd().flatMap({ String(data: $0, encoding: .utf8) }))
      #expect(
        xhtmlExpected ==
        #"<?xml version="1.0" encoding="utf-8"?>\#n<!DOCTYPE html>\#n<html xmlns="http://www.w3.org/1999/xhtml"><head><title>YOCKOW</title></head><body><div>Hi, I&apos;m YOCKOW.</div></body></html>"#
      )
    }

    HTML: do {
      let content = CGIContent.xhtml(document, asHTML: true)
      var output = InMemoryFile()
      try output.write(content)
      try output.seek(toOffset: 0)

      let xhtmlExpected = try #require(output.readToEnd().flatMap({ String(data: $0, encoding: .utf8) }))
      #expect(
        xhtmlExpected ==
        #"<!DOCTYPE html>\#n<html><head><title>YOCKOW</title></head><body><div>Hi, I&apos;m YOCKOW.</div></body></html>"#
      )
    }
  }
}
#else
import XCTest

final class CGIContentTests: XCTestCase {
  func test_defaultContentType() throws {
    var content: CGIContent = .path("/my.image.png")
    XCTAssertEqual(content._defaultContentType, ContentType("image/png"))
    
    content = .string("CONTENT", encoding: .japaneseEUC)
    XCTAssertEqual(content._defaultContentType, ContentType("text/plain; charset=euc-jp"))
    
    content = .url(URL(fileURLWithPath: "/my.style.css"))
    XCTAssertEqual(content._defaultContentType, ContentType("text/css"))
    
    content = .xhtml(try XHTMLDocument(rootElement: .init(name: "html")))
    XCTAssertEqual(content._defaultContentType, ContentType("application/xhtml+xml; charset=utf-8"))

    content = .xhtml(try XHTMLDocument(rootElement: .init(name: "html")), asHTML: true)
    XCTAssertEqual(content._defaultContentType, ContentType("text/html; charset=utf-8"))
  }

  func test_xhtml_html() throws {
    let xhtml = """
    <?xml version="1.0" encoding="UTF-8" ?>
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>YOCKOW</title>
      </head>
      <body>
        <div>Hi, I'm YOCKOW.</div>
      </body>
    </html>

    """
    let document = try XHTML.Parser.parse(Data(xhtml.utf8))

    XHTML: do {
      let content = CGIContent.xhtml(document, asHTML: false)
      var output = InMemoryFile()
      try output.write(content)
      try output.seek(toOffset: 0)

      let xhtmlExpected = try XCTUnwrap(output.readToEnd().flatMap({ String(data: $0, encoding: .utf8) }))
      XCTAssertEqual(
        xhtmlExpected,
        #"<?xml version="1.0" encoding="utf-8"?>\#n<!DOCTYPE html>\#n<html xmlns="http://www.w3.org/1999/xhtml"><head><title>YOCKOW</title></head><body><div>Hi, I&apos;m YOCKOW.</div></body></html>"#
      )
    }

    HTML: do {
      let content = CGIContent.xhtml(document, asHTML: true)
      var output = InMemoryFile()
      try output.write(content)
      try output.seek(toOffset: 0)

      let xhtmlExpected = try XCTUnwrap(output.readToEnd().flatMap({ String(data: $0, encoding: .utf8) }))
      XCTAssertEqual(
        xhtmlExpected,
        #"<!DOCTYPE html>\#n<html><head><title>YOCKOW</title></head><body><div>Hi, I&apos;m YOCKOW.</div></body></html>"#
      )
    }
  }
}
#endif
