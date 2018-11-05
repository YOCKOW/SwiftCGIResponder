import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(CFStringEncodingTests.allTests),
    testCase(DictionaryKeyValueParserTests.allTests),
    testCase(StringCFStringTests.allTests),
    testCase(StringEncodingTests.allTests),
  ]
}
#endif

