import XCTest

import CGIResponderTests
import XHTMLTests

var tests = [XCTestCaseEntry]()
tests += CGIResponderTests.__allTests()
tests += XHTMLTests.__allTests()

XCTMain(tests)
