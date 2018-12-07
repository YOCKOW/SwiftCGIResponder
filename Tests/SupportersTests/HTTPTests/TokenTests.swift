/* *************************************************************************************************
 TokenTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import HTTP

final class TokenTests: XCTestCase {
  func test_split() {
    let parameters_string = "A=B; C=\"D\""
    let parameters_tokens = parameters_string._tokens
    XCTAssertNotNil(parameters_tokens)
    XCTAssertEqual(parameters_tokens?.count, 7)
    
    XCTAssertTrue(parameters_tokens?[0] is _Token._RawString)
    XCTAssertEqual(parameters_tokens?[0]._string, "A")
    
    XCTAssertTrue(parameters_tokens?[1] is _Token._Separator)
    XCTAssertEqual(parameters_tokens?[1]._string, "=")
    
    XCTAssertTrue(parameters_tokens?[2] is _Token._RawString)
    XCTAssertEqual(parameters_tokens?[2]._string, "B")
    
    XCTAssertTrue(parameters_tokens?[3] is _Token._Separator)
    XCTAssertEqual(parameters_tokens?[3]._string, ";")
    
    XCTAssertTrue(parameters_tokens?[4] is _Token._RawString)
    XCTAssertEqual(parameters_tokens?[4]._string, "C")
    
    XCTAssertTrue(parameters_tokens?[5] is _Token._Separator)
    XCTAssertEqual(parameters_tokens?[5]._string, "=")
    
    XCTAssertTrue(parameters_tokens?[6] is _Token._QuotedString)
    XCTAssertEqual(parameters_tokens?[6]._string, "D")
    
    ////
    
    let invalid_string = "A=\"B" // not closed
    XCTAssertNil(invalid_string._tokens)
  }
  
  func test_dictionary() {
    let source_string = "; key0 = \"value0\" ;; key1 ; key2=value2 "
    let tokens = source_string._tokens!
    let dictionary = Dictionary<String,String>(_tokens:tokens)
    XCTAssertNotNil(dictionary)
    XCTAssertEqual(dictionary?["key0"], "value0")
    XCTAssertEqual(dictionary?["key1"], "")
    XCTAssertEqual(dictionary?["key2"], "value2")
  }
}
