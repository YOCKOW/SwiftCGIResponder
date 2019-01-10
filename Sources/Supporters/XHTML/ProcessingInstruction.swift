/* *************************************************************************************************
 ProcessingInstruction.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import HTTP

/// Represents the processing instruction.
/// Reference: [XML 1.0 (Fifth Edition) #2.6](https://www.w3.org/TR/REC-xml/#sec-pi)
public protocol ProcessingInstruction: Node {
  var target: NoncolonizedName { get }
  var content: String? { get }
}
extension ProcessingInstruction {
  public var xmlString: String {
    return "<?\(self.target.description) \(self.content ?? "")?>"
  }
}

public class AnyProcessingInstruction: ProcessingInstruction {
  public var target: NoncolonizedName
  public var content: String?
  public init(target:NoncolonizedName, content:String?) {
    self.target = target
    self.content = content
  }
}

/// Represents the processing instruction
/// such as "<\?xml-stylesheet type="text/css" href="style.css"?>"
open class XMLStyleSheet: ProcessingInstruction {
  public var type: MIMEType
  public var hypertextReference: String
  
  public var target: NoncolonizedName { return "xml-stylesheet" }
  public var content: String? {
    // TODO: Validate the string
    return "type=\"\(self.type.description)\" href=\"\(self.hypertextReference)\""
  }
  
  public init(type:MIMEType, hypertextReference:String) {
    self.type = type
    self.hypertextReference = hypertextReference
  }
}
