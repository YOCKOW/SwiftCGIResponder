/* *************************************************************************************************
 Parser.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

extension Element {
  fileprivate func _trimTexts() -> Void {
    for child in self.children {
      switch child {
      case let text as Text:
        text.text = text.text.trimmingUnicodeScalars(in:.xmlWhitespaces)
      case let element as Element:
        element._trimTexts()
      default:
        break
      }
    }
  }
}

open class Parser: NSObject, XMLParserDelegate {
  public enum Error: Swift.Error, Equatable {
    case xmlError(XMLParser.ErrorCode)
    case rootElementIsNotHTML
    // case duplicatedRootElement // Parser Fails
    // case misplacedCDATA // Parser Fails
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
    guard let document = delegate._document else {
      if let error = delegate._error {
        throw error
      }
      throw Error.unexpectedError
    }
    document.rootElement._trimTexts()
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
  
  /// The parser encounters a fatal error.
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
//      guard self._document == nil && self._processingElement == nil else {
//        self.parser(parser, parseErrorOccurred:Error.duplicatedRootElement)
//        return
//      }
      
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
    if let processingElement = self._processingElement {
      if case let lastChild as Text = processingElement.children.last {
        lastChild.text += string
      } else {
        processingElement.append(Text(string))
      }
    } else {
      guard string.consists(of:.xmlWhitespaces) else {
        self.parser(parser, parseErrorOccurred:Error.xmlError(.invalidCharacterError))
        return
      }
    }
  }
  
  public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
    guard
      let cdata = String(data:CDATABlock, encoding:.utf8),
      let section = CDATASection(cdata)
    else
    {
      self.parser(parser, parseErrorOccurred:Error.xmlError(.invalidCharacterError))
      return
    }
    
    guard let processingElement = self._processingElement else {
      // self.parser(parser, parseErrorOccurred:Error.misplacedCDATA)
      return
    }
    
    processingElement.append(section)
  }
}
