/***************************************************************************************************
 CGIResponderError.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # CGIResponderError
 Defines errors
 
 */
public enum CGIResponderError: Error {
  case invalidArgument
  case illegalOperation
  case missingRequiredHTTPHeaderField(name:HTTPHeaderFieldName)
  case unexpectedError(message:String)
}

