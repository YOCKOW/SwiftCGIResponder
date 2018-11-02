import XCTest

// main module
import CGIResponderTests

// supprters
import HTTPTests
import LibExtenderTests

var tests = [XCTestCaseEntry]()
tests += HTTPTests.allTests()
tests += LibExtender.allTests()

tests += CGIResponderTests.allTests()

XCTMain(tests)
