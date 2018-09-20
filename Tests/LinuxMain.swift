import XCTest

// main module
import CGIResponderTests

// supprters
import HTTPTests

var tests = [XCTestCaseEntry]()
tests += HTTPTests.allTests()

tests += CGIResponderTests.allTests()

XCTMain(tests)
