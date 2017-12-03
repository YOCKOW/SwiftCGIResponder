/***************************************************************************************************
 Data+QuotedPrintable.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

extension UInt8 {
  fileprivate var isValidHexadecimalDigit: Bool {
    if CountableClosedRange<UInt8>(0x30...0x39).contains(self) { return true } // [0-9]
    if CountableClosedRange<UInt8>(0x41...0x46).contains(self) { return true } // [A-F]
    if CountableClosedRange<UInt8>(0x61...0x66).contains(self) { return true } // [a-f]
    return false
  }
  fileprivate var hexadecimalDigitValue: UInt8 {
    var value = self
    value -= 0x30 // [0-9]
    if value > 9 { value -= 7 } // [A-F]
    if value > 15 { value -= 32 } // [a-f]
    return value // always 0..<16
  }
}

extension Data {
  /// Options to be used when decoding quoted-printable data.
  public struct QuotedPrintableDecodingOptions: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) { self.rawValue = rawValue }
    public static let `default`: QuotedPrintableDecodingOptions = []
  }
  
  /// Decoding data that is encoded with quoted-printable
  public init?(quotedPrintableEncoded qpData:Data, options:QuotedPrintableDecodingOptions = .default) {
    self.init(capacity:qpData.count)
    
    let equalitySign: UInt8 = 0x3D
    let CR: UInt8 = 0x0D
    let LF: UInt8 = 0x0A
    
    var ii: Int = 0
    while true {
      if ii >= qpData.count { break }
      defer { ii += 1 }
      
      let byte = qpData[ii]
      if byte != equalitySign {
        self.append(byte)
      } else { // byte == '='
        guard ii < qpData.count - 1 else { return nil }
        if ii == qpData.count - 2 {
          if qpData[ii + 1] == CR || qpData[ii + 1] == LF {
            // soft line breaks are allowed
            break
          } else {
            return nil
          }
        } else { // ii < qpData.count - 2
          let next = qpData[ii + 1]
          let nextOfNext = qpData[ii + 2]
          switch (next, nextOfNext) {
          case (CR, LF):
            ii += 2
          case (LF, _):
            ii += 1
          case (CR, _):
            ii += 1
          case (let digit1, let digit2) where digit1.isValidHexadecimalDigit && digit2.isValidHexadecimalDigit:
            let u8: UInt8 = digit1.hexadecimalDigitValue * 16 + digit2.hexadecimalDigitValue
            self.append(u8)
            ii += 2
          default:
            // invalid sequence
            return nil
          }
        }
      }
    }
  }
  
  /// Decoding string that is encoded with quoted-printable
  public init?(quotedPrintableEncoded qpString:String, options:QuotedPrintableDecodingOptions = .default) {
    guard let encodedData = qpString.data(using:.utf8) else { return nil }
    self.init(quotedPrintableEncoded:encodedData)
  }
}

extension Data {
  /// Options to be used when encoding quoted-printable data.
  public struct QuotedPrintableEncodingOptions: OptionSet {
    public let rawValue: Int
    public init(rawValue: Int) { self.rawValue = rawValue }
    public static let regardAsBinary = QuotedPrintableEncodingOptions(rawValue:(1 << 0))
    public static let `default`: QuotedPrintableEncodingOptions = []
  }
  
  /// Encoding data with quoted-printable
  public func quotedPrintableEncodedData(options: QuotedPrintableEncodingOptions = .default) -> Data {
    var result = Data(capacity:self.count * 3)
    
    let space: UInt8 = 0x20
    let TAB: UInt8 = 0x09
    let CR: UInt8 = 0x0D
    let LF: UInt8 = 0x0A
    let equalitySign: UInt8 = 0x3D
    
    let raw:(UInt8) -> Bool = { $0 > 0x20 && $0 < 0x7F && $0 != equalitySign }
    let encode:(UInt8) -> Data = { String(format:"=%02X", $0).data(using:.utf8)! }
    
    var numberOfCharactersInLine: Int = 0
    var ii: Int = 0
    while true {
      if ii >= self.count { break }
      defer { ii += 1 }
      
      let byte = self[ii]
      let next: UInt8? = (ii < self.count - 1) ? self[ii + 1] : nil
      
      var requireEncoding: Bool = false
      var insertRawCRLF: Bool = false
      
      if options.contains(.regardAsBinary) {
        if !raw(byte) { requireEncoding = true }
      } else {
        if !raw(byte) && byte != CR && byte != LF && byte != space && byte != TAB {
          requireEncoding = true
        } else if (byte == space || byte == TAB) && (next == .some(CR) || next == .some(LF)) {
          requireEncoding = true
        } else if byte == CR && next != .some(LF) { // meaningless CR
          requireEncoding = true
        }
        
        if (byte == CR && next == .some(LF)) || byte == LF {
          insertRawCRLF = true
        }
      }
      
      // Lines of Quoted-Printable encoded data must not be longer than 76 characters.
      if (requireEncoding && numberOfCharactersInLine > 73) || (!requireEncoding && !insertRawCRLF && numberOfCharactersInLine == 75) {
        result.append(contentsOf:[equalitySign, CR, LF])
        numberOfCharactersInLine = 0
      }
      
      if insertRawCRLF {
        result.append(contentsOf:[CR, LF])
        numberOfCharactersInLine = 0
        if byte == CR { ii += 1 }
      } else {
        if requireEncoding {
          result.append(encode(byte))
          numberOfCharactersInLine += 3
        } else {
          result.append(byte)
          numberOfCharactersInLine += 1
        }
      }
      
    }
    return result
  }
  
  /// Encoding string with quoted-printable
  public func quotedPrintableEncodedString(options: QuotedPrintableEncodingOptions = .default) -> String {
    return String(data:self.quotedPrintableEncodedData(options:options), encoding:.utf8)!
  }
}
