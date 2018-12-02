/* *************************************************************************************************
 LastModifiedHeaderFieldDelegateTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import HTTP

import Foundation

final class LastModifiedHeaderFieldDelegateTests: XCTestCase {
  func test_initializer() {
    let date_string = "Mon, 03 Oct 1983 16:21:09 GMT"
    let date_field_value = HeaderFieldValue(rawValue:date_string)!
    let date = Date(headerFieldValue:date_field_value)!
    let lastModified = HeaderField(name:.lastModified, value:HeaderFieldValue(rawValue:date_string)!)
    
    XCTAssertEqual(lastModified.source as! Date, date)
  }
}






