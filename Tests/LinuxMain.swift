import XCTest

import HTTPTests
import LibExtenderTests
import CGIResponderTests

var tests = [XCTestCaseEntry]()
tests += HTTPTests.__allTests()
tests += LibExtenderTests.__allTests()
tests += CGIResponderTests.__allTests()

XCTMain(tests)
