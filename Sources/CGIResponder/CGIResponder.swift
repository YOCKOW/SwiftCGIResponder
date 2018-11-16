/* *************************************************************************************************
 CGIResponder.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
import LibExtender

/// The principal structure that can respond to the client.
public struct CGIResponder {
  /// An instance of `HTTPStatusCode` that indicates the result of response.
  public var status: HTTPStatusCode = .ok
  
  /// Response header that contains some HTTP header fields.
  public var header: HTTPHeader = HTTPHeader([])
  
  /// The content.
  public var content: CGIContent = .string("", encoding:.utf8)
}

extension CGIResponder {
  /// The content type of the response.
  /// This property is computed from `HTTPHeader`.
  public var contentType: ContentType {
    get {
      guard let field = self.header[.contentType].first else {
        return ContentType(type:.application, subtype:"octet-stream")!
      }
      return field.source as! ContentType
    }
    set {
      self.header[.contentType] = [.contentType(newValue)]
    }
  }
  
  /// Get and set "charset" directly.
  public var stringEncoding: String.Encoding? {
    get {
      guard let params = self.contentType.parameters else { return nil }
      guard let name = params["charset"] else { return nil }
      guard let encoding = String.Encoding(ianaCharacterSetName:name) else { return nil }
      return encoding
    }
    set {
      var contentType = self.contentType
      var params: ContentType.Parameters = contentType.parameters ?? [:]
      if let encoding = newValue {
        params["charset"] = encoding.ianaCharacterSetName! // error may occur
      } else {
        params.removeValue(forKey:"charset")
      }
      contentType.parameters = params
      self.contentType = contentType
    }
  }
}

extension CGIResponder {
  /// Estimate the expected status by checking ETag or Last-Modified.
  public var expectedStatus: HTTPStatusCode? {
    let header = self.header
    let req = Client.client.request
    
    if let eTagHeaderField = header[.eTag].first, let eTag = eTagHeaderField.source as? HTTPETag {
      if let ifMatch = req.ifMatch {
        if !ifMatch.contains(eTag, weakComparison:false) { return .preconditionFailed }
      } else if let ifNoneMatch = req.ifNoneMatch {
        if ifNoneMatch.contains(eTag, weakComparison:true) { return .notModified }
      }
    } else if let lastModifiedField = header[.lastModified].first,
              let lastModified = lastModifiedField.source as? Date
    {
      if let ifUnmodifiedSince = req.ifUnmodifiedSince {
        if lastModified > ifUnmodifiedSince { return .preconditionFailed }
      } else if let ifModifiedSince = req.ifModifiedSince {
        if lastModified <= ifModifiedSince { return .notModified }
      }
    }
    return nil
  }
}
