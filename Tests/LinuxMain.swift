import XCTest
@testable import CGIResponderTests

XCTMain([
    testCase(CGIResponderTests.allTests),
    testCase(HTTPHeaderFieldTests.allTests),
    testCase(HTTPHeaderFieldDelegateContentLengthTests.allTests),
])
