import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(AnyHeaderFieldDelegateTests.allTests),
    testCase(ETagTests.allTests),
    testCase(HeaderFieldTests.allTests),
  ]
}
#endif

