/* *************************************************************************************************
 Parser.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

open class Parser: NSObject, XMLParserDelegate {
  public enum Error: Swift.Error {
    case xmlError(XMLParser.ErrorCode)
    case rootElementIsNotHTML
    case unexpectedError
  }
  
  private var _data: Data
  
  private var _error: Swift.Error? = nil
  
  private var _prolog: Document.Prolog
  private var _document: Document? = nil
  private var _processingElement: Element? = nil
  
  private init(_ data:Data) {
    self._data = data
    
    let xhtmlInfo = self._data.xhtmlInfo
    self._prolog = Document.Prolog(
      xmlVersion:xhtmlInfo.xmlVersion ?? "1.0",
      stringEncoding:xhtmlInfo.stringEncoding ?? .utf8,
      version:xhtmlInfo.version ?? .latest,
      miscellanies: []
    )
  }
  
  public static func parse(_ data:Data) throws -> Document {
    let xmlParser = XMLParser(data:data)
    let delegate = Parser(data)
    xmlParser.delegate = delegate
    if !xmlParser.parse() {
      if let error = delegate._error { throw error }
      if let error = xmlParser.parserError { throw error }
      throw Error.unexpectedError
    }
    guard let document = delegate._document else { throw Error.unexpectedError }
    return document
  }
  
  /// `node` must be `Comment` or `ProcessingInstruction`.
  private func _appendMiscellany(_ node:Node) {
    if let document = self._document {
      if let element = self._processingElement {
        element.append(node)
      } else {
        document.miscellanies.append(Miscellany(node)!)
      }
    } else {
      self._prolog.miscellanies.append(Miscellany(node)!)
    }
  }
  
  ///// As `XMLParserDelegate` /////
  
  public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
    self._error = parseError
    parser.abortParsing()
  }
  
  public func parserDidStartDocument(_ parser: XMLParser) {
    precondition(self._document == nil)
  }
  
  public func parser(_ parser: XMLParser, foundComment comment: String) {
    guard let commentNode = Comment(comment) else {
      self.parser(parser, parseErrorOccurred:Error.xmlError(.invalidCharacterError))
      return
    }
    self._appendMiscellany(commentNode)
  }
  
  public func parser(_ parser: XMLParser,
                     foundProcessingInstructionWithTarget target: String,
                     data: String?
  ) {
    guard let targetName = NoncolonizedName(target) else {
      self.parser(parser, parseErrorOccurred:Error.xmlError(.invalidCharacterError))
      return
    }
    
    let pi = ProcessingInstruction(target:targetName, content:data)
    self._appendMiscellany(pi)
  }
  
  public func parser(_ parser: XMLParser,
                     didStartElement elementName: String,
                     namespaceURI: String?,
                     qualifiedName qName: String?,
                     attributes attributeDict: [String : String] = [:])
  {
    guard let tagName = QualifiedName(elementName) else {
      self.parser(parser, parseErrorOccurred:Error.xmlError(.invalidCharacterError))
      return
    }
    let attributes = Attributes(attributeDict)
    let element = Element(name:tagName, attributes:attributes, parent:self._processingElement)
    
    if element is HTMLElement {
      precondition(self._document == nil && self._processingElement == nil,
                   "html element must be the only root element of XHTML.")
      self._document = Document(prolog:self._prolog, rootElement:element as! HTMLElement)
      self._processingElement = element
    } else {
      guard let processingElement = self._processingElement else {
        self.parser(parser, parseErrorOccurred:Error.rootElementIsNotHTML)
        return
      }
      processingElement.append(element)
      self._processingElement = element
    }
  }
  
  public func parser(_ parser: XMLParser,
              didEndElement elementName: String,
              namespaceURI: String?,
              qualifiedName qName: String?)
  {
    guard let tagName = QualifiedName(elementName) else {
      self.parser(parser, parseErrorOccurred:Error.xmlError(.invalidCharacterError))
      return
    }
    
    guard self._processingElement?.name == tagName else {
      self.parser(parser, parseErrorOccurred:Error.xmlError(.tagNameMismatchError))
      return
    }
    
    self._processingElement = self._processingElement?.parent
  }
  
  public func parser(_ parser: XMLParser, foundCharacters string: String) {
    let textNode = Text(string.trimmingUnicodeScalars(in:.xmlWhitespaces))
    if let processingElement = self._processingElement {
      processingElement.append(textNode)
    } else {
      guard textNode.text.isEmpty else {
        self.parser(parser, parseErrorOccurred:Error.xmlError(.invalidCharacterError))
        return
      }
    }
  }
}
