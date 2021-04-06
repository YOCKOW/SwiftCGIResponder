/* *************************************************************************************************
 CGIResponderError.swift
   © 2017-2018, 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Errors related to `CGIResponder`
public enum CGIResponderError: CGIError, Equatable {
  case dataConversionFailure
  case invalidArgument
  case illegalOperation
  case missingRequiredHTTPHeaderField(name: HTTPHeaderFieldName)
  case statusCodeInconsistency(expectedStatusCode: HTTPStatusCode, specifiedStatusCode: HTTPStatusCode)
  case stringConversionFailure
  case stringEncodingInconsistency(actualEncoding: String.Encoding, specifiedEncoding: String.Encoding)
  case unexpectedError(message:String)
  
  public var status: HTTPStatusCode {
    return .internalServerError
  }

  public var localizedDescription: String {
    switch self {
    case .dataConversionFailure:
      return "Failed to convert some data."
    case .invalidArgument:
      return "Invalid argument."
    case .illegalOperation:
      return "Illegal Operation."
    case .missingRequiredHTTPHeaderField(name: let name):
      return "HTTP Header Field \"\(name.rawValue)\" is missing."
    case .statusCodeInconsistency(expectedStatusCode: let expectedStatusCode, specifiedStatusCode: let specifiedStatusCode):
      return "Expected status is \(expectedStatusCode.rawValue), but \(specifiedStatusCode.rawValue) is given."
    case .stringConversionFailure:
      return "Faild to convert string."
    case .stringEncodingInconsistency(actualEncoding: let actualEncoding, specifiedEncoding: let specifiedEncoding):
      return "Actual string encoding is \(actualEncoding.description), but \(specifiedEncoding.description) is specified."
    case .unexpectedError(message: let message):
      return "Unexpected Error: \(message)"
    }
  }
}


