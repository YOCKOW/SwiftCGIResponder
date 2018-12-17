import XCTest

extension DocumentTests {
    static let __allTests = [
        ("test_initialization", test_initialization),
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
        testCase(DocumentTests.__allTests),
        testCase(VersionTests.__allTests),
    ]
}
#endif
