/***************************************************************************************************
 StringEncodings+IANACharacterSetNameTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import XCTest
@testable import CGIResponder

class StringEncodings_IANACharacterSetNameTests: XCTestCase {
  func testEncodings() {
    enum Convertibility {
      case bidirectional, encodingToName, nameToEncoding, none
    }
    
    let encodings: [(String.Encoding, String, Convertibility)] = [
      (.ascii, "US-ASCII", .bidirectional),
      (.iso2022JP, "ISO-2022-JP", .bidirectional),
      (.isoLatin1, "ISO-8859-1", .bidirectional),
      (.isoLatin2, "ISO-8859-2", .bidirectional),
      (.japaneseEUC, "EUC-JP", .bidirectional),
      (.macOSRoman, "Macintosh", .bidirectional),
      (.nextstep, "X-NeXTSTEP", .bidirectional),
      (.nonLossyASCII, "?", .none),
      (.shiftJIS, "CP932", .bidirectional),
      (.symbol, "X-Mac-Symbol", .bidirectional),
      (.unicode, "UTF-16", .bidirectional),
      (.utf16, "UTF-16", .bidirectional), // .utf16 == .unicode
      (.utf16BigEndian, "UTF-16BE", .bidirectional),
      (.utf16LittleEndian, "UTF-16LE", .bidirectional),
      (.utf32, "UTF-32", .bidirectional),
      (.utf32BigEndian, "UTF-32BE", .bidirectional),
      (.utf32LittleEndian, "UTF-32LE", .bidirectional),
      (.utf8, "UTF-8", .bidirectional),
      (.windowsCP1250, "Windows-1250", .bidirectional),
      (.windowsCP1251, "Windows-1251", .bidirectional),
      (.windowsCP1252, "Windows-1252", .bidirectional),
      (.windowsCP1253, "Windows-1253", .bidirectional),
      (.windowsCP1254, "Windows-1254", .bidirectional),
      
      // Others...
      (String.Encoding(CFString.Encoding.shiftJIS), "Shift_JIS", .bidirectional),
    ]
    
    for info in encodings {
      if info.2 == .bidirectional || info.2 == .encodingToName {
        let name = info.0.ianaCharacterSetName
        XCTAssertNotNil(name)
        XCTAssertEqual(name?.lowercased(), info.1.lowercased())
      }
      if info.2 == .bidirectional || info.2 == .nameToEncoding {
        let encoding = String.Encoding(ianaCharacterSetName:info.1)
        XCTAssertNotNil(encoding)
        XCTAssertEqual(encoding, info.0)
      }
    }
  }
  
  static var allTests: [(String, (StringEncodings_IANACharacterSetNameTests) -> () -> Void)] = [
    ("testEncodings", testEncodings),
  ]
}


