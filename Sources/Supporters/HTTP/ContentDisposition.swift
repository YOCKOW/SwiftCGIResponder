/* *************************************************************************************************
 ContentDisposition.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

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
