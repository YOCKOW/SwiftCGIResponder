/***************************************************************************************************
 MIMEType.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
 
import Foundation

/**
 
 # MIMEType
 Represents MIME Type (a.k.a. media type and content type)
 Reference: https://en.wikipedia.org/wiki/Media_type
 
 ## Properties
 `type` Top-level type name as `TopLevelType`
 `tree` Registration tree as `Tree`; nil acceptable
 `subtype` Sub-type name
 `suffix` Suffix
 `parameters` Companion data such as *charset=UTF-8*
 
 */

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
  
  public var type : TopLevelType = .application
  public var tree : Tree? = nil
  public var subtype : String = "octet-stream"
  public var suffix : Suffix? = nil
  public var parameters : [String:String]? = nil
  
  /**
   
   Initializer
   fails if there is an inappropriate argument
   
   */
  public init?(type:TopLevelType,
               tree:Tree? = nil,
               subtype:String,
               suffix:Suffix? = nil,
               parameters:[String:String]? = nil) {
    if subtype.isEmpty || !subtype.consists(of:.mimeTypeTokenAllowed) { return nil }
    self.type = type
    self.tree = tree
    self.subtype = subtype.lowercased()
    self.suffix = suffix
    if parameters != nil {
      for key in parameters!.keys {
        guard key.consists(of:.mimeTypeTokenAllowed) else { return nil }
      }
    }
    self.parameters = parameters
  }
  
  /**
   
   Initialize from string such as "application/xhtml+xml; charset=UTF-8"
   
   */
  public init?(_ string:String) {
    let typeTreeSubtypeSuffixString: String
    let parametersString: String?
    
    if case let (tt, pp?) = string.splitOnce(separator:";") {
      typeTreeSubtypeSuffixString = String(tt).trimmingUnicodeScalars(in:.whitespaces)
      parametersString = String(pp).trimmingUnicodeScalars(in:.whitespaces)
    } else {
      typeTreeSubtypeSuffixString = string.trimmingUnicodeScalars(in:.whitespaces)
      parametersString = nil
    }
    
    // Split string into `type`, `tree`, `subtype`, and `suffix`
    guard case let (tp, ts?) = typeTreeSubtypeSuffixString.splitOnce(separator:"/") else { return nil }
    guard let type = TopLevelType(rawValue:String(tp).lowercased()) else { return nil }
    let treeSubtypeSuffixString = String(ts)
    
    //// tree?
    var tree: Tree? = nil
    var subtypeSuffixString: String = ""
    if case let (tr, ss?) = treeSubtypeSuffixString.splitOnce(separator:".") {
      tree = Tree(rawValue:String(tr).lowercased())
      if tree != nil { subtypeSuffixString = String(ss) }
    }
    if tree == nil { subtypeSuffixString = treeSubtypeSuffixString }
    if subtypeSuffixString.isEmpty { return nil }
    
    //// suffix?
    var suffix: Suffix? = nil
    var subtype: String = ""
    if let indexOfPlus = subtypeSuffixString.lastIndex(of:"+") {
      let suffixString = subtypeSuffixString[subtypeSuffixString.index(after:indexOfPlus)..<subtypeSuffixString.endIndex]
      suffix = Suffix(rawValue:suffixString.lowercased())
      if suffix != nil { subtype = String(subtypeSuffixString[subtypeSuffixString.startIndex..<indexOfPlus]) }
    }
    if suffix == nil { subtype = subtypeSuffixString }
    if subtype.isEmpty { return nil }
    
    // Parse parameters
    let parameters: [String:String]?
    if parametersString == nil {
      parameters = nil
    } else {
      parameters = try? Dictionary<String, String>(keyValuePairs:parametersString!,
                                                   allowedUnquotedCharacters:.mimeTypeTokenAllowed)
      
      guard parameters != nil else { return nil }
    }
    
    self.init(type:type, tree:tree, subtype:subtype, suffix:suffix, parameters:parameters)
  }
}

extension MIMEType: CustomStringConvertible {
  public var description : String {
    var desc : String = "\(self.type.rawValue)/"
    if self.tree != nil { desc += "\(self.tree!.rawValue)." }
    desc += self.subtype
    if self.suffix != nil { desc += "+\(self.suffix!.rawValue)" }
    if let parameters = self.parameters {
      for (key, value) in parameters {
        desc += "; \(key)="
        if value.consists(of:.mimeTypeTokenAllowed) {
          desc += value
        } else {
          let escapedValue = value.replacingOccurrences(of:"\\", with:"\\\\").replacingOccurrences(of:"\"", with:"\\\"")
          desc += "\"\(escapedValue)\""
        }
      }
    }
    return desc
  }
}

extension MIMEType: Hashable {
  public var hashValue: Int {
    var hh = self.type.hashValue
    if let tree = self.tree { hh &= tree.hashValue << 8 }
    if let suffix = self.suffix { hh &= suffix.hashValue << 16 }
    if let params = self.parameters { hh ^= params.hashValue }
    hh ^= self.subtype.hashValue
    return hh
  }
  
  public static func ==(lhs:MIMEType, rhs:MIMEType) -> Bool {
    if lhs.type != rhs.type { return false }
    
    if let ltree = lhs.tree, let rtree = rhs.tree {
      if ltree != rtree { return false }
    } else {
      guard lhs.tree == nil && rhs.tree == nil else { return false }
    }
    
    if lhs.subtype.lowercased() != rhs.subtype.lowercased() { return false }
    
    if let lsuffix = lhs.suffix, let rsuffix = rhs.suffix {
      if lsuffix != rsuffix { return false }
    } else {
      guard lhs.suffix == nil && rhs.suffix == nil else { return false }
    }
    
    if let lparameters = lhs.parameters, let rparameters = rhs.parameters {
      if lparameters != rparameters { return false }
    } else {
      guard lhs.parameters == nil && rhs.parameters == nil else { return false }
    }
    
    return true
  }
}
