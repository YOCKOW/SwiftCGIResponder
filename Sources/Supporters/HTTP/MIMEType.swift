/* *************************************************************************************************
 MIMEType.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// # MIMEType
/// Represents MIME Type (a.k.a. media type and content type)
/// Reference: https://en.wikipedia.org/wiki/Media_type
///
/// ## Properties
/// - `type`: Top-level type name as `TopLevelType`
/// - `tree`: Registration tree as `Tree`; nil acceptable
/// - `subtype`: Sub-type name
/// - `suffix`: Suffix
/// - `parameters`: Companion data such as *charset=UTF-8*
public struct MIMEType {
  public enum TopLevelType: String {
    case application
    case audio
    case example
    case font
    case image
    case message
    case model
    case multipart
    case text
    case video
    case chemical
  }
  
  public enum Tree: String {
    case vnd
    case prs
    case x
  }
  
  public enum Suffix: String {
    case xml
    case json
    case ber
    case der
    case fastinfoset
    case wbxml
    case zip
    case cbor
  }
  
  public var type: TopLevelType = .application
  
  public var tree: Tree? = nil
  
  private var _subtype: String = "octet-stream"
  public var subtype: String {
    get {
      return self._subtype
    }
    set {
      if newValue.isEmpty { fatalError("Subtype cannot be empty.") }
      guard newValue.consists(of:.mimeTypeTokenAllowed) else { fatalError("Invalid string for MIME Type.") }
      self._subtype = newValue.lowercased()
    }
  }
  
  public var suffix: Suffix? = nil
  
  private var _parameters: [String:String]? = nil
  public var parameters: [String:String]? {
    get {
      return self._parameters
    }
    set {
      if let newParameters = newValue {
        for key in newParameters.keys {
          guard key.consists(of:.mimeTypeTokenAllowed) else { fatalError("Invalid key exists.") }
        }
      }
      self._parameters = newValue
    }
  }
  
  /// Default initializer
  public init?(type:TopLevelType,
               tree:Tree? = nil,
               subtype:String,
               suffix:Suffix? = nil,
               parameters:[String:String]? = nil) {
    self.type = type
    self.tree = tree
    self.subtype = subtype
    self.suffix = suffix
    self.parameters = parameters
  }
}
