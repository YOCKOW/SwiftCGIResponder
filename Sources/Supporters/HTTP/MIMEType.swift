/* *************************************************************************************************
 MIMEType.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import LibExtender

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

extension MIMEType: Hashable {
  public static func ==(lhs:MIMEType, rhs:MIMEType) -> Bool {
    return (
      lhs.type == rhs.type &&
      lhs.tree == rhs.tree &&
      lhs.subtype == rhs.subtype &&
      lhs.suffix == rhs.suffix &&
      lhs.parameters == rhs.parameters
    )
  }
  
  #if swift(>=4.2)
  public func hash(into hasher:inout Hasher) {
    hasher.combine(self.type)
    hasher.combine(self.tree)
    hasher.combine(self.subtype)
    hasher.combine(self.suffix)
    hasher.combine(self.parameters)
  }
  #else
  public var hashValue: Int {
    var hh = self.type.hashValue
    if let tree = self.tree { hh ^= tree.hashValue }
    hh ^= self.subtype.hashValue
    if let suffix = self.suffix { hh ^= suffix.hashValue }
    if let parameters = self.parameters {
      for (key,value) in parameters {
        hh ^= key.hashValue ^ value.hashValue
      }
    }
    return hh
  }
  #endif
}

extension MIMEType {
  /// Initialize with `string` such as "application/xhtml+xml; charset=UTF-8"
  ///
  /// - parameter string: must be `type "/" [tree "."] subtype ["+" suffix] *[";" parameter]`
  public init?(_ string:String) {
    let (type_s, tree_subtype_suffix_parameters_s_nilable) = string.splitOnce(separator:"/")
    
    guard let type = TopLevelType(rawValue:type_s.lowercased()) else { return nil }
    
    guard let tree_subtype_suffix_parameters_s = tree_subtype_suffix_parameters_s_nilable else {
      return nil
    }
    
    let (tree, subtype_suffix_parameters_s): (Tree?, Substring) = ({
      if let indexOfFirstDot = $0.firstIndex(of:".") {
        let tree_s = $0[$0.startIndex..<indexOfFirstDot]
        if let tree = Tree(rawValue:String(tree_s)) {
          return (tree, $0[$0.index(after:indexOfFirstDot)..<$0.endIndex])
        }
      }
      return (nil, $0)
    })(tree_subtype_suffix_parameters_s)
    
    let (subtype_suffix_s, parameters_s) = subtype_suffix_parameters_s.splitOnce(separator:";")
    
    let (subtype, suffix): (Substring, Suffix?) = ({
      if let indexOfLastPlus = $0.lastIndex(of:"+") {
        let suffix_s = $0[$0.index(after:indexOfLastPlus)..<$0.endIndex]
        if let suffix = Suffix(rawValue:String(suffix_s)) {
          return ($0[$0.startIndex..<indexOfLastPlus], suffix)
        }
      }
      return ($0, nil)
    })(subtype_suffix_s)
    
    let parameters:[String:String]? = parameters_s != nil ? Dictionary<String,String>(parsing:String(parameters_s!)) : nil
    
    self.init(type:type,
              tree:tree,
              subtype:String(subtype),
              suffix:suffix,
              parameters:parameters)
  }
}
