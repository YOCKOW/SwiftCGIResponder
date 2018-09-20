import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(ExportTests.allTests),
    testCase(CGIResponderTests.allTests),
  ]
}
#endif

