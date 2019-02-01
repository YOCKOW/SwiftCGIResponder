/* *************************************************************************************************
 AnchorElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<a> element.
open class AnchorElement: SpecifiedElement {
  open override class var localName: NoncolonizedName { return "a" }
  open override var isEmpty: Bool { return false }
  
  open var hypertextReference: String? {
    get {
      return self.attributes["href"]
    }
    set {
      self.attributes["href"] = newValue
    }
  }
  
  public required init(name: QualifiedName, attributes: Attributes) {
    super.init(name:name)
    self.attributes = attributes
  }
  
  public convenience init(name:QualifiedName,
                          hypertextReference:String,
                          text:String,
                          attributes:Attributes = [:])
  {
    self.init(name:name, attributes:attributes)
    self.hypertextReference = hypertextReference
    self.append(Text(text))
  }
}
