/***************************************************************************************************
 Dictionary+KeyValuePairsString.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation
 
/**
 
 # Dictionary+KeyValuePairsString
 Initialize from key-value pair string
 e.g.) charset=UTF-8; filename="my_file.txt" -> ["charset":"UTF-8", "filename":"my_file.txt"]
 
 */
extension Dictionary where Key == String, Value == String {
  private static var quotationMarks: [String:String] {
    return [
      "\"":"\"",
      "'":"'",
      "(":")",
      "<":">",
      "[":"]",
      "{":"}"
    ]
  }
  
  private enum Processing {
    case key, keyValueSeparator, value, pairSeparator
    mutating func next() {
      switch self {
      case .key: self = .keyValueSeparator
      case .keyValueSeparator: self = .value
      case .value: self = .pairSeparator
      case .pairSeparator: self = .key
      }
    }
  }
  
  internal init?(keyValuePairs string:String,
                 allowedUnquotedCharacters token:CharacterSet = .alphanumerics,
                 ignorableCharacters ignorables:CharacterSet = .whitespaces,
                 keyAndValueAreSeparatedBy kvSeparator:String = "=",
                 pairsAreSeparatedBy pSeparator:String = ";") {
    fatalError("Not implemented yet.")
    return nil
  }
}

