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
internal enum DictionaryParsingError: Error {
  case emptyString
  case emptySeparatorBetweenKeyAndValue
  case emptySeparatorBetweenPairs
  case invalidCharacter(Character, String.Index)
  case unexpectedEndOfString
}
private var quotationMarks: [String:String] {
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
extension Dictionary where Key == String, Value == String {
  internal init(keyValuePairs string:String,
                 allowedUnquotedCharacters token:BonaFideCharacterSet = .alphanumerics,
                 ignorableCharacters ignorables:BonaFideCharacterSet = .whitespacesAndNewlines,
                 keyAndValueAreSeparatedBy kvSeparator:String = "=",
                 pairsAreSeparatedBy pSeparator:String = ";",
                 allowMissingValues: Bool = true) throws {
    if string.isEmpty {
      throw DictionaryParsingError.emptyString
    }
    if kvSeparator.isEmpty {
      throw DictionaryParsingError.emptySeparatorBetweenKeyAndValue
    }
    if pSeparator.isEmpty {
      throw DictionaryParsingError.emptySeparatorBetweenPairs
    }
    self.init()
    
    var key = String()
    var value = String()

    var processing: Processing = .key

    var escaped: Bool = false
    var quotationMark: String? = nil

    let lengths: [Processing:Int] = [
      .keyValueSeparator:kvSeparator.count,
      .pairSeparator:pSeparator.count
    ]

    let separators: [Processing:String] = [
      .keyValueSeparator:kvSeparator,
      .pairSeparator:pSeparator
    ]
    
    // Process characters one by one
    var ii = string.startIndex
    scan: while ii < string.endIndex {
      defer {
        ii = string.index(after:ii)
      }
      
      let character = string[ii]
      
      switch processing {
      case .key, .value:
        if (processing == .key ? key : value).isEmpty && quotationMark == nil {
          // No characters are appended to `key`/`value`
          if ignorables.contains(character) { continue scan }
          
          // Check if there's quotation mark or not.
          for (open, close) in quotationMarks {
            if string.matches(open, from:ii) {
              quotationMark = close
              ii = string.index(ii, offsetBy:open.count - 1)
              continue scan
            }
          }
          
          // Now, `character` must be unquoted character.
          guard token.contains(character) else {
            throw DictionaryParsingError.invalidCharacter(character, ii)
          }
          if processing == .key {
            key.append(character)
          } else {
            value.append(character)
          }
        } else {
          // Some characters exist in `key`/`vallue`
          if quotationMark == nil {
            // not in quoted-string
            
            
            if token.contains(character) {
              if processing == .key {
                key.append(character)
              } else {
                value.append(character)
              }
            } else if ignorables.contains(character) {
              // end of the key/value
              processing.next()
            } else {
              // `character` is not key nor value
              guard ii > string.startIndex else {
                throw DictionaryParsingError.invalidCharacter(character, ii)
              }
              ii = string.index(before:ii)
              processing.next()
            }
          } else {
            // in quoted-string
            
            if !escaped && character == "\\" {
              // let's escape it
              escaped = true
              continue scan
            }
            
            if !escaped && string.matches(quotationMark!, from:ii) {
              // end of quotation
              ii = string.index(ii, offsetBy:quotationMark!.count - 1)
              quotationMark = nil
              processing.next()
            } else {
              // Append it
              if processing == .key {
                key.append(character)
              } else {
                value.append(character)
              }
              escaped = false
            }
          }
        }
        
        if processing == .pairSeparator ||
          (processing == .value && quotationMark == nil && ii == string.index(before:string.endIndex)) {
          // Last character of value has been appended.
          self[key] = value
          key.removeAll(keepingCapacity:true)
          value.removeAll(keepingCapacity:true)
          continue scan
        }
        
        if allowMissingValues && processing == .key && quotationMark == nil && ii == string.index(before:string.endIndex) {
          self[key] = ""
          key.removeAll()
          value.removeAll()
        }
      case .keyValueSeparator, .pairSeparator:
        // There might be the next pair even if processing == .keyValueSparator
        if allowMissingValues && processing == .keyValueSeparator &&
          (
            string.matches(separators[.pairSeparator]!, from:ii) ||
            (ii == string.index(before:string.endIndex) && ignorables.contains(character))
          ) {
          self[key] = ""
          key.removeAll(keepingCapacity:true)
          value.removeAll(keepingCapacity:true)
          if ii == string.index(before:string.endIndex) {
            break scan
          } else {
            ii = string.index(ii, offsetBy:lengths[.pairSeparator]! - 1)
            processing = .key
            continue scan
          }
          
        }
        
        if ignorables.contains(character) { continue scan }
        
        if string.matches(separators[processing]!, from:ii) {
          ii = string.index(ii, offsetBy:lengths[processing]! - 1)
          processing.next()
          continue scan
        }
        
        throw DictionaryParsingError.invalidCharacter(character, ii)
      } // end of switch
    } // end of `scan:`
    
    guard key.isEmpty && value.isEmpty else { throw DictionaryParsingError.unexpectedEndOfString }
  }
}

