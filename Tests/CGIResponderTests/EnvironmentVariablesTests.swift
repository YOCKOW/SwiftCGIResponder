/* *************************************************************************************************
 EnvironmentVariablesTests.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import CGIResponder

func executeUnderTemporaryEnvironment(_ environments:[String:String?],
                                      _ body:() throws -> Void) rethrows
{
  let env = EnvironmentVariables.default
  var originalValues: [String:String?] = [:]
  for key in environments.keys {
    originalValues[key] = env[key]
  }
  defer {
    for (key, value) in originalValues { env[key] = value }
  }
  
  for (key, value) in environments {
    env[key] = value
  }
  
  try body()
}

class EnvironmentVariablesTests: XCTestCase {
  func test_accessor() {
    let env = EnvironmentVariables.default
    env["CGI_RESPONDER_TESTS"] = "YES"
    XCTAssertEqual(env["CGI_RESPONDER_TESTS"], "YES")
    
    env["CGI_RESPONDER_TESTS"] = nil
    XCTAssertEqual(env["CGI_RESPONDER_TESTS"], nil)
  }
  
  static var allTests:[(String, (EnvironmentVariablesTests) -> () -> Void)] = [
    ("test_accessor", test_accessor),
  ]
}



