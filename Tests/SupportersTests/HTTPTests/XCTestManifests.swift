import XCTest

extension AnyHeaderFieldDelegateTests {
    static let __allTests = [
        ("test_initializer", test_initializer),
    ]
}

extension CacheControlDirectiveTests {
    static let __allTests = [
        ("test_header", test_header),
        ("test_set", test_set),
    ]
}

extension ContentDispositionTests {
    static let __allTests = [
        ("test_parser", test_parser),
    ]
}

extension CookieTests {
    static let __allTests = [
        ("test_date", test_date),
    ]
}

extension ETagTests {
    static let __allTests = [
        ("test_comparison", test_comparison),
        ("test_headerField", test_headerField),
        ("test_initialization", test_initialization),
        ("test_list", test_list),
    ]
}

extension HeaderFieldTests {
    static let __allTests = [
        ("test_contentLengh", test_contentLengh),
        ("test_delegateSelection", test_delegateSelection),
        ("test_initialization", test_initialization),
        ("test_name_initialization", test_name_initialization),
        ("test_value_initialization", test_value_initialization),
    ]
}

extension HeaderTests {
    static let __allTests = [
        ("test_appending", test_appending),
    ]
}

extension LastModifiedHeaderFieldDelegateTests {
    static let __allTests = [
        ("test_initializer", test_initializer),
    ]
}

extension MIMETypeTests {
    static let __allTests = [
        ("test_parser", test_parser),
        ("test_pathExtensions", test_pathExtensions),
    ]
}

extension QuotedStringTests {
    static let __allTests = [
        ("test_quote", test_quote),
        ("test_unquote", test_unquote),
    ]
}

extension TokenTests {
    static let __allTests = [
        ("test_dictionary", test_dictionary),
        ("test_split", test_split),
    ]
}

#if !os(macOS)
public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AnyHeaderFieldDelegateTests.__allTests),
        testCase(CacheControlDirectiveTests.__allTests),
        testCase(ContentDispositionTests.__allTests),
        testCase(CookieTests.__allTests),
        testCase(ETagTests.__allTests),
        testCase(HeaderFieldTests.__allTests),
        testCase(HeaderTests.__allTests),
        testCase(LastModifiedHeaderFieldDelegateTests.__allTests),
        testCase(MIMETypeTests.__allTests),
        testCase(QuotedStringTests.__allTests),
        testCase(TokenTests.__allTests),
    ]
}
#endif
