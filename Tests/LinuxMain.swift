import XCTest

import HTTPTests
import XHTMLTests
import LibExtenderTests
import CGIResponderTests

var tests = [XCTestCaseEntry]()
tests += HTTPTests.__allTests()
tests += XHTMLTests.__allTests()
tests += LibExtenderTests.__allTests()
tests += CGIResponderTests.__allTests()

XCTMain(tests)
