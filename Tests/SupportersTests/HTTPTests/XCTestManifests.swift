import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(AnyHeaderFieldDelegateTests.allTests),
    testCase(CacheControlDirectiveTests.allTests),
    testCase(ContentDispositionTests.allTests),
    testCase(ETagTests.allTests),
    testCase(HeaderFieldTests.allTests),
    testCase(HeaderTests.allTests),
    testCase(LastModifiedHeaderFieldDelegateTests.allTests),
    testCase(MIMETypeTests.allTests),
  ]
}
#endif

