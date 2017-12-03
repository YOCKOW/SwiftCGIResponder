/***************************************************************************************************
 Data+QuotedPrintableTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class Data_QuotedPrintableTests: XCTestCase {
  // https://tools.ietf.org/html/rfc3492#section-7
  let sampleStrings: [String] = [
    // https://en.wikipedia.org/wiki/Quoted-printable
    "J'interdis aux marchands de vanter trop leur marchandises. Car ils se font vite pédagogues et t'enseignent comme but ce qui n'est par essence qu'un moyen, et te trompant ainsi sur la route à suivre les voilà bientôt qui te dégradent, car si leur musique est vulgaire ils te fabriquent pour te la vendre une âme vulgaire.",
    "J'interdis aux marchands de vanter trop leur marchandises. Car ils se font =\r\nvite p=C3=A9dagogues et t'enseignent comme but ce qui n'est par essence qu'=\r\nun moyen, et te trompant ainsi sur la route =C3=A0 suivre les voil=C3=A0 bi=\r\nent=C3=B4t qui te d=C3=A9gradent, car si leur musique est vulgaire ils te f=\r\nabriquent pour te la vendre une =C3=A2me vulgaire.",
    
    // more and more samples are required...
  ]
  
  func testEncode() {
    for ii in 0..<(sampleStrings.count / 2) {
      let target = sampleStrings[ii * 2]
      let result = sampleStrings[ii * 2 + 1]
      
      let encoded = target.data(using:.utf8)?.quotedPrintableEncodedString()
      XCTAssertNotNil(encoded, "Encode.")
      XCTAssertEqual(encoded!, result, "Encoded.")
    }
  }
  
  func testDecode() {
    for ii in 0..<(sampleStrings.count / 2) {
      let target = sampleStrings[ii * 2 + 1]
      let result = sampleStrings[ii * 2]
      
      let decoded = Data(quotedPrintableEncoded:target)
      XCTAssertNotNil(decoded, "Decode.")
      XCTAssertEqual(decoded!, result.data(using:.utf8)!, "Decoded.")
    }
  }
  
  static var allTests:[(String, (Data_QuotedPrintableTests) -> () -> Void)] = [
    ("testEncode", testEncode),
    ("testDecode", testDecode),
  ]
}



