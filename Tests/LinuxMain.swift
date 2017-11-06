import XCTest
@testable import CGIResponderTests

XCTMain([
  testCase(BonaFideCharacterSetTests.allTests),
  testCase(CGIResponderTests.allTests),
  testCase(CustomRangesTests.allTests),
  testCase(Dictionary_KeyValuePairsStringTests.allTests),
  testCase(HTTPHeaderFieldTests.allTests),
  testCase(HTTPHeaderFieldDelegateCacheControlTests.allTests),
  testCase(HTTPHeaderFieldDelegateContentLengthTests.allTests),
  testCase(HTTPHeaderFieldDelegateContentTypeTests.allTests),
  testCase(MultirangeTests.allTests),
  testCase(MIMETypeTests.allTests),
  testCase(String_PartialMatchTests.allTests),
  testCase(String_UnicodeScalarSetTests.allTests),
  testCase(StringEncodings_IANACharacterSetNameTests.allTests),
])
