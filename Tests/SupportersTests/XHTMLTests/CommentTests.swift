/* *************************************************************************************************
 CommentTests.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import XHTML

final class CommentTests: XCTestCase {
  func test_comment() {
    let comment = Comment("Comment")
    XCTAssertEqual(comment?.xhtmlString, "<!--Comment-->")
    XCTAssertNil(Comment("A -- B"))
    XCTAssertNil(Comment("A+B-"))
  }
}



