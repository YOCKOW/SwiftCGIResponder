/* *************************************************************************************************
 DocumentTests.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import XCTest
@testable import XHTML

private let simpleXHTML5_string =
  """
  <?xml version="1.0" encoding="UTF-8"?>
  <!-- Comment before DOCTYPE -->
  <?processing-instruction-before-doctype some-attribute='some-value'?>
  <!DOCTYPE html>
  <html xmlns="http://www.w3.org/1999/xhtml">
    <head>
      <title>XHTML5</title>
    </head>
    <body>
      <div>I am XHTML5.</div>
      <div id="ID&quot;&apos;&lt;&gt;" data-user-name="YOCKOW">ID</div>
    </body>
  </html>
  """
private let simpleXHTML5_data = simpleXHTML5_string.data(using:.utf8)!

private let xhtml5_string =
  """
  <?xml version="1.0" encoding="UTF-8"?>
  <?xml-stylesheet type="text/css" href="test.css"?>
  <xhtml:html xmlns:xhtml="http://www.w3.org/1999/xhtml">
    <xhtml:head>
      <xhtml:title xml:id="title">XHTML5</xhtml:title>
      <xhtml:script><![CDATA[ window.alert("XHTML5!") ]]></xhtml:script>
    </xhtml:head>
    <xhtml:body>
      <xhtml:div>I am also XHTML5.</xhtml:div>
    </xhtml:body>
  </xhtml:html>
  """
private let xhtml5_data = xhtml5_string.data(using:.utf8)!
private let xhtml5_utf32be_data = xhtml5_string.data(using:.utf32BigEndian)!

final class DocumentTests: XCTestCase {
  func test_detectXHTMLInfo() {
    let infoOfSimpleXHTML5 = simpleXHTML5_data.xhtmlInfo
    XCTAssertTrue(infoOfSimpleXHTML5 == (xmlVersion:"1.0", stringEncoding:.utf8, version:.v5),
                  "\(infoOfSimpleXHTML5)")
    
    
    let infoOfXHTML5 = xhtml5_data.xhtmlInfo
    XCTAssertTrue(infoOfXHTML5 == (xmlVersion:"1.0", stringEncoding:.utf8, version:nil),
                  "\(infoOfXHTML5)")
    
    XCTAssertTrue(infoOfXHTML5 == xhtml5_utf32be_data.xhtmlInfo)
  }
  
  func test_initialization() {
    let root = HTMLElement(name:"html")
    let document = Document(rootElement:root)
    XCTAssertEqual(
      document.xhtmlString,
      """
      <?xml version="1.0" encoding="utf-8"?>
      \(Version.v5._documentType!)
      \(root.xhtmlString)
      """)
  }
}

