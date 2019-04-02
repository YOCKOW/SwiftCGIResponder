/* *************************************************************************************************
 Data+XHTML.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet
import Foundation
import yExtensions

// "Prolog" consists of only ASCII characters (except contents of comments).
// So, Non-ASCII characters can be ignored to detect XML/XHTML version.

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
// "XMLDecl" starts with "<?xml" and ends with "?>"
// "Comment" starts with "<!--" and ends with "-->"
// "PI" starts with "<?" and ends with "?>"
// "doctypedecl" starts with "<!DOCTYPE" and ends with ">"

private struct _ASCIICode: ExpressibleByUnicodeScalarLiteral, Equatable {
  typealias UnicodeScalarLiteralType = Unicode.Scalar
  private var _scalar: Unicode.Scalar
  fileprivate var scalar: Unicode.Scalar { return self._scalar }

  fileprivate init(unicodeScalarLiteral scalar:Unicode.Scalar) {
    assert(scalar.value < 0x80, "\(scalar) is Non-ASCII.")
    self._scalar = scalar
  }

  fileprivate init?<U>(_ value:U) where U: UnsignedInteger & FixedWidthInteger {
    guard value < 0x80 else { return nil }
    self._scalar = Unicode.Scalar(UInt8(value))
  }
  
  fileprivate func isContained(in scalars:UnicodeScalarSet) -> Bool {
    return scalars.contains(self._scalar)
  }
}

extension String {
  fileprivate var _asciiCodes: [_ASCIICode] {
    var result: [_ASCIICode] = []
    for scalar in self.unicodeScalars {
      if scalar > "\u{7F}" { fatalError("Non-ASCII.") }
      result.append(.init(unicodeScalarLiteral:scalar))
    }
    return result
  }
  
  fileprivate init(_ asciiCodes:[_ASCIICode]) {
    self.init(UnicodeScalarView(asciiCodes.map{ $0.scalar }))
  }
}

extension Data.View {
  fileprivate subscript(_ distance:Int) -> _ASCIICode? {
    let index = self.index(self.startIndex, offsetBy:distance)
    let int = self[index]
    return _ASCIICode(int)
  }
}

private struct _ASCIICodeView {
  private class _Box {
    fileprivate func asciiCode(at index:Int) -> _ASCIICode? { fatalError("Must be overriden.") }
    fileprivate var count: Int { fatalError("Must be overriden.") }
  }
  private class _View<U>: _Box where U: UnsignedInteger & FixedWidthInteger {
    private var _base: Data.View<U>
    private var _count: Int
    fileprivate override var count: Int { return self._count }
    
    fileprivate init(_ view:Data.View<U>) {
      self._base = view
      self._count = view.count
    }
    
    fileprivate override func asciiCode(at index: Int) -> _ASCIICode? {
      return self._base[index]
    }
    
  }
  
  private var _box: _Box
  fileprivate init<U>(_ view:Data.View<U>) where U: UnsignedInteger & FixedWidthInteger {
    self._box = _View<U>(view)
  }
  
  fileprivate subscript(_ index:Int) -> _ASCIICode? {
    return  self._box.asciiCode(at:index)
  }
  
  fileprivate subscript(_ range:Range<Int>) -> [_ASCIICode]? {
    var result: [_ASCIICode] = []
    for ii in range {
      guard let ascii = self[ii] else { return nil }
      result.append(ascii)
    }
    return result
  }
  
  fileprivate var count: Int { return self._box.count }
}

extension _ASCIICodeView {
  fileprivate init?(_ data:Data) {
    // https://www.w3.org/TR/xml/#sec-guessing
    guard data.count > 4 else { return nil } // It should be XHTML...
    let si = data.startIndex
    switch (data[si], data[si + 1], data[si + 2], data[si + 3]) {
    case (0x00, 0x00, 0xFE, 0xFF):
      guard let view = data[(si + 4)..<data.endIndex].uint32BigEndianView else { return nil }
      self.init(view)
    case (0xFF, 0xFE, 0x00, 0x00):
      guard let view = data[(si + 4)..<data.endIndex].uint32LittleEndianView else { return nil }
      self.init(view)
    case (0xFE, 0xFF, _, _):
      guard let view = data[(si + 2)..<data.endIndex].uint16BigEndianView else { return nil }
      self.init(view)
    case (0xFF, 0xFE, _, _):
      guard let view = data[(si + 2)..<data.endIndex].uint16LittleEndianView else { return nil }
      self.init(view)
    case (0xEF, 0xBB, 0xBF, _):
      let view = data[(si + 3)..<data.endIndex].uint8View
      self.init(view)
    case (0x00, 0x00, 0x00, 0x3C):
      guard let view = data.uint32BigEndianView else { return nil }
      self.init(view)
    case (0x3C, 0x00, 0x00, 0x00):
      guard let view = data.uint32LittleEndianView else { return nil }
      self.init(view)
    case (0x00, 0x3C, 0x00, 0x3F):
      guard let view = data.uint16BigEndianView else { return nil }
      self.init(view)
    case (0x3C, 0x00, 0x3F, 0x00):
      guard let view = data.uint16LittleEndianView else { return nil }
      self.init(view)
    case (0x3C, 0x3F, 0x78, 0x6D):
      let view = data.uint8View
      self.init(view)
    default:
      // unsupported encoding?
      return nil
    }
  }
}

extension _ASCIICodeView {
  fileprivate var _indexOfFirstLT: Int? {
    // Although XML must start with "<?xml",
    // leading whitespaces are accepted here.
    for ii in 0..<self.count {
      guard let ascii = self[ii] else { return nil }
      if ascii.isContained(in:.xmlWhitespaces) { continue }
      if ascii == "<" { return ii }
      return nil // The first non-space character is not "<"
    }
    return nil
  }
  
  fileprivate func _matches(_ sequence:[_ASCIICode], from index:Int) -> Bool {
    guard index + sequence.count <= self.count else { return false }
    for ii in 0..<sequence.count {
      guard sequence[ii] == self[index + ii] else { return false }
    }
    return true
  }
  
  fileprivate func _next(sequence:[_ASCIICode], from index:Int) -> Range<Int>? {
    for ii in index..<self.count {
      if self._matches(sequence, from: ii) { return ii..<(ii + sequence.count) }
    }
    return nil
  }
  
  fileprivate func _next(asciiCode:_ASCIICode, from index:Int) -> Int? {
    for ii in index..<self.count {
      if self[ii] == asciiCode { return ii }
    }
    return nil
  }
  
  fileprivate func _xmlDeclStarts(from index:Int) -> Bool {
    return self._matches("<?xml"._asciiCodes, from:index)
  }
  fileprivate func _rangeOfXMLDecl(from index:Int) -> Range<Int>? {
    guard self._xmlDeclStarts(from:index) else { return nil }
    guard let rangeOfClose = self._next(sequence:"?>"._asciiCodes, from:index) else { return nil }
    return index ..< rangeOfClose.upperBound
  }

  fileprivate func _commentStarts(from index:Int) -> Bool {
    return self._matches("<!--"._asciiCodes, from:index)
  }
  fileprivate func _rangeOfComment(from index:Data.Index) -> Range<Data.Index>? {
    guard self._commentStarts(from:index) else { return nil }
    guard let rangeOfClose = self._next(sequence:"-->"._asciiCodes, from:index) else { return nil }
    return index ..< rangeOfClose.upperBound
  }

  fileprivate func _piStarts(from index:Int) -> Bool {
    return self._matches("<?"._asciiCodes, from:index)
  }
  fileprivate func _rangeOfPI(from index:Int) -> Range<Int>? {
    guard self._piStarts(from:index) else { return nil }
    guard let rangeOfClose = self._next(sequence:"?>"._asciiCodes, from:index) else { return nil }
    return index ..< rangeOfClose.upperBound
  }

  fileprivate func _doctypeStarts(from index:Int) -> Bool {
    return self._matches("<!DOCTYPE"._asciiCodes, from:index)
  }
  fileprivate func _rangeOfDOCTYPE(from index:Int) -> Range<Int>? {
    guard self._doctypeStarts(from:index) else { return nil }
    var countOfLT = 0
    for ii in (index + 9)..<self.count {
      if self[ii] == "<" { countOfLT += 1 }
      if self[ii] == ">" {
        if countOfLT == 0 { return index ..< (ii + 1) }
        countOfLT -= 1
      }
    }
    return nil
  }
  
  fileprivate func _string(in range:Range<Int>) -> String? {
    guard let codes = self[range] else { return nil }
    return String(codes)
  }
}

extension Data {
  /// Detect information about XHTML as far as possible.
  /// `stringEncoding` is the encoding that is declared in "XML declartion".
  public var xhtmlInfo: (xmlVersion:String?, stringEncoding:String.Encoding?, version:Version?) {
    typealias Result = (xmlVersion:String?, stringEncoding:String.Encoding?, version:Version?)
    var result:Result = (nil,nil,nil)
    
    guard let view = _ASCIICodeView(self) else { return (nil,nil,nil) }
    guard let indexOfFirstLT = view._indexOfFirstLT else { return (nil,nil,nil) }
    
    var position: Int = indexOfFirstLT

    if let rangeOfXMLDecl = view._rangeOfXMLDecl(from:indexOfFirstLT) {
      let startIndexOfAttr = rangeOfXMLDecl.lowerBound + 5
      let endIndexOfAttr = rangeOfXMLDecl.upperBound - 2

      if let attributes = view._string(in:startIndexOfAttr..<endIndexOfAttr) {
        // `attributes` is string like `version="1.0" encoding="UTF-8"`.
        if let pseudoElement = try? XMLElement(xmlString:"<element \(attributes) />") {
          if let version = pseudoElement.attribute(forName:"version")?.stringValue {
            result.xmlVersion = version
          }
          if let encoding_string = pseudoElement.attribute(forName:"encoding")?.stringValue,
             let encoding = String.Encoding(ianaCharacterSetName:encoding_string)
          {
            result.stringEncoding = encoding
          }
        }
      }

      position = rangeOfXMLDecl.upperBound
    }

    // Next, search "doctypedecl"
    while true {
      // Only "Comment" or "PI" can be accepted before "doctypedecl"
      guard
        let indexOfLT = view._next(asciiCode:"<", from:position),
        indexOfLT < view.count - 2,
        view[indexOfLT + 1] == "?" || view[indexOfLT + 1] == "!"
      else {
        break
      }

      if let range = view._rangeOfComment(from:indexOfLT) {
        position = range.upperBound
        continue
      }

      if let range = view._rangeOfPI(from:indexOfLT) {
        position = range.upperBound
        continue
      }

      if let range = view._rangeOfDOCTYPE(from:indexOfLT), let doctype = view._string(in:range) {
        result.version = Version(_documentType:doctype)
        break
      }

      // Other element
      break
    }

    return result
  }
}
