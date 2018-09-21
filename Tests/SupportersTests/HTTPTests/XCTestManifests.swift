import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(ETagTests.allTests),
    testCase(HeaderFieldTests.allTests),
  ]
}
#endif

