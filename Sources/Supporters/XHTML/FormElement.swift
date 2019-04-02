/* *************************************************************************************************
 FormElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import HTTP
import yExtensions

open class FormElement: SpecifiedElement {
  open override class var localName: NoncolonizedName { return "form" }
  
  /// The location where to submit the form.
  open var action: String? {
    get {
      return self.attributes["action"]
    }
    set {
      self.attributes["action"] = newValue
    }
  }
  
  open var autocomplete: Bool {
    get {
      return self.attributes["autocomplete"] == "off" ? false : true
    }
    set {
      self.attributes["autocomplete"] = newValue ? "on" : "off"
    }
  }
  
  /// The value of "enctype"
  open var encodingType: MIMEType? {
    get {
      return self.attributes["enctype"].flatMap(MIMEType.init)
    }
    set {
      self.attributes["enctype"] = newValue?.description
    }
  }
  
  /// The HTTP method used when submitting the form
  open var method: HTTP.Method? {
    get {
      return self.attributes["method"].flatMap(Method.init(rawValue:))
    }
    set {
      self.attributes["method"] = newValue?.rawValue
    }
  }
  
  /// The value of "accept-charset"
  open var stringEncoding: String.Encoding? {
    get {
      return self.attributes["accept-charset"].flatMap(String.Encoding.init(ianaCharacterSetName:))
    }
    set {
      self.attributes["accept-charset"] = newValue?.ianaCharacterSetName
    }
  }
}
