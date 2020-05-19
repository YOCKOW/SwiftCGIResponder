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
  var status: HTTPStatusCode { get }
  var fallbackContent: CGIContent { get }
  init(error: CGIError)
}

public struct TextFallback: CGIFallback {
  public private(set) var status: HTTPStatusCode
  
  public private(set) var fallbackContent: CGIContent
  
  public init(error: CGIError) {
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
  
  public init(error: CGIError) {
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
