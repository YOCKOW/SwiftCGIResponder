/* *************************************************************************************************
 CGIResponder.swift
   © 2017-2018, 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
import TemporaryFile
import yExtensions
import yProtocols

/// The principal structure that can respond to the client.
public struct CGIResponder {
  /// An instance of `HTTPStatusCode` that indicates the result of response.
  public var status: HTTPStatusCode
  
  /// Response header that contains some HTTP header fields.
  public var header: HTTPHeader
  
  /// The content.
  public var content: CGIContent
  
  internal var _environment: Environment
  
  @usableFromInline
  internal init(
    status: HTTPStatusCode  = .ok,
    header: HTTPHeader = HTTPHeader([]),
    content: CGIContent = .none,
    environment: Environment
  ) {
    self.status = status
    self.header = header
    self.content = content
    self._environment = environment
  }
  
  /// Create a responder.
  ///
  /// - parameter status: Initial status code
  /// - parameter header: Initial HTTP Header
  /// - parameter content: Initial Content
  @inlinable
  public init(
    status: HTTPStatusCode  = .ok,
    header: HTTPHeader = HTTPHeader([]),
    content: CGIContent = .none
  ) {
    self.init(status: status, header: header, content: content, environment: .default)
  }
}

extension CGIResponder {
  /// The content type of the response.
  /// This property is computed from `HTTPHeader`.
  public var contentType: ContentType {
    get {
      guard let field = self.header[.contentType].first else {
        return self.content._defaultContentType
      }
      return field.source as! ContentType
    }
    set {
      self.header.insert(.contentType(newValue), removingExistingFields:true)
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
    let req = _environment.client.request
    
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

extension CGIResponder {
  public static let defaultIgnoringError: (Error) -> Bool = {
    if case let error as CGIResponderError = $0 {
      switch error {
      case .statusCodeInconsistency, .stringEncodingInconsistency:
        return true
      default:
        return false
      }
    } else {
      return false
    }
  }
  
  /**
   
   Respond to client; Print HTTP headers (including "Status") and content to standard output.
   Modifications may be made by Web Server.
   Just call this method after everything is ready.
   
   - parameter ignoringError: You can ignore errors by passing closure that returns `true`,
                              although some errors cannot be ignored.
   
   ```Swift
   import CGIResponder
   var responder = CGIResponder()
   responder.status = .ok
   responder.contentType = ContentType(pathExtension:.txt, parameters:["charset":"UTF-8"])!
   responder.content = .string("Hello, World!\n", encoding:.utf8)
   try! responder.respond()
   
   // -- Output --
   // Status: 200 OK
   // Content-Type: text/plain; charset=UTF-8
   //
   // Hello, World!
   //
   ```
   */
  public func respond(ignoringError: (Error) -> Bool = defaultIgnoringError) throws {
    var stdout = _environment.standardOutput
    try self.respond(to: &stdout, ignoringError: ignoringError)
  }
  
  /// For debug purpose, you can specify output.
  public func respond<Respondee>(
    to output: inout Respondee,
    ignoringError: (Error) -> Bool = defaultIgnoringError
  ) throws where Respondee: CGIContentOutputStream {
    func _throwIfNeeded(_ error: Error) throws {
      if !ignoringError(error) { throw error }
    }
    
    // Check if there's mismatch about string encoding.
    if let contentEncoding = self.content._stringEncoding, let specifiedEncoding = self.stringEncoding {
      if contentEncoding != specifiedEncoding {
        try _throwIfNeeded(
          CGIResponderError.stringEncodingInconsistency(actualEncoding: contentEncoding,
                                                        specifiedEncoding: specifiedEncoding)
        )
      }
    }
    
    // Check if `status` is an expected value or not using ETag or Last-Modified
    if let expectedStatus = self.expectedStatus, self.status != expectedStatus {
      try _throwIfNeeded(
        CGIResponderError.statusCodeInconsistency(expectedStatusCode: expectedStatus,
                                                  specifiedStatusCode: self.status)
      )
    }
    
    if self.status.rawValue == 201 || self.status.rawValue / 100 == 3 {
      guard self.header[.location].count > 0 else {
        throw CGIResponderError.missingRequiredHTTPHeaderField(name:.location)
      }
    }
    
    // Status
    try output.write(
      CGIContent(string:"Status: \(status.rawValue) \(status.reasonPhrase)\u{000D}\u{000A}")
    )
    
    // Requires `Content-Type:`
    var header = self.header
    if header[.contentType].count < 1 {
      header.insert(.contentType(self.content._defaultContentType))
    }
    try output.write(CGIContent(string:header.description))
    
    // If the method is HEAD, the body is not required.
    if let method = Environment.default.client.request.method, method == .head {
      return
    }
    
    // print contents
    try output.write(self.content)
  }
}

extension CGIResponder {
  /// Respond to the client.
  /// If any error is thrown, the response will be generated by an instance of `Fallback`.
  ///
  /// # Sample Code
  /// ```Swift
  /// struct Fallback: CGIFallback {
  ///    var status: HTTPStatusCode
  ///    var fallbackContent: CGIContent
  ///    init(_ error: CGIError) {
  ///      self.status = error.status
  ///      self.fallbackContent = .string(error.localizedDescription, encoding: .utf8)
  ///    }
  ///  }
  ///
  ///  struct Error: CGIError {
  ///    var status: HTTPStatusCode = .notFound
  ///    var localizedDescription: String = "Not Found."
  ///  }
  ///
  ///  let responder = CGIResponder(content: .lazy({ throw Error() }))
  ///  var output = FileHandle.standardOutput
  ///  responder.respond(to: &output, fallback: { Fallback($0) })
  ///
  ///  /*
  ///   -- OUTPUT --
  ///   Status: 404 Not Found
  ///   Content-Type: text/plain; charset=utf-8
  ///
  ///   Not Found.
  ///   */
  /// ```
  public func respond<Respondee, Fallback>(
    to output: inout Respondee,
    ignoringError: (Error) -> Bool = defaultIgnoringError,
    fallback: (CGIError) -> Fallback
  ) where Respondee: CGIContentOutputStream, Fallback: CGIFallback {
    do {
      var temporaryOutput = try ({ () throws -> AnyFileHandle in
        switch self.content {
        case .none, .data, .string, .xhtml, .xml:
          return AnyFileHandle(InMemoryFile())
        default:
          return AnyFileHandle(try TemporaryFile())
        }
      })()
      
      try self.respond(to: &temporaryOutput, ignoringError: ignoringError)
      try temporaryOutput.seek(toOffset: 0)
      while let data = try temporaryOutput.read(upToCount: 1024), !data.isEmpty {
        try output.write(contentsOf: data)
      }
    } catch {
      let cgiError: CGIError = ({
        if case let error as CGIError = error {
          return error
        } else if case let error as LocalizedError = error {
          return _VersatileCGIError(localizedError: error)
        } else {
          return _VersatileCGIError(error: error)
        }
      })()
      let fallbackResponder: CGIResponder = ({
        let fallbackInstance = fallback(cgiError)
        if case let responder as CGIResponder = fallbackInstance {
          return responder
        } else {
          return CGIResponder(status: fallbackInstance.status,
                              content: fallbackInstance.fallbackContent)
        }
      })()
      try! fallbackResponder.respond(to: &output, ignoringError: { _ in true })
    }
  }
}
