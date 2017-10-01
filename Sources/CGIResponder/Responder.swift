/***************************************************************************************************
 Responder.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/**
 
 # Responder
 The principal structure that can respond to the client.
 
 */
public struct Responder {
  public var status: HTTPStatusCode
  
  public init(status: HTTPStatusCode = .ok) {
    self.status = status
  }
}
