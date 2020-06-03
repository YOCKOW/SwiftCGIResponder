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
        ("test_fallback", test_fallback),
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
        ("test_queryString", test_queryString),
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

extension FileSystemSessionStorageTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__FileSystemSessionStorageTests = [
        ("test_expiration", test_expiration),
        ("test_iterator", test_iterator),
        ("test_manager", test_manager),
        ("test_store_remove", test_store_remove),
        ("test_URL", test_URL),
    ]
}

extension ServerTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ServerTests = [
        ("test_hostname", test_hostname),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(CGIContentOutputStreamTests.__allTests__CGIContentOutputStreamTests),
        testCase(CGIContentTests.__allTests__CGIContentTests),
        testCase(CGIResponderTests.__allTests__CGIResponderTests),
        testCase(ClientTests.__allTests__ClientTests),
        testCase(EnvironmentVariablesTests.__allTests__EnvironmentVariablesTests),
        testCase(FileSystemSessionStorageTests.__allTests__FileSystemSessionStorageTests),
        testCase(ServerTests.__allTests__ServerTests),
    ]
}
#endif
