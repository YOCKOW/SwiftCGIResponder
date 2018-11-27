import XCTest

extension CGIContentOutputStreamTests {
    static let __allTests = [
        ("test_pathForUnexistingFile", test_pathForUnexistingFile),
    ]
}

extension CGIResponderTests {
    static let __allTests = [
        ("test_contentType", test_contentType),
        ("test_expectedStatus_Date", test_expectedStatus_Date),
        ("test_expectedStatus_ETag", test_expectedStatus_ETag),
        ("test_response", test_response),
    ]
}

extension DataOutputStreamTests {
    static let __allTests = [
        ("test", test),
    ]
}

extension EnvironmentVariablesTests {
    static let __allTests = [
        ("test_accessor", test_accessor),
    ]
}

extension ErrorMessageTests {
    static let __allTests = [
        ("test_message", test_message),
    ]
}

extension ExportTests {
    static let __allTests = [
        ("test_HTTPETag", test_HTTPETag),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CGIContentOutputStreamTests.__allTests),
        testCase(CGIResponderTests.__allTests),
        testCase(DataOutputStreamTests.__allTests),
        testCase(EnvironmentVariablesTests.__allTests),
        testCase(ErrorMessageTests.__allTests),
        testCase(ExportTests.__allTests),
    ]
}
#endif
