import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(AnyHeaderFieldDelegateTests.allTests),
    testCase(ContentDispositionTests.allTests),
    testCase(ETagTests.allTests),
    testCase(HeaderFieldTests.allTests),
    testCase(LastModifiedHeaderFieldDelegateTests.allTests),
    testCase(MIMETypeTests.allTests),
  ]
}
#endif

