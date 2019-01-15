import XCTest

extension AttributesTests {
    static let __allTests = [
        ("test_initialzation", test_initialzation),
        ("test_namespace", test_namespace),
    ]
}

extension CommentTests {
    static let __allTests = [
        ("test_comment", test_comment),
    ]
}

extension DocumentTests {
    static let __allTests = [
        ("test_detectXHTMLInfo", test_detectXHTMLInfo),
        ("test_initialization", test_initialization),
    ]
}

extension ElementTests {
    static let __allTests = [
        ("test_classSelector", test_classSelector),
        ("test_xhtmlString", test_xhtmlString),
    ]
}

extension NamesTests {
    static let __allTests = [
        ("test_attributeName", test_attributeName),
        ("test_NCName", test_NCName),
        ("test_QName", test_QName),
    ]
}

extension ProcessingInstructionTests {
    static let __allTests = [
        ("test_XMLStyleSheet", test_XMLStyleSheet),
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
        testCase(CommentTests.__allTests),
        testCase(DocumentTests.__allTests),
        testCase(ElementTests.__allTests),
        testCase(NamesTests.__allTests),
        testCase(ProcessingInstructionTests.__allTests),
        testCase(VersionTests.__allTests),
    ]
}
#endif
