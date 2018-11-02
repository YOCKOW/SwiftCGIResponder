import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(CFStringEncodingTests.allTests),
    testCase(StringCFStringTests.allTests),
  ]
}
#endif

