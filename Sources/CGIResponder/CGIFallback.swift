/* *************************************************************************************************
 CGIFallback.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import NetworkGear
import XHTML

/// Container of fallback response.
public protocol CGIFallback {
  /// HTTP Status that should be 4xx, or 5xx.
  var status: HTTPStatusCode { get }
  
  /// A content to report the error.
  var fallbackContent: CGIContent { get }
}

public struct TextFallback: CGIFallback {
  public private(set) var status: HTTPStatusCode
  
  public private(set) var fallbackContent: CGIContent
  
  public init(_ error: CGIError) {
    let message = """
    Error \(error.status.rawValue): \(error.status.reasonPhrase)
    
    \(error.localizedDescription)
    """
    
    self.status = error.status
    self.fallbackContent = .string(message, encoding: .utf8)
  }
}

public struct XHTMLFallback: CGIFallback {
  public private(set) var status: HTTPStatusCode
  
  public private(set) var fallbackContent: CGIContent
  
  public init(_ error: CGIError) {
    let title = "Error \(error.status.rawValue): \(error.status.reasonPhrase)"
    let xhtml = XHTMLDocument.template(
      title: title,
      contents: [
        .h1(text: title),
        .div(children: [.text(error.localizedDescription)])
      ]
    )
    
    self.status = error.status
    self.fallbackContent = .xhtml(xhtml)
  }
}

extension CGIResponder: CGIFallback {
  public var fallbackContent: CGIContent {
    return self.content
  }
}
