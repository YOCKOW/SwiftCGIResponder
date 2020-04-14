/* *************************************************************************************************
 CGIResponderError.swift
   © 2017-2018, 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import NetworkGear

/// Errors related to `CGIResponder`
public enum CGIResponderError: Error {
  case dataConversionFailure
  case invalidArgument
  case illegalOperation
  case missingRequiredHTTPHeaderField(name: HTTPHeaderFieldName)
  case stringConversionFailure
  case unexpectedError(message:String)
}


