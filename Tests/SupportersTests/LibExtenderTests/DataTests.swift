/* *************************************************************************************************
 DataTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

import XCTest
@testable import LibExtender

let data = Data(bytes:[
  0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07,
  0x08,0x09,0x0A,0x0B,0x0C,0x0D,0x0E,0x0F,
])
let subdata = data[0x04..<0x0C]


final class DataTests: XCTestCase {
  func test_quotedPrintable() {
    // https://tools.ietf.org/html/rfc3492#section-7
    let sampleStrings: [String] = [
      // https://en.wikipedia.org/wiki/Quoted-printable
      "J'interdis aux marchands de vanter trop leur marchandises. Car ils se font vite pédagogues et t'enseignent comme but ce qui n'est par essence qu'un moyen, et te trompant ainsi sur la route à suivre les voilà bientôt qui te dégradent, car si leur musique est vulgaire ils te fabriquent pour te la vendre une âme vulgaire.",
      "J'interdis aux marchands de vanter trop leur marchandises. Car ils se font =\r\nvite p=C3=A9dagogues et t'enseignent comme but ce qui n'est par essence qu'=\r\nun moyen, et te trompant ainsi sur la route =C3=A0 suivre les voil=C3=A0 bi=\r\nent=C3=B4t qui te d=C3=A9gradent, car si leur musique est vulgaire ils te f=\r\nabriquent pour te la vendre une =C3=A2me vulgaire.",
      
      // more and more samples are required...
    ]
    
    for ii in 0..<(sampleStrings.count / 2) {
      let raw = sampleStrings[ii * 2]
      let encoded = sampleStrings[ii * 2 + 1]
      
      let result_encode = raw.data(using:.utf8)?.quotedPrintableEncodedString()
      let result_decode = Data(quotedPrintableEncoded:encoded)
      XCTAssertNotNil(result_encode)
      XCTAssertNotNil(result_decode)
      XCTAssertEqual(result_encode, encoded)
      XCTAssertEqual(result_decode, raw.data(using:.utf8))
    }
  }
  
  
  
  func test_relativeIndex() {
    XCTAssertEqual(subdata[subdata.startIndex], subdata[Data.RelativeIndex(distance:0)!])
    XCTAssertEqual(subdata, subdata[Data.RelativeIndex(distance:0)!..<Data.RelativeIndex(distance:8)!])
  }
  
  func test_view() {
    let uint8View = data.uint8View
    XCTAssertEqual(uint8View[uint8View.index(after:uint8View.startIndex)], 0x01)
    
    guard let uint16BEView = data.uint16BigEndianView else { XCTFail("Must not be nil."); return }
    XCTAssertEqual(uint16BEView[uint16BEView.index(uint16BEView.startIndex, offsetBy:3)],
                   0x0607)
    
    guard let uint16LEView = data.uint16LittleEndianView else { XCTFail("Must not be nil."); return }
    XCTAssertEqual(uint16LEView[uint16LEView.index(uint16LEView.startIndex, offsetBy:7)],
                   0x0F0E)
    
    guard let uint32BEView = data.uint32BigEndianView else { XCTFail("Must not be nil."); return }
    XCTAssertEqual(uint32BEView[uint32BEView.index(uint32BEView.startIndex, offsetBy:1)],
                   0x04050607)
    
    guard let uint32LEView = data.uint32LittleEndianView else { XCTFail("Must not be nil."); return }
    XCTAssertEqual(uint32LEView[uint32LEView.index(uint32LEView.startIndex, offsetBy:2)],
                   0x0B0A0908)
    
    guard let subUInt16LEView = subdata.uint16LittleEndianView else { XCTFail("Must not be nil."); return }
    XCTAssertEqual(subUInt16LEView[subUInt16LEView.startIndex], 0x0504)
  }
}





