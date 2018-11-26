/* *************************************************************************************************
 Token.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet

// Simple Lexer for HTTP header field values

internal class _Token {
  private let _scalars: String.UnicodeScalarView
  internal init(_ scalars:String.UnicodeScalarView) {
    self._scalars = scalars
  }
  
  internal var _string: String {
    return String(self._scalars)
  }
  
  internal class _QuotedString: _Token {
    internal override var _string: String {
      return String(self._scalars)._unquotedString!
    }
  }
  
  internal class _RawString: _Token {}
  
  internal class _Separator: _Token {}
}

private enum _Processing { case whitespace, quotedString, rawString }

extension StringProtocol {
  internal var _tokens: [_Token]? {
    var processing: _Processing = .whitespace
    var tokens: [_Token] = []
    
    var escaped = false
    var scalars: String.UnicodeScalarView? = nil
    for scalar in self.unicodeScalars {
      switch processing {
      case .whitespace:
        if UnicodeScalarSet.whitespaces.contains(scalar) { continue }
        
        scalars = .init([scalar])
        if scalar == "\"" {
          processing = .quotedString
        } else if UnicodeScalarSet.httpTokenAllowed.contains(scalar) {
          processing = .rawString
        } else if UnicodeScalarSet.httpSeparatorAllowed.contains(scalar) {
          tokens.append(_Token._Separator(scalars!))
          scalars = nil
          processing = .whitespace
        } else {
          return nil
        }
        
      case .quotedString:
        guard let _ = scalars else { fatalError("Unexpected.") }
        guard UnicodeScalarSet.httpEscapableUnicodeScalars.contains(scalar) else { return nil }
        scalars!.append(scalar)
        if !escaped {
          if scalar == "\\" {
            escaped = true
            continue
          } else if scalar == "\"" {
            tokens.append(_Token._QuotedString(scalars!))
            scalars = nil
            processing = .whitespace
          }
        }
        escaped = false
      
      case .rawString:
        guard let _ = scalars else { fatalError("Unexpected.") }
        if UnicodeScalarSet.httpTokenAllowed.contains(scalar) {
          scalars!.append(scalar)
        } else if UnicodeScalarSet.httpSeparatorAllowed.contains(scalar) {
          tokens.append(_Token._RawString(scalars!))
          if scalar == "\"" {
            // is it right?
            scalars = .init([scalar])
            processing = .quotedString
          } else {
            tokens.append(_Token._Separator(.init([scalar])))
            scalars = nil
            processing = .whitespace
          }
        } else {
          return nil
        }
      }
    }
    
    switch processing {
    case .whitespace:
      break
    case .quotedString:
      // not closed...
      return nil
    case .rawString:
      tokens.append(_Token._RawString(scalars!))
    }
    
    return tokens
  }
}
