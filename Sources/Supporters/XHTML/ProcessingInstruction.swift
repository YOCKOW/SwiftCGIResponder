/* *************************************************************************************************
 ProcessingInstruction.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
import HTTP

/// Represents the processing instruction.
/// Reference: [XML 1.0 (Fifth Edition) #2.6](https://www.w3.org/TR/REC-xml/#sec-pi)
open class ProcessingInstruction: Node {
  open var target: NoncolonizedName
  open var content: String?
  
  public init(target:NoncolonizedName, content:String?) {
    self.target = target
    self.content = content
  }
  
  open override var xhtmlString: String {
    return "<?\(self.target.description) \(self.content ?? "")?>"
  }
}

/// Represents the processing instruction
/// such as "<\?xml-stylesheet type="text/css" href="style.css"?>"
open class XMLStyleSheet: ProcessingInstruction {
  public var type: MIMEType
  public var hypertextReference: String
  
  open override var target: NoncolonizedName {
    get {
      return "xml-stylesheet"
    }
    set {
      // do nothing
    }
  }
  
  open override var content: String? {
    get {
      // TODO: Validate the string
      return "type=\"\(self.type.description)\" href=\"\(self.hypertextReference)\""
    }
    set {
      let pseudoElementString = "<element \(newValue ?? "") />"
      guard let element = try? XMLElement(xmlString:pseudoElementString) else {
        fatalError("Invalid string for the content of xml-stylesheet")
      }
      guard let type = element.attribute(forName:"type")?.stringValue.flatMap(MIMEType.init) else {
        fatalError("Invalid type.")
      }
      guard let href = element.attribute(forName:"href")?.stringValue else {
        fatalError("Invalid href.")
      }
      self.type = type
      self.hypertextReference = href
    }
  }
  
  public init(type:MIMEType, hypertextReference:String) {
    self.type = type
    self.hypertextReference = hypertextReference
    super.init(target:"xml-stylesheet", content:"")
  }
}
