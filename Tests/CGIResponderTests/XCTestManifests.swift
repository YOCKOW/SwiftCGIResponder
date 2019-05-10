#if !canImport(ObjectiveC)
import XCTest

extension CGIContentOutputStreamTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CGIContentOutputStreamTests = [
        ("test_pathForUnexistingFile", test_pathForUnexistingFile),
    ]
}

extension CGIResponderTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CGIResponderTests = [
        ("test_contentType", test_contentType),
        ("test_defaultContentType", test_defaultContentType),
        ("test_expectedStatus_Date", test_expectedStatus_Date),
        ("test_expectedStatus_ETag", test_expectedStatus_ETag),
        ("test_response", test_response),
    ]
}

extension ClientTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ClientTests = [
        ("test_cookies", test_cookies),
        ("test_formDataItems", test_formDataItems),
        ("test_queryItems", test_queryItems),
    ]
}

extension DataOutputStreamTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__DataOutputStreamTests = [
        ("test", test),
    ]
}

extension EnvironmentVariablesTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__EnvironmentVariablesTests = [
        ("test_accessor", test_accessor),
    ]
}

extension ErrorMessageTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ErrorMessageTests = [
        ("test_message", test_message),
    ]
}

extension ExportTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ExportTests = [
        ("test_HTTPETag", test_HTTPETag),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CGIContentOutputStreamTests.__allTests__CGIContentOutputStreamTests),
        testCase(CGIResponderTests.__allTests__CGIResponderTests),
        testCase(ClientTests.__allTests__ClientTests),
        testCase(DataOutputStreamTests.__allTests__DataOutputStreamTests),
        testCase(EnvironmentVariablesTests.__allTests__EnvironmentVariablesTests),
        testCase(ErrorMessageTests.__allTests__ErrorMessageTests),
        testCase(ExportTests.__allTests__ExportTests),
    ]
}
#endif
