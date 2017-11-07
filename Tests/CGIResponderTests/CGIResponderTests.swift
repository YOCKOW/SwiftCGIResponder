import XCTest
@testable import CGIResponder

class CGIResponderTests: XCTestCase {
  func testContentType() {
    var responder = CGIResponder()
    XCTAssertEqual(responder.contentType, MIMEType(type:.application, subtype:"octet-stream"))
    XCTAssertEqual(responder.stringEncoding, nil)
    
    responder.contentType = MIMEType(pathExtension:.txt, parameters:["charset":"UTF-8"])!
    XCTAssertEqual(responder.contentType.type, .text)
    XCTAssertEqual(responder.contentType.subtype, "plain")
    XCTAssertEqual(responder.stringEncoding, .utf8)
  }
  
  
  static var allTests: [(String, (CGIResponderTests) -> () -> Void)] = [
    ("testContentType", testContentType),
  ]
}
