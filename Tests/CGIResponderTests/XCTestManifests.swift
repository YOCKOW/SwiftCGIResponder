import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(ExportTests.allTests),
    testCase(CGIContentOutputStreamTests.allTests),
    testCase(CGIResponderTests.allTests),
    testCase(DataOutputStreamTests.allTests),
    testCase(EnvironmentVariablesTests.allTests),
    testCase(ErrorMessageTests.allTests),
  ]
}
#endif

