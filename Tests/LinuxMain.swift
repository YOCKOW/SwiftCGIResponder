import XCTest

import HTTPTests
import LibExtenderTests
import CGIResponderTests
import XHTMLTests

var tests = [XCTestCaseEntry]()
tests += HTTPTests.__allTests()
tests += LibExtenderTests.__allTests()
tests += CGIResponderTests.__allTests()
tests += XHTMLTests.__allTests()

XCTMain(tests)
