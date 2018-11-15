/* *************************************************************************************************
 EnvironmentVariables.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

/// Represents environment variables
public final class EnvironmentVariables {
  private var _environmentVariables: [String:String] = ProcessInfo.processInfo.environment
  
  private init() {}
  public static let `default` = EnvironmentVariables()
  
  /// Get and Set an environment variable for `name`
  public subscript(_ name:String) -> String? {
    get {
      return self._environmentVariables[name]
    }
    set {
      let result: CInt = newValue != nil ? setenv(name, newValue!, 1) : unsetenv(name)
      if result == 0 {
        if newValue != nil {
          self._environmentVariables[name] = newValue!
        } else {
          self._environmentVariables.removeValue(forKey:name)
        }
      }
      
      if result != 0 {
        switch errno {
        case EINVAL:
          fatalError("`\(name)` is invalid for environment variable name.")
        case ENOMEM:
          fatalError("Unable to allocate memory for the environment.")
        default:
          fatalError("Unable to set environment variable named \(name).")
        }
      }
    }
  }
  
  /// Just returns keys of environment variables
  public var names: Dictionary<String, String>.Keys {
    return self._environmentVariables.keys
  }
  
  /// Remove a value for `name`
  @discardableResult public func removeValue(forName name:String) -> String? {
    guard let value = self[name] else { return nil }
    self[name] = nil
    return value
  }
}
