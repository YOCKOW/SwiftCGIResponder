import XCTest

extension AttributesTests {
    static let __allTests = [
        ("test_initialzation", test_initialzation),
    ]
}

extension DocumentTests {
    static let __allTests = [
        ("test_detectXHTMLInfo", test_detectXHTMLInfo),
        ("test_initialization", test_initialization),
    ]
}

extension NamesTests {
    static let __allTests = [
        ("test_attributeName", test_attributeName),
        ("test_NCName", test_NCName),
        ("test_QName", test_QName),
    ]
}

extension VersionTests {
    static let __allTests = [
        ("test_initialization", test_initialization),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AttributesTests.__allTests),
        testCase(DocumentTests.__allTests),
        testCase(NamesTests.__allTests),
        testCase(VersionTests.__allTests),
    ]
}
#endif
