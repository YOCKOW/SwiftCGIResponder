/* *************************************************************************************************
 ETagTests.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import XCTest
@testable import HTTP

final class ETagTests: XCTestCase {
  func test_initialization() {
    XCTAssertNil(ETag("unquoted"))
    XCTAssertEqual(ETag("\"STRONG\""), .strong("STRONG"))
    XCTAssertEqual(ETag("W/\"WEAK\""), .weak("WEAK"))
    XCTAssertEqual(ETag("*"), .any)
  }
  
  func test_comparison() {
    let strong = ETag("\"ETag\"")!
    let weak = ETag("W/\"ETag\"")!
    
    XCTAssertTrue(strong =~ weak)
    XCTAssertFalse(strong == weak)
  }
  
  func test_list() {
    let trial = { (string:String, expectedError:ETagParseError) -> Void in
      do {
        _ = try Array<ETag>(string:string)
      } catch {
        guard case let parseError as ETagParseError = error else {
          XCTFail("Unexpected Error was thrown.")
          return
        }
        XCTAssertEqual(expectedError, parseError,
                       "Expected Error: \(expectedError); Actual Error: \(parseError)")
      }
    }
    
    trial(", \"A\"", .extraComma)
    trial("\"A\", , \"B\"", .extraComma)
    
    trial("?", .unexpectedCharacter)
    trial("W-\"A\"", .unexpectedCharacter)
    trial("W/'A'", .unexpectedCharacter)
    
    trial("\"", .unterminatedTag)
    trial("W/\"ABCDEFGHIJKLMN", .unterminatedTag)
    trial("W/\"ABCDEFGHIJKLMN\\\"", .unterminatedTag)
    
    do {
      let list = try Array<ETag>(string:"\"A\", \"B\", W/\"C\",  \"D\" ")
      XCTAssertEqual(list[0], .strong("A"))
      XCTAssertEqual(list[1], .strong("B"))
      XCTAssertEqual(list[2], .weak("C"))
      XCTAssertEqual(list[3], .strong("D"))
      
      XCTAssertTrue(list.contains(.strong("A")))
      XCTAssertTrue(list.contains(.weak("C")))
      XCTAssertTrue(list.contains(.strong("C"), weakComparison:true))
      XCTAssertTrue(list.contains(.weak("D"), weakComparison:true))
    } catch {
      XCTFail("Unexpected Error: \(error)")
    }
  }
  
  public func test_headerField() {
    let eTag1 = ETag("\"SomeETag\"")!
    let eTag2 = ETag("W/\"SomeWeakETag\"")!

    var eTagField = ETagHeaderFieldDelegate(eTag1)
    XCTAssertEqual(type(of:eTagField).name, .eTag)
    XCTAssertEqual(eTagField.value.rawValue, eTag1.description)

    eTagField.source = eTag2
    XCTAssertEqual(eTagField.value.rawValue, eTag2.description)

    XCTAssertEqual(type(of:eTagField).type, .single)

    var ifMatchField = IfMatchHeaderFieldDelegate([eTag1])
    ifMatchField.append(eTag2)
    XCTAssertEqual(type(of:ifMatchField).name, .ifMatch)
    XCTAssertEqual(ifMatchField.value.rawValue, "\(eTag1.description), \(eTag2.description)")
    XCTAssertEqual(type(of:ifMatchField).type, .appendable)

    var ifNoneMatchField = IfMatchHeaderFieldDelegate([eTag1])
    ifNoneMatchField.append(eTag2)
    XCTAssertEqual(type(of:ifNoneMatchField).name, .ifMatch)
    XCTAssertEqual(ifNoneMatchField.value.rawValue, "\(eTag1.description), \(eTag2.description)")
    XCTAssertEqual(type(of:ifNoneMatchField).type, .appendable)
  }
  
  
  static var allTests = [
    ("test_initialization", test_initialization),
    ("test_comparison", test_comparison),
    ("test_list", test_list),
    ("test_headerField", test_headerField),
  ]
}

