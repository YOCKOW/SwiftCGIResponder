/***************************************************************************************************
 Dictionary+KeyValuePairsStringTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import XCTest
@testable import CGIResponder

class Dictionary_KeyValuePairsStringTests: XCTestCase {
  func testErrors() {
    do {
      let _ = try Dictionary<String,String>(keyValuePairs:"")
    } catch DictionaryParsingError.emptyString {
      XCTAssert(true, "Expected Error.")
    } catch {
      XCTAssert(false, "Unexpected Error.")
    }
    
    do {
      let _ = try Dictionary<String,String>(
        keyValuePairs:"A=B",
        allowedUnquotedCharacters:.alphanumerics,
        ignorableCharacters:.whitespacesAndNewlines,
        keyAndValueAreSeparatedBy:"",
        pairsAreSeparatedBy:";",
        allowMissingValues:true
      )
    } catch DictionaryParsingError.emptySeparatorBetweenKeyAndValue {
      XCTAssert(true, "Expected Error.")
    } catch {
      XCTAssert(false, "Unexpected Error.")
    }
    
    do {
      let _ = try Dictionary<String,String>(
        keyValuePairs:"A=B",
        allowedUnquotedCharacters:.alphanumerics,
        ignorableCharacters:.whitespacesAndNewlines,
        keyAndValueAreSeparatedBy:"=",
        pairsAreSeparatedBy:"",
        allowMissingValues:true
      )
    } catch DictionaryParsingError.emptySeparatorBetweenPairs {
      XCTAssert(true, "Expected Error.")
    } catch {
      XCTAssert(false, "Unexpected Error.")
    }
    
    do {
      let _ = try Dictionary<String,String>(
        keyValuePairs:"A=B",
        allowedUnquotedCharacters:BonaFideCharacterSet(charactersIn:"0123456789"),
        ignorableCharacters:.whitespacesAndNewlines,
        keyAndValueAreSeparatedBy:"=",
        pairsAreSeparatedBy:";",
        allowMissingValues:true
      )
    } catch DictionaryParsingError.invalidCharacter(let character, let index) {
      XCTAssertEqual(character, "A")
      XCTAssertEqual(index, "A=B".startIndex)
    } catch {
      XCTAssert(false, "Unexpected Error.")
    }
    
    do {
      let _ = try Dictionary<String,String>(
        keyValuePairs:"A",
        allowedUnquotedCharacters:.alphanumerics,
        ignorableCharacters:.whitespacesAndNewlines,
        keyAndValueAreSeparatedBy:"=",
        pairsAreSeparatedBy:";",
        allowMissingValues:false
      )
    } catch DictionaryParsingError.unexpectedEndOfString {
      XCTAssert(true, "Expected Error.")
    } catch {
      XCTAssert(false, "Unexpected Error.")
    }
  }
  
  func testInitialization() {
    do {
      let string1 = "A=B; C = D ; E; F"
      let dic1 = try Dictionary<String,String>(keyValuePairs:string1)
      XCTAssertEqual(dic1["A"], "B")
      XCTAssertEqual(dic1["C"], "D")
      XCTAssertEqual(dic1["E"], "")
      XCTAssertEqual(dic1["F"], "")
      
      let string2 = "\"あいうえお\" = \"かきく\\\"けこ\"; \"さしすせそ\"   ; たちつてと   ; \"なにぬねの\"  "
      let dic2 = try Dictionary<String,String>(keyValuePairs:string2)
      XCTAssertEqual(dic2["あいうえお"], "かきく\"けこ")
      XCTAssertEqual(dic2["さしすせそ"], "")
      XCTAssertEqual(dic2["たちつてと"], "")
      XCTAssertEqual(dic2["なにぬねの"], "")
    } catch DictionaryParsingError.invalidCharacter(let character, let index) {
      print("Unexpected error: invalid caharacter = \"\(character)\" at index \(index)")
      XCTAssert(false)
    } catch DictionaryParsingError.unexpectedEndOfString {
      print("Unexpected end of string.")
      XCTAssert(false)
    } catch {
      debugPrint("Unexpected Error")
      XCTAssert(false)
    }
  
  }
  
  static var allTests: [(String, (Dictionary_KeyValuePairsStringTests) -> () -> Void)] = [
    ("testErrors", testErrors),
    ("testInitialization", testInitialization),
  ]
}


