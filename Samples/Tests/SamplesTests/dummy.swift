// This is a dummy file.
// 
// No tests are available with executables,
// because of [SR-1503](https://bugs.swift.org/browse/SR-1503).

#if swift(>=6) && canImport(Testing)
import Testing

@Test func test_doSomething() {
  #expect(Bool(true))
}
#else
import XCTest

final class DummyTest: XCTestCase {
  func test_something() {
    XCTAssertTrue(true)
  }
}
#endif
