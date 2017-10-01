import XCTest
@testable import CGIResponder

class CGIResponderTests: XCTestCase {
  func testResponse() {
      XCTAssertEqual("", "")
  }
  
  static var allTests: [(String, (CGIResponderTests) -> () -> Void)] = [
    ("testResponse", testResponse),
  ]
}
