import XCTest

extension CFStringEncodingTests {
    static let __allTests = [
        ("test_constants", test_constants),
        ("test_initialization", test_initialization),
    ]
}

extension DataTests {
    static let __allTests = [
        ("test_quotedPrintable", test_quotedPrintable),
        ("test_relativeIndex", test_relativeIndex),
        ("test_view", test_view),
    ]
}

extension DictionaryKeyValueParserTests {
    static let __allTests = [
        ("test_parse", test_parse),
    ]
}

extension StringCFStringTests {
    static let __allTests = [
        ("test_conversion", test_conversion),
    ]
}

extension StringEncodingTests {
    static let __allTests = [
        ("test_IANACharSetName", test_IANACharSetName),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CFStringEncodingTests.__allTests),
        testCase(DataTests.__allTests),
        testCase(DictionaryKeyValueParserTests.__allTests),
        testCase(StringCFStringTests.__allTests),
        testCase(StringEncodingTests.__allTests),
    ]
}
#endif
