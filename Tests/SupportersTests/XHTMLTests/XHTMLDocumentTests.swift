/* *************************************************************************************************
 XHTMLDocumentTests.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import XCTest
@testable import XHTML

final class XHTMLDocumentTests: XCTestCase {
  func test_initialization() {
    let simpleXHTML5_string = """
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE html>
      <html xmlns="http://www.w3.org/1999/xhtml">
        <head><title>XHTML5</title></head>
        <body><div>I am XHTML5.</div><div id="ID&quot;&apos;" data-user-name="YOCKOW">ID</div></body>
      </html>
      """
    
    let xhtml5_string = """
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
    
    let simpleXHTML5 = XHTMLDocument(xmlString:simpleXHTML5_string)
    let xhtml5 = XHTMLDocument(xmlString:xhtml5_string)
    
    XCTAssertNotNil(simpleXHTML5)
    XCTAssertNotNil(xhtml5)
  }
}

