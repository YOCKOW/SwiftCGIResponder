/***************************************************************************************************
 ContentDispositionRepresentation.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/**
 
 # ContentDispositionRepresentation
 Represents for "Content-Disposition".
 It may not be used directly, but you can use with `HTTPHeaderFieldDelegate.ContentDisposition`.
 
 */
public struct ContentDispositionRepresentation {
  public var value: ContentDispositionValue
  public var parameters: [ContentDispositionParameterKey:String]?
  
  public init(value:ContentDispositionValue,
              parameters:[ContentDispositionParameterKey:String]? = nil) {
    self.value = value
    self.parameters = parameters
  }
}

/// You can also use `ContentDisposition` as its type.
public typealias ContentDisposition = ContentDispositionRepresentation

extension ContentDispositionRepresentation: CustomStringConvertible {
  /// e.g.) attachment; filename="filename.jpg"
  public var description: String {
    var desc = self.value.rawValue
    if let parameters = self.parameters {
      for (key, value) in parameters {
        let escapedValue = value.replacingOccurrences(of:"\\", with:"\\\\").replacingOccurrences(of:"\"", with:"\\\"")
        desc += "; \(key.rawValue)=\"\(escapedValue)\""
      }
    }
    return desc
  }
}

extension ContentDispositionRepresentation {
  /// Initialize from `string`
  public init?(_ string:String) {
    let (value_s, parameters_s) = string.splitOnce(separator:";")
    let value = ContentDispositionValue(rawValue:String(value_s).trimmingCharacters(in:.whitespaces))
    if parameters_s == nil {
      self.init(value:value, parameters:nil)
    } else {
      guard let parameters = try? Dictionary<String,String>(keyValuePairs:String(parameters_s!),
                                                            allowedUnquotedCharacters:.mimeTypeTokenAllowed)
      else {
        return nil
      }
      
      // need to convert `parameters`
      let convertedParameters = parameters.reduce(into:[:]) { (converted, keyValue) in
        converted[ContentDispositionParameterKey(rawValue:keyValue.key)] = keyValue.value
      }
      
      self.init(value:value, parameters:convertedParameters)
    }
  }
}

extension ContentDispositionRepresentation: Hashable {
  public var hashValue: Int {
    var hh = self.value.hashValue
    if let params = self.parameters { hh ^= params.hashValue }
    return hh
  }
  
  public static func ==(lhs:ContentDisposition, rhs:ContentDisposition) -> Bool {
    if lhs.value != rhs.value { return false }
    if let lp = lhs.parameters, let rp = rhs.parameters {
      if lp != rp { return false }
    } else {
      guard lhs.parameters == nil && rhs.parameters == nil else { return false }
    }
    return true
  }
}

