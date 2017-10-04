import XCTest
@testable import CGIResponderTests

XCTMain([
  testCase(CGIResponderTests.allTests),
  testCase(HTTPHeaderFieldTests.allTests),
  testCase(HTTPHeaderFieldDelegateCacheControlTests.allTests),
  testCase(HTTPHeaderFieldDelegateContentLengthTests.allTests),
  testCase(StringUnicodeScalarSetTests.allTests),
])
