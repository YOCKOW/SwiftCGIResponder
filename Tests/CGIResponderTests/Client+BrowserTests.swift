/***************************************************************************************************
 Client+BrowserTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class Client_BrowserTests: XCTestCase {
  func testDetection() {
    let set:[(userAgent:String, expected:Client.Browser.Type)] = [
      ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_2) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.95 Safari/537.36",
       Client.Browser.Chrome.self),
      ("Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) CriOS/61.0.3163.73 Mobile/15A372 Safari/602.1",
       Client.Browser.Chrome.self),
      ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36 Edge/14.14393",
       Client.Browser.Edge.self),
      ("Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:50.0) Gecko/20100101 Firefox/50.0",
       Client.Browser.Firefox.self),
      ("Mozilla/5.0 (Windows NT 10.0; Win64; x64; Trident/7.0; rv:11.0) like Gecko",
       Client.Browser.InternetExplorer.self),
      ("Opera/9.80 (Windows NT 6.2; Win64; x64) Presto/2.12.388 Version/12.18",
       Client.Browser.Opera.self),
      ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36 OPR/42.0.2393.94",
       Client.Browser.Opera.self),
      ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_4) AppleWebKit/537.77.4 (KHTML, like Gecko) Version/7.0.5 Safari/537.77.4",
       Client.Browser.Safari.self),
      ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/604.4.7 (KHTML, like Gecko) Version/11.0.2 Safari/604.4.7",
       Client.Browser.Safari11.self),
      ("Mozilla/5.0 (iPhone; CPU iPhone OS 11_0 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Version/11.0 Mobile/15A372 Safari/604.1",
       Client.Browser.Safari11.self),
      ("YOCKOzilla/1.0",
       Client.Browser.Unknown.self),
    ]
    
    let client = Client.client
    let env = EnvironmentVariables.default
    for ii in 0..<set.count {
      env["HTTP_USER_AGENT"] = set[ii].0
      
      let browser = client.browser()
      XCTAssertTrue(type(of:browser) == set[ii].1, "\(ii + 1) of \(set.count)")
    }
  }
  
  static var allTests: [(String, (Client_BrowserTests) -> () -> Void)] = [
    ("testDetection", testDetection),
  ]
}




