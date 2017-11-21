/***************************************************************************************************
 Array+HTTPETag.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # Array<HTTPETag>
 Make it possible to initialize with string
 
 */
extension Array where Element == HTTPETag {
  private enum Processing { case tag, separator }
  
  /// Initialize from `string`
  /// e.g.) ` "A","B",W/"C" `
  public init?(string:String) {
    self.init()
    if string == "*" {
      self.append(.any)
      return
    }
    
    var processing: Processing = .tag
    var escaped = false
    
    var tag = ""
    for character in string {
      switch processing {
      case .tag:
        if !escaped && character == "\\" {
          escaped = true
          continue
        } else {
          tag.append(character)
          if !escaped && character == "\"" && tag.count > 1 && tag != "W/\"" {
            // end of tag
            guard let eTag = HTTPETag(tag) else { return nil }
            self.append(eTag)
            processing = .separator
            tag.removeAll(keepingCapacity:true)
          }
          escaped = false
        }
      case .separator:
        if character == "," || BonaFideCharacterSet.whitespaces.contains(character) { continue }
        if character == "\"" || character == "W" {
          tag.append(character)
          processing = .tag
        } else {
          return nil
        }
      }
    }
    
    if !tag.isEmpty { return nil }
  }
}

