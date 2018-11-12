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
  
  public typealias Subtype = String
  
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
  
  public typealias Parameters = Dictionary<String, String>
  
  /// Holds properties of `MIMEType` except parameters.
  internal struct _Core: Hashable {
    internal var _type: TopLevelType
    
    internal var _tree: Tree?
    
    private var __subtype: Subtype = "octet-stream"
    internal var _subtype: Subtype {
      get { return self.__subtype }
      set {
         if newValue.isEmpty { fatalError("Subtype cannot be empty.") }
        guard newValue.consists(of:.mimeTypeTokenAllowed) else { fatalError("Invalid string for MIME Type.") }
        self.__subtype = newValue.lowercased()
      }
    }
    
    internal var _suffix: Suffix?
    
    internal init(type:TopLevelType, tree:Tree?, subtype:Subtype, suffix:Suffix?) {
      self._type = type
      self._tree = tree
      self._subtype = subtype
      self._suffix = suffix
    }
    
    internal static func ==(lhs:_Core, rhs:_Core) -> Bool {
      return (
        lhs._type == rhs._type &&
        lhs._tree == rhs._tree &&
        lhs._subtype == rhs._subtype &&
        lhs._suffix == rhs._suffix
      )
    }
    
    #if swift(>=4.2)
    public func hash(into hasher:inout Hasher) {
      hasher.combine(self._type)
      hasher.combine(self._tree)
      hasher.combine(self._subtype)
      hasher.combine(self._suffix)
    }
    #else
    public var hashValue: Int {
      var hh = self._type.hashValue
      if let tree = self._tree { hh ^= tree.hashValue }
      hh ^= self._subtype.hashValue
      if let suffix = self._suffix { hh ^= suffix.hashValue }
      return hh
    }
    #endif
  }
  
  internal var _core: _Core
  public var type: TopLevelType {
    get { return self._core._type }
    set { self._core._type = newValue }
  }
  public var tree: Tree? {
    get { return self._core._tree }
    set { self._core._tree = newValue }
  }
  public var subtype: String {
    get { return self._core._subtype }
    set { self._core._subtype = newValue }
  }
  public var suffix: Suffix? {
    get { return self._core._suffix }
    set { self._core._suffix = newValue }
  }
  
  internal var _parameters: Parameters?
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
  
  internal init?(core:_Core, parameters:Parameters?) {
    self._core = core
    self.parameters = parameters
  }
  
  /// Default initializer
  public init?(type:TopLevelType,
               tree:Tree? = nil,
               subtype:String,
               suffix:Suffix? = nil,
               parameters:[String:String]? = nil) {
    self.init(core:_Core(type:type, tree:tree, subtype:subtype, suffix:suffix),
              parameters:parameters)
  }
}

extension MIMEType: Hashable {
  public static func ==(lhs:MIMEType, rhs:MIMEType) -> Bool {
    return lhs._core == rhs._core && lhs._parameters == rhs._parameters
  }
  
  #if swift(>=4.2)
  public func hash(into hasher:inout Hasher) {
    hasher.combine(self._core)
    hasher.combine(self._parameters)
  }
  #else
  public var hashValue: Int {
    var hh = self._core.hashValue
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

extension MIMEType {
  /// Returns a set of possible path extensions for the MIME Type represented by the instance.
  public var possiblePathExtensions:Set<MIMEType.PathExtension>? {
    return _mimeType_to_ext[self._core]
  }
  
  /// Initialize with a path extension.
  public init?(pathExtension:MIMEType.PathExtension, parameters:[String:String]? = nil) {
    guard let core = _ext_to_mimeType[pathExtension] else { return nil }
    self.init(core:core, parameters:parameters)
  }
}
