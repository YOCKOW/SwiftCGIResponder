/* *************************************************************************************************
 VersionTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import XHTML

final class VersionTests: XCTestCase {
  func test_initialization() {
    XCTAssertEqual(
      Version(_documentType:"""
        <!DOCTYPE
            html
            PUBLIC
            "-//W3C//DTD XHTML 1.0 Strict//EN"
            "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"
        >
        """
      ),
      .v1_0(.strict)
    )
    
    XCTAssertEqual(
      Version(_documentType:"""
        <!DOCTYPE html PUBLIC
          "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
        """
      ),
      .v1_1
    )
    
    XCTAssertEqual(Version(_documentType:"<!DOCTYPE\n    html>"), .v5_2)
    
  }
}


