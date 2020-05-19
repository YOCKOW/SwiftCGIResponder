/* *************************************************************************************************
 CGIError.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation
import NetworkGear

public protocol CGIError: Error {
  var status: HTTPStatusCode { get }
  var localizedDescription: String { get }
}


internal struct _VersatileCGIError: CGIError {
  var status: HTTPStatusCode
  
  var _localizedDescription: () -> String
  var localizedDescription: String { return _localizedDescription() }
  
  init(status: HTTPStatusCode = .internalServerError,
       localizedDescription: @escaping @autoclosure () -> String) {
    self.status = status
    self._localizedDescription = localizedDescription
  }
}
