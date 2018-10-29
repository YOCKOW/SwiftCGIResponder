/* *************************************************************************************************
 ETagParser.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import UnicodeSupplement

public enum ETagParseError: Error, Equatable {
  case unexpectedCharacter
  case extraComma
  case unterminatedTag
}

extension Character {
  fileprivate var _isWhiteSpace: Bool {
    let scalars = self.unicodeScalars
    guard scalars.count == 1 else { return false }
    return scalars[scalars.startIndex].latestProperties.isWhitespace
  }
}

extension String {
  /// Search the open quote of the e-tag.
  fileprivate func _nextStartIndexOfTag(from index:String.Index, maxNumberOfCommas:Int = 1)
    throws -> String.UnicodeScalarView.Index
  {
    var ii = index
    var numberOfCommas = 0
    while true {
      if ii == self.endIndex { break }
      
      let character = self[ii]
      if !character._isWhiteSpace {
        if character == "," {
          numberOfCommas += 1
          if numberOfCommas > maxNumberOfCommas { throw ETagParseError.extraComma }
        } else if character == "\"" || character == "W" {
          break
        } else {
          throw ETagParseError.unexpectedCharacter
        }
      }
      
      ii = self.index(after:ii)
    }
    return ii
  }
  
  /// Judge the validity of open quote
  fileprivate func _validOpenQuote(at index:String.Index) -> Bool {
    let character = self[index]
    if character == "\"" {
      return true
    } else if character == "W" {
      let nextIndex = self.index(after:index)
      guard nextIndex < self.endIndex else { return false }
      guard self[nextIndex] == "/" else { return false }
      
      let nextOfNextIndex = self.index(after:nextIndex)
      guard nextOfNextIndex < self.endIndex else { return false }
      return self[nextOfNextIndex] == "\""
    }
    return false
  }
  
  /// search the close quote
  fileprivate func _indexOfCloseQuote(indexOfOpenQuote:String.Index) throws -> String.Index {
    guard self._validOpenQuote(at:indexOfOpenQuote) else { throw ETagParseError.unexpectedCharacter }
    
    let numberOfCharactersOfOpenQuote = self[indexOfOpenQuote] == "\"" ? 1 : 3
    
    guard self.distance(from:indexOfOpenQuote, to:self.endIndex) > numberOfCharactersOfOpenQuote
    else {
      throw ETagParseError.unterminatedTag
    }
    
    var ii = self.index(indexOfOpenQuote, offsetBy:numberOfCharactersOfOpenQuote)
    var escaped = false
    while true {
      if ii >= self.endIndex { throw ETagParseError.unterminatedTag }
      
      if !escaped {
        let character = self[ii]
        if character == "\\" {
          escaped = true
        } else if character == "\"" {
          return ii
        }
      } else {
        escaped = false
      }
      
      ii = self.index(after:ii)
    }
    
  }
}


extension Array where Element == ETag {
  /// Initialize from `string`.
  /// - parameter string: such as ` "A", "B", W/"C" `
  public init(string:String) throws {
    self.init()
    
    if string == "*" {
      self.append(.any)
      return
    }
    
    var ii = string.startIndex
    while true {
      let startIndexOfTag = try string._nextStartIndexOfTag(from:ii,
                                                            maxNumberOfCommas:ii == string.startIndex ? 0 : 1)
      if startIndexOfTag == string.endIndex { break }
      
      let indexOfCloseQuote = try string._indexOfCloseQuote(indexOfOpenQuote:startIndexOfTag)
      let wholeTag = string[startIndexOfTag...indexOfCloseQuote]
      
      guard let eTag = ETag(String(wholeTag)) else { throw ETagParseError.unexpectedCharacter }
      self.append(eTag)
      
      ii = string.index(after:indexOfCloseQuote)
    }
  }
}
