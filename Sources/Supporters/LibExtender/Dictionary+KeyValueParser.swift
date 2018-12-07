/* *************************************************************************************************
 Dictionary+KeyValueParser.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import UnicodeSupplement

public enum DictionaryParseError: Error {
  
}

private var _quotationMarks: [String:String] = [
  "\"":"\"",
  "'":"'",
  "(":")",
  "<":">",
  "[":"]",
  "{":"}"
]

extension Character {
  fileprivate var _isWhiteSpace: Bool {
    for scalar in self.unicodeScalars {
      guard scalar.latestProperties.isWhitespace else { return false }
    }
    return true
  }
}

extension String {
  fileprivate func _nextStartIndexOfString(
    from index:String.Index,
    separator:String
  ) -> String.Index
  {
    var ii = index
    while true {
      if ii == self.endIndex { break }
      
      let character = self[ii]
      if !character._isWhiteSpace {
        if self.matches(separator, from:ii) {
          ii = self.index(ii, offsetBy:separator.count - 1)
        } else {
          return ii
        }
      }
      
      ii = self.index(after:ii)
    }
    return ii
  }
  
  fileprivate func _string_endIndex(
    from index:String.Index,
    separator:String
  ) -> (string:String, endIndex:String.Index)
  {
    var string = String()
    
    let quotPair: (String, String)? = ({ (string:String) -> (String, String)? in
      for (open, close) in _quotationMarks {
        if string.matches(open, from:index) { return (open, close) }
      }
      return nil
    })(self)
    
    var ii = self.index(index, offsetBy:quotPair?.0.count ?? 0)
    var escaped = false
    while true {
      if ii == self.endIndex { break }
      
      let character = self[ii]
      
      if character == "\\" && !escaped {
        escaped = true
      } else if escaped {
        string.append(character)
        escaped = false
      } else if let closeQuote = quotPair?.1 {
        if self.matches(closeQuote, from:ii) {
          return (string, self.index(ii, offsetBy:closeQuote.count))
        }
        string.append(character)
      } else if self.matches(separator, from:ii) {
        return (string, ii)
      } else {
        string.append(character)
      }
      
      ii = self.index(after:ii)
    }
    
    return (string, ii)
  }
}

extension Dictionary {
  /// Initialize with `string` such as "A=B; C=D; E=F"
  public init(parsing string:String,
              keyAndValueAreSeparatedBy kvSeparator:String = "=",
              pairsAreSeparatedBy pairSeparator:String = ";",
              converter:(String, String) throws -> (key:Key,value:Value))
    rethrows
  {
    self.init()
    
    var ii = string.startIndex
    while true {
      let startIndexOfKey = string._nextStartIndexOfString(from:ii, separator:pairSeparator)
      if startIndexOfKey >= string.endIndex { break }
      
      let (key, endIndexOfKey) = string._string_endIndex(from:startIndexOfKey, separator:kvSeparator)
      let startIndexOfValue = string._nextStartIndexOfString(from:endIndexOfKey, separator:kvSeparator)
      if startIndexOfValue >= string.endIndex {
        let (modifiedKey, modifiedValue) = try converter(key, "")
        self[modifiedKey] = modifiedValue
        break
      }
      
      let (value, endIndexOfValue) = string._string_endIndex(from:startIndexOfValue, separator:pairSeparator)
      let (modifiedKey, modifiedValue) = try converter(key, value)
      self[modifiedKey] = modifiedValue
      ii = endIndexOfValue
    }
  }
}

extension Dictionary where Key == String, Value == String {
  /// Initialize with `string` such as "A=B; C=D; E=F"
  public init(parsing string:String,
              keyAndValueAreSeparatedBy kvSeparator:String = "=",
              pairsAreSeparatedBy pairSeparator:String = ";")
  {
    try! self.init(parsing:string,
                   keyAndValueAreSeparatedBy:kvSeparator,
                   pairsAreSeparatedBy:pairSeparator,
                   converter:{ return ($0, $1) })
  }
}
