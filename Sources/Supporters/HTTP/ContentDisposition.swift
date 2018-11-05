/* *************************************************************************************************
 ContentDisposition.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import LibExtender
import Foundation

/// Represents "Content-Disposition"
public struct ContentDisposition {
  public typealias Value = ContentDispositionValue
  public typealias ParameterKey = ContentDispositionParameterKey
  
  public var value: Value
  public var parameters: [ParameterKey:String]?
  
  public init(value:Value, parameters:[ParameterKey:String]? = nil) {
    self.value = value
    self.parameters = parameters
  }
}

extension ContentDisposition: Equatable, Hashable {
  public static func ==(lhs:ContentDisposition, rhs:ContentDisposition) -> Bool {
    return lhs.value == rhs.value && lhs.parameters == rhs.parameters
  }
  
  #if swift(>=4.2)
  public func hash(into hasher:inout Hasher) {
    hasher.combine(self.value)
    hasher.combine(self.parameters)
  }
  #else
  public var hashValue: Int {
    return self.value.hashValue ^ self.parameters.hashValue
  }
  #endif
}

extension ContentDisposition: CustomStringConvertible {
  /// Description for the content disposition.
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

extension ContentDisposition {
  /// Initialize with `string`
  public init(_ string:String) {
    let (value_s, parameters_s) = string.splitOnce(separator:";")
    let value = Value(rawValue:String(value_s).trimmingCharacters(in:.whitespaces))
    if parameters_s == nil {
      self.init(value:value, parameters:nil)
    } else {
      let parameters = Dictionary<ParameterKey,String>(parsing:String(parameters_s!)) {
        let key = ParameterKey(rawValue:$0)
        let value = $1
        return (key, value)
      }
      
      self.init(value:value, parameters:parameters)
    }
  }
}
