/* *************************************************************************************************
 InputElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class InputElement: SpecifiedElement {
  open override class var localName: NoncolonizedName { return "input" }
  
  public enum TypeValue: String {
    case button
    case checkbox
    case color
    case date
    case dateAndTime = "datetime"
    case email
    case file
    case hidden
    case image
    case localDateAndTime = "datetime-local"
    case month
    case number
    case password
    case radio
    case range
    case reset
    case search
    case submit
    case telephone = "tel"
    case text
    case time
    case url
    case week
  }
  
  /// Always `true`.
  open override var isEmpty: Bool { return true }
  
  open var autocomplete: Bool {
    get {
      return self.attributes["autocomplete"] == "off" ? false : true
    }
    set {
      self.attributes["autocomplete"] = newValue ? "on" : "off"
    }
  }
  
  open var autofocus: Bool {
    get {
      return self.attributes["autofocus"] == "autofocus" ? true : false
    }
    set {
      self.attributes["autofocus"] = newValue ? "autofocus" : nil
    }
  }
  
  open var isChecked: Bool {
    get {
      return self.attributes["checked"] == "checked" ? true : false
    }
    set {
      self.attributes["checked"] = newValue ? "checked" : nil
    }
  }
  
  open var isDisabled: Bool {
    get {
      return self.attributes["disabled"] == "disabled" ? true : false
    }
    set {
      self.attributes["disabled"] = newValue ? "disabled" : nil
    }
  }
  
  open var isRequired: Bool {
    get {
      return self.attributes["required"] == "required" ? true : false
    }
    set {
      self.attributes["required"] = newValue ? "required" : nil
    }
  }
  
  open var nameAttribute: String? {
    get {
      return self.attributes["name"]
    }
    set {
      self.attributes["name"] = newValue
    }
  }
  
  open var type: TypeValue {
    get {
      guard let value = self.attributes["type"].flatMap(TypeValue.init(rawValue:)) else {
        fatalError("Unsupported type.")
      }
      return value
    }
    set {
      self.attributes["type"] = newValue.rawValue
    }
  }
  
  open var value: String? {
    get {
      return self.attributes["value"]
    }
    set {
      self.attributes["value"] = newValue
    }
  }
  
  public required init(name: QualifiedName, attributes:Attributes) {
    super.init(name:name)
    self.attributes = attributes
  }
  
  public convenience init(name:QualifiedName,
                          type:TypeValue,
                          nameAttribute:String?,
                          value:String?,
                          attributes:Attributes = [:])
  {
    self.init(name:name, attributes:attributes)
    self.type = type
    self.nameAttribute = nameAttribute
    self.value = value
  }
}
