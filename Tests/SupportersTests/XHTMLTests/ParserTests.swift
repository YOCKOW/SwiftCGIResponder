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
  
  func test_errors() {
    func _test(_ relativePath:String,
               _ expected:Parser.Error,
               file:StaticString = #file,
               line:UInt = #line)
    {
      do {
        let _ = try Parser.parse(TestResources.shared.data(for:"XHTML/InvalidXHTML/" + relativePath)!)
        XCTFail("No error was thrown.", file:file, line:line)
      } catch {
        guard case let parserError as Parser.Error = error else {
          XCTFail("Unexpected Error: \(error.localizedDescription)", file:file, line:line)
          return
        }
        XCTAssertEqual(parserError, expected, file:file, line:line)
      }
    }
    
    _test("RootElementIsNotHTML.xhtml", .rootElementIsNotHTML)
    // _test("DuplicatedRootElement.xhtml", .duplicatedRootElement)
    // _test("MisplacedCDATA.xhtml", .misplacedCDATA)
  }
}



