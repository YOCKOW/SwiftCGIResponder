/* *************************************************************************************************
 Element.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
 
open class Element: Node {
  open var name: QualifiedName
  open var attributes: Attributes? = nil
  open var children: [Element] = []
  open weak var parent: Element? = nil
  
  public init(name:QualifiedName) {
    self.name = name
  }
  
  public var xhtmlString: String {
    var result = "<\(self.name.description) "
    
    if let attrs = self.attributes {
      result +=
        attrs.map { (name:AttributeName, value:String) -> String in
          return "\(name.description)=\"\(value._addingAmpersandEncoding())\""
        }.joined(separator:" ")
    }
    
    if self.children.isEmpty {
      result += " />"
    } else {
      result += ">"
      for child in self.children {
        result += child.xhtmlString
      }
      result += "</\(self.name.description)>"
    }
    
    return result
  }
}
