/* *************************************************************************************************
 EnvironmentVariables.swift
   © 2017-2018, 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

private func _mustBeOverridden(function: StaticString = #function, file: StaticString = #file, line: UInt = #line) -> Never {
  fatalError("`\(function)` must be overridden.", file: file, line: line)
}

/// Represents environment variables
public class EnvironmentVariables {
  private var _environmentVariables: [String: String]
  
  fileprivate init(_ env: [String: String]) {
    self._environmentVariables = env
  }
  
  /// Get and Set an environment variable for `name`
  public subscript(_ name:String) -> String? {
    get {
      return self._environmentVariables[name]
    }
    set {
      self._environmentVariables[name] = newValue
    }
  }
  
  /// Just returns keys of environment variables
  public var names: Dictionary<String, String>.Keys {
    return self._environmentVariables.keys
  }

  /// Remove a value for `name`
  @discardableResult public func removeValue(forName name: String) -> String? {
    guard let value = self[name] else { return nil }
    self[name] = nil
    return value
  }
  
  private final class _Process: EnvironmentVariables {
    init() {
      super.init(ProcessInfo.processInfo.environment)
    }
    
    override subscript(name: String) -> String? {
      get {
        return super[name]
      }
      set {
        let result: CInt = newValue != nil ? setenv(name, newValue!, 1) : unsetenv(name)
        if result == 0 {
          super[name] = newValue
        } else {
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
  }
  
  internal final class _Virtual: EnvironmentVariables {}
  
  /// Represents the variable names and their values in the environment
  /// from which the process was launched.
  public static let `default`: EnvironmentVariables = _Process()
  
  internal static func virtual(_ initialEnvironment: [String: String]) -> EnvironmentVariables {
    return _Virtual(initialEnvironment)
  }
}
