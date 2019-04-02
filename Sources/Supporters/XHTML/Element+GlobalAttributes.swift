/* *************************************************************************************************
 Element+GlobalAttributes.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
extension Element {
  /// Accessor to global attributes.
  public final class GlobalAttributes {
    private unowned let _element: Element
    fileprivate init(_ element:Element) { self._element = element }
    
    fileprivate subscript(_ localName:NoncolonizedName) -> String? {
      get { return self._element.attributes[localName:localName, uri:._xhtmlNamespace] }
      set { self._element.attributes[localName:localName, uri:._xhtmlNamespace] = newValue }
    }
  }

  /// HTML Global Attrbutes
  public var globalAttributes: GlobalAttributes { return .init(self) }
}

extension Element.GlobalAttributes {
  /// A keyboard shortcut for the element.
  public var accessKey: String? {
    get {
      return self["accesskey"]
    }
    set {
      self["accesskey"] = newValue
    }
  }

  /// One or more classnames for the element
  public var `class`: [String]? {
    get {
      guard let classes_string = self["class"] else { return nil }
      return classes_string.split(separator:.whitespacesAndNewlines, omittingEmptySubsequences:true)
    }
    set {
      if let classes = newValue {
        self["class"] = classes.joined(separator:" ")
      } else {
        self["class"] = nil
      }
    }
  }

  /// The Boolean value that specifies whether the content of the element is editable or not.
  /// This property is `nil` if the attribute value is "inherit" or doesn't exist.
  public var contentEditable: Bool? {
    get {
      guard let value = self["contenteditable"]?.lowercased() else { return nil }
      if value == "inherit" { return nil }
      if value.isEmpty || value == "true" { return true }
      if value == "false" { return false }
      preconditionFailure("Invalid value for `contenteditable`")
    }
    set {
      guard let value = newValue else { self["contenteditable"] = nil; return }
      self["contenteditable"] = value ? "true" : "false"
    }
  }

  /// The text direction
  public enum Direction: String {
    case leftToRight = "ltr"
    case rightToLeft = "rtl"
    case auto = "auto"
  }
  /// The text direction for the content in the element.
  public var direction: Direction? {
    get {
      guard let value = self["dir"] else { return nil }
      guard let direction = Direction(rawValue:value) else { return nil }
      return direction
    }
    set {
      guard let direction_string = newValue?.rawValue else { self["dir"] = nil; return }
      self["dir"] = direction_string
    }
  }
  
  /// The Boolean value that indicates whether the element is draggable or not.
  public var draggable: Bool? {
    get {
      guard let value = self["draggable"]?.lowercased() else { return nil }
      if value == "true" { return true }
      if value == "false" { return false }
      return nil
    }
    set {
      guard let value = newValue else { self["draggable"] = nil; return }
      self["draggable"] = value ? "true" : "false"
    }
  }
  
  /// Attribute value of "dropzone"
  public enum DropZone: String {
    case copy = "copy"
    case move = "move"
    case link = "link"
  }
  /// The value that specifis whether the dragged data is
  /// copied, moved, or linked, when it is dropped on the element.
  public var dropZone: DropZone? {
    get {
      return self["dropzone"].flatMap(DropZone.init(rawValue:))
    }
    set {
      self["dropzone"] = newValue?.rawValue
    }
  }
  
  public var hidden: Bool {
    get {
      guard let _ = self["hidden"] else { return false }
      return true
    }
    set {
      self["hidden"] = newValue ? "hidden" : nil
    }
  }
  
  public var identifier: String? {
    get {
      return self["id"]
    }
    set {
      self["id"] = newValue
    }
  }

  public var language: String? {
    get {
      return self["lang"]
    }
    set {
      self["lang"] = newValue
    }
  }

  public var spellCheck: Bool? {
    get {
      guard let value = self["spellcheck"]?.lowercased() else { return nil }
      if value.isEmpty || value == "true" { return true }
      if value == "false" { return false }
      fatalError("Invalid value for `spellcheck`")
    }
    set {
      guard let value = newValue else { self["spellcheck"] = nil; return }
      self["spellcheck"] = value ? "true" : "false"
    }
  }

  public var style: String? {
    get {
      return self["style"]
    }
    set {
      self["style"] = newValue
    }
  }
  
  /// The tabbing order of the element
  public var tabIndex: Int? {
    get {
      return self["tabindex"].flatMap(Int.init)
    }
    set {
      self["tabindex"] =  newValue.flatMap(String.init)
    }
  }

  /// Extra information about the element
  public var title: String? {
    get {
      return self["title"]
    }
    set {
      self["title"] = newValue
    }
  }

  /// The Boolean value that indicates whether the content of the element should be translated or not.
  public var translate: Bool? {
    get {
      guard let value = self["translate"]?.lowercased() else { return nil }
      if value.isEmpty || value == "yes" { return true }
      if value == "no" { return false }
      fatalError("Invalid value for `translate`")
    }
    set {
      guard let value = newValue else { self["translate"] = nil; return }
      self["translate"] = value ? "yes" : "no"
    }
  }
}

extension Element.GlobalAttributes {
  /// Accessor to "data-*"
  public final class DataSet {
    private unowned let _element: Element
    fileprivate init(_ element:Element) { self._element = element }
    
    private func _convert(name:String) -> String? {
      if name.isEmpty { return nil }
      
      let input = name.unicodeScalars
      var output = "data-".unicodeScalars
      
      var index = input.startIndex
      while true {
        if index == input.endIndex { break }
        defer { index = input.index(after:index) }
        
        var scalar = input[index]
        if scalar == "-" {
          if index > input.startIndex {
            let prevIndex = input.index(before:index)
            if input[prevIndex].value >= 0x61 && input[prevIndex].value <= 0x7A { return nil }
          }
        } else if scalar.value >= 0x41 && scalar.value <= 0x5A {
          output.append("-")
          scalar = Unicode.Scalar(scalar.value + 0x20)!
        }
        output.append(scalar)
      }
      
      return String(output)
    }
    
    private func _attributeName(for string:String) -> AttributeName? {
      return _convert(name:string).flatMap(AttributeName.init)
    }
    
    /// The value of "data-*".
    /// The attribute name will be "data-abc-def" when `key` is "abcDef".
    public subscript(_ key:String) -> String? {
      get {
        guard let attrName = self._attributeName(for:key) else { return nil }
        return self._element.attributes[attrName]
      }
      set {
        guard let attrName = self._attributeName(for:key) else { return }
        self._element.attributes[attrName] = newValue
      }
    }
  }
  
  /// The instance of `DataSet`.
  public var dataSet: DataSet {
    return DataSet(self._element)
  }
}
