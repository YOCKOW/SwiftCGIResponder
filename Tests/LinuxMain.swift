import XCTest
@testable import CGIResponderTests

XCTMain([
  testCase(CGIResponderTests.allTests),
  testCase(CustomRangesTests.allTests),
  testCase(HTTPHeaderFieldTests.allTests),
  testCase(HTTPHeaderFieldDelegateCacheControlTests.allTests),
  testCase(HTTPHeaderFieldDelegateContentLengthTests.allTests),
  testCase(MultirangeTests.allTests),
  testCase(StringUnicodeScalarSetTests.allTests),
])
