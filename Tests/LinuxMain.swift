import XCTest
@testable import CGIResponderTests

XCTMain([
  testCase(BonaFideCharacterSetTests.allTests),
  testCase(CGIResponderTests.allTests),
  testCase(CGIContentOutputStreamTests.allTests),
  testCase(CustomRangesTests.allTests),
  testCase(DateFormattersTests.allTests),
  testCase(Dictionary_KeyValuePairsStringTests.allTests),
  testCase(EnvironmentVariablesTests.allTests),
  testCase(HTTPCookieItemTests.allTests),
  testCase(HTTPETagTests.allTests),
  testCase(HTTPHeaderFieldTests.allTests),
  testCase(HTTPHeaderFieldDelegateCacheControlTests.allTests),
  testCase(HTTPHeaderFieldDelegateContentLengthTests.allTests),
  testCase(HTTPHeaderFieldDelegateContentTypeTests.allTests),
  testCase(HTTPHeaderFieldDelegateETagTests.allTests),
  testCase(HTTPHeaderFieldDelegateLastModifiedTests.allTests),
  testCase(MultirangeTests.allTests),
  testCase(MIMETypeTests.allTests),
  testCase(String_BonaFideCharacterSetTests.allTests),
  testCase(String_PartialMatchTests.allTests),
  testCase(String_UnicodeScalarSetTests.allTests),
  testCase(StringEncodings_IANACharacterSetNameTests.allTests),
])
