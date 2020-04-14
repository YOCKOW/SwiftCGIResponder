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

extension CGIContentTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CGIContentTests = [
        ("test_defaultContentType", test_defaultContentType),
    ]
}

extension CGIResponderTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CGIResponderTests = [
        ("test_contentType", test_contentType),
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

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CGIContentOutputStreamTests.__allTests__CGIContentOutputStreamTests),
        testCase(CGIContentTests.__allTests__CGIContentTests),
        testCase(CGIResponderTests.__allTests__CGIResponderTests),
        testCase(ClientTests.__allTests__ClientTests),
        testCase(EnvironmentVariablesTests.__allTests__EnvironmentVariablesTests),
        testCase(ErrorMessageTests.__allTests__ErrorMessageTests),
    ]
}
#endif
