/* *************************************************************************************************
 CGIResponderError.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Errors related to `CGIResponder`
public enum CGIResponderError: Error {
  case invalidArgument
  case illegalOperation
  case missingRequiredHTTPHeaderField(name:HTTPHeaderFieldName)
  case unexpectedError(message:String)
}


