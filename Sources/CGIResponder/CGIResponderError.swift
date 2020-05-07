/* *************************************************************************************************
 CGIResponderError.swift
   © 2017-2018, 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import NetworkGear

/// Errors related to `CGIResponder`
public enum CGIResponderError: Error, Equatable {
  case dataConversionFailure
  case invalidArgument
  case illegalOperation
  case missingRequiredHTTPHeaderField(name: HTTPHeaderFieldName)
  case statusCodeInconsistency(expectedStatusCode: HTTPStatusCode, specifiedStatusCode: HTTPStatusCode)
  case stringConversionFailure
  case stringEncodingInconsistency(actualEncoding: String.Encoding, specifiedEncoding: String.Encoding)
  case unexpectedError(message:String)
}


