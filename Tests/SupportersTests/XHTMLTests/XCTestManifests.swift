import XCTest

extension XHTMLDocumentTests {
    static let __allTests = [
        ("test_initialization", test_initialization),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(XHTMLDocumentTests.__allTests),
    ]
}
#endif
