/* *************************************************************************************************
 Data+XHTML.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation
import LibExtender

// Reference: https://www.w3.org/TR/REC-xml/#sec-prolog-dtd
/*
 Prolog
 
 [22]     prolog     ::=     XMLDecl? Misc* (doctypedecl Misc*)?
 [23]     XMLDecl     ::=     '<?xml' VersionInfo EncodingDecl? SDDecl? S? '?>'
 [24]     VersionInfo     ::=     S 'version' Eq ("'" VersionNum "'" | '"' VersionNum '"')
 [25]     Eq     ::=     S? '=' S?
 [26]     VersionNum     ::=     '1.' [0-9]+
 [27]     Misc     ::=     Comment | PI | S
 */

// "XMLDecl" starts with "<?xml"

// "Comment" starts with "<!--"
// "PI" starts with "<?"

// "doctypedecl" starts with "<!DOCTYPE"

extension UInt8 {
  fileprivate var _isXMLWhitespace: Bool {
    return self == 0x20 || self == 0x09 || self == 0x0A || self == 0x0D
  }
  
  
  fileprivate static let _exclamation: UInt8 = 0x0021
  fileprivate static let _hyphen: UInt8 = 0x002D
  fileprivate static let _lt: UInt8 = 0x3C
  fileprivate static let _gt: UInt8 = 0x3E
  fileprivate static let _question: UInt8 = 0x3F
  
  fileprivate static let _C: UInt8 = 0x43
  fileprivate static let _D: UInt8 = 0x44
  fileprivate static let _E: UInt8 = 0x45
  fileprivate static let _O: UInt8 = 0x4F
  fileprivate static let _P: UInt8 = 0x50
  fileprivate static let _T: UInt8 = 0x54
  fileprivate static let _Y: UInt8 = 0x59
  fileprivate static let _l: UInt8 = 0x6C
  fileprivate static let _m: UInt8 = 0x6D
  fileprivate static let _x: UInt8 = 0x78
}

extension Data {
  private var _indexOfFirstLT: Data.Index? {
    for ii in 0..<self.endIndex {
      let byte = self[ii]
      if byte._isXMLWhitespace { continue }
      if byte == ._lt { return ii }
      return nil // The first non-space character is not "<"
    }
    return nil
  }
  
  private func _matches(_ sequence:[UInt8], from index:Data.Index) -> Bool {
    guard index + sequence.count <= self.endIndex else { return false }
    
    for ii in 0..<sequence.count {
      guard sequence[ii] == self[index + ii] else { return false }
    }
    return true
  }
  
  private func _next(sequence:[UInt8], from index:Data.Index) -> Range<Data.Index>? {
    for ii in index..<self.endIndex {
      if self._matches(sequence, from:ii) { return ii..<(ii + sequence.count) }
    }
    return nil
  }
  
  private func _next(byte:UInt8, from index:Data.Index) -> Data.Index? {
    for ii in index..<self.endIndex {
      if self[ii] == byte { return ii }
    }
    return nil
  }
  
  private func _xmlDeclStarts(from index:Data.Index) -> Bool {
    return self._matches([._lt, ._question, ._x, ._m, ._l], from:index)
  }
  private func _rangeOfXMLDecl(from index:Data.Index) -> Range<Data.Index>? {
    guard self._xmlDeclStarts(from:index) else { return nil }
    guard let rangeOfClose = self._next(sequence:[._question, ._gt], from:index) else { return nil }
    return index ..< rangeOfClose.upperBound
  }
  
  private func _commentStarts(from index:Data.Index) -> Bool {
    return self._matches([._lt, ._exclamation, ._hyphen, ._hyphen], from:index)
  }
  private func _rangeOfComment(from index:Data.Index) -> Range<Data.Index>? {
    guard self._commentStarts(from:index) else { return nil }
    guard let rangeOfClose = self._next(sequence:[._hyphen, ._hyphen, ._gt], from:index) else { return nil }
    return index ..< rangeOfClose.upperBound
  }
  
  private func _piStarts(from index:Data.Index) -> Bool {
    return self._matches([._lt, ._question], from:index)
  }
  private func _rangeOfPI(from index:Data.Index) -> Range<Data.Index>? {
    guard self._piStarts(from:index) else { return nil }
    guard let rangeOfClose = self._next(sequence:[._question, ._gt], from:index) else { return nil }
    return index ..< rangeOfClose.upperBound
  }
  
  private func _doctypeStarts(from index:Data.Index) -> Bool {
    return self._matches([._lt, ._exclamation, ._D, ._O, ._C, ._T, ._Y, ._P, ._E], from:index)
  }
  private func _rangeOfDOCTYPE(from index:Data.Index) -> Range<Data.Index>? {
    guard self._doctypeStarts(from:index) else { return nil }
    var countOfLT = 0
    for ii in (index + 9)..<self.endIndex {
      if self[ii] == ._lt { countOfLT += 1 }
      if self[ii] == ._gt {
        if countOfLT == 0 { return index ..< (ii + 1) }
        countOfLT -= 1
      }
    }
    return nil
  }
  
  private var _string: String? {
    if let string = String(data:self, encoding:.utf8) { return string }
    if let string = String(data:self, encoding:.utf16) { return string }
    return nil
  }
  
  internal func _detectXHTMLInfo()
    -> (xmlVersion:String?, encoding:String.Encoding?, version:Version?)
  {
    var result: (xmlVersion:String?, encoding:String.Encoding?, version:Version?) = (nil,nil,nil)
    
    guard let indexOfFirstLT = self._indexOfFirstLT else { return (nil,nil,nil) }
    var position: Data.Index = indexOfFirstLT
    
    if let rangeOfXMLDecl = self._rangeOfXMLDecl(from:indexOfFirstLT) {
      let startIndexOfAttr = rangeOfXMLDecl.lowerBound + 5
      let endIndexOfAttr = rangeOfXMLDecl.upperBound - 2
      
      if let attributes = self[startIndexOfAttr..<endIndexOfAttr]._string {
        // `attributes` may be `version="1.0" encoding="UTF-8"`.
        if let pseudoElement = try? XMLElement(xmlString:"<element \(attributes) />") {
          if let version = pseudoElement.attribute(forName:"version")?.stringValue {
            result.xmlVersion = version
          }
          if let encoding_string = pseudoElement.attribute(forName:"encoding")?.stringValue,
             let encoding = String.Encoding(ianaCharacterSetName:encoding_string)
          {
            result.encoding = encoding
          }
        }
      }
      
      position = rangeOfXMLDecl.upperBound
    }
    
    // Next, search "doctypedecl"
    while true {
      // Only "Comment" or "PI" can be accepted before "doctypedecl"
      guard
        let indexOfLT = self._next(byte:._lt, from:position),
        indexOfLT < self.endIndex - 2,
        self[indexOfLT + 1] == ._question || self[indexOfLT + 1] == ._exclamation
      else {
        break
      }
      
      if let range = self._rangeOfComment(from:indexOfLT) {
        position = range.upperBound
        continue
      }
      
      if let range = self._rangeOfPI(from:indexOfLT) {
        position = range.upperBound
        continue
      }
      
      if let range = self._rangeOfDOCTYPE(from:indexOfLT), let doctype = self[range]._string {
        result.version = Version(_documentType:doctype)
        break
      }
      
      // Other element
      break
    }
    
    return result
  }
}
