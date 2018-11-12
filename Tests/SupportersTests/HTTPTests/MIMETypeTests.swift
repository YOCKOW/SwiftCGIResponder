/* *************************************************************************************************
 MIMETypeTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import HTTP

final class MIMETypeTests: XCTestCase {
  func test_parser() {
    let xhtml_type_utf8_string = "application/xhtml+xml; charset=UTF-8; myparameter=myvalue"
    let xhtml_type = MIMEType(xhtml_type_utf8_string)
    
    XCTAssertNotNil(xhtml_type)
    XCTAssertEqual(xhtml_type?.type, .application)
    XCTAssertEqual(xhtml_type?.tree, nil)
    XCTAssertEqual(xhtml_type?.subtype, "xhtml")
    XCTAssertEqual(xhtml_type?.suffix, .xml)
    XCTAssertEqual(xhtml_type?.parameters?["charset"], "UTF-8")
    XCTAssertEqual(xhtml_type?.parameters?["myparameter"], "myvalue")
  }
  
  func test_pathExtensions() {
    let txt_ext: MIMEType.PathExtension = .txt
    let text_mime_type = MIMEType(pathExtension:txt_ext)
    
    XCTAssertEqual(text_mime_type, MIMEType(type:.text, subtype:"plain"))
    XCTAssertEqual(text_mime_type?.possiblePathExtensions?.contains(txt_ext), true)
  }
  
  
  static var allTests = [
    ("test_parser", test_parser)
  ]
}





