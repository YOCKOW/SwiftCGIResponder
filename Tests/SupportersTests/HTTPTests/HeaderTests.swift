/* *************************************************************************************************
 HeaderTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import HTTP

final class HeaderTests: XCTestCase {
  func test_appending() {
    var header = Header([])
    
    let strongETag: ETag = .strong("STRONG")
    let weakETag: ETag = .weak("WEAK")
    let strongETag2: ETag = .strong("STRONG2")
    
    header.insert(.ifNoneMatch(.list([strongETag])))
    XCTAssertEqual(header.count, 1)
    
    header.insert(.ifNoneMatch(.list([weakETag])))
    XCTAssertEqual(header.count, 1) // "if-none-match" is not duplicable, but appendable
    
    XCTAssertEqual(header[.ifNoneMatch][0].source as! ETagList, ETagList.list([strongETag, weakETag]))
    
    header.insert(.ifNoneMatch(.list([strongETag2])), removingExistingFields:true)
    XCTAssertEqual(header.count, 1)
    XCTAssertEqual(header[.ifNoneMatch][0].source as! ETagList, ETagList.list([strongETag2]))
    
    header.removeFields(forName:.ifNoneMatch)
    XCTAssertEqual(header.count, 0)
  }
  
  static var allTests = [
    ("test_appending", test_appending),
  ]
}
