import XCTest

extension XHTMLTests {
    static let __allTests = [
        ("test", test),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(XHTMLTests.__allTests),
    ]
}
#endif
