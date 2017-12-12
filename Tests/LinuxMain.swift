import XCTest
@testable import CGIResponderTests

XCTMain([
  testCase(AnyIterator_FormDataItemTests.allTests),
  testCase(Array_URLQueryItemTests.allTests),
  testCase(BonaFideCharacterSetTests.allTests),
  testCase(BootstringTests.allTests),
  testCase(CGIResponderTests.allTests),
  testCase(CGIContentOutputStreamTests.allTests),
  testCase(CIPv4AddressTests.allTests),
  testCase(CIPv6AddressTests.allTests),
  testCase(Client_BrowserTests.allTests),
  testCase(ContentDispositionRepresentationTests.allTests),
  testCase(CustomRangesTests.allTests),
  testCase(Data_QuotedPrintableTests.allTests),
  testCase(DateFormattersTests.allTests),
  testCase(Dictionary_KeyValuePairsStringTests.allTests),
  testCase(EnvironmentVariablesTests.allTests),
  testCase(HostnameTests.allTests),
  testCase(HTTPCookieItemTests.allTests),
  testCase(HTTPETagTests.allTests),
  testCase(HTTPHeaderFieldTests.allTests),
  testCase(HTTPHeaderFieldDelegateCacheControlTests.allTests),
  testCase(HTTPHeaderFieldDelegateContentDispositionTests.allTests),
  testCase(HTTPHeaderFieldDelegateContentLengthTests.allTests),
  testCase(HTTPHeaderFieldDelegateContentTransferEncodingTests.allTests),
  testCase(HTTPHeaderFieldDelegateContentTypeTests.allTests),
  testCase(HTTPHeaderFieldDelegateETagTests.allTests),
  testCase(HTTPHeaderFieldDelegateLastModifiedTests.allTests),
  testCase(HTTPHeaderFieldDelegateSetCookieTests.allTests),
  testCase(IPAddressTests.allTests),
  testCase(MultirangeTests.allTests),
  testCase(MIMETypeTests.allTests),
  testCase(RFC6265Cookie_HTTPHeaderFieldValueTests.allTests),
  testCase(String_BonaFideCharacterSetTests.allTests),
  testCase(String_PartialMatchTests.allTests),
  testCase(String_UnicodeScalarSetTests.allTests),
  testCase(StringEncodings_IANACharacterSetNameTests.allTests),
  testCase(TemporaryDirectoryTests.allTests),
  testCase(TemporaryFileTests.allTests),
  testCase(URL_IDNATests.allTests),
  testCase(URLHostTests.allTests),
])
