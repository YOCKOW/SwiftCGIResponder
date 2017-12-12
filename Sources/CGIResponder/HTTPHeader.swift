/***************************************************************************************************
 HTTPHeader.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # HTTPHeader
 Represents HTTP Header
 
 === HTTPHeader ===
 +-----------------++---------------------+----------------------+
 | HTTPHeaderField || HTTPHeaderFieldName | HTTPHeaderFieldValue |
 +-----------------++---------------------+----------------------+
 | HTTPHeaderField || HTTPHeaderFieldName | HTTPHeaderFieldValue |
 +-----------------++---------------------+----------------------+
 | HTTPHeaderField || HTTPHeaderFieldName | HTTPHeaderFieldValue |
 +-----------------++---------------------+----------------------+
 :                 ::                     :                      :
 
 */

public struct HTTPHeader {
  public fileprivate(set) var fields: [HTTPHeaderField]
  public init(fields:[HTTPHeaderField]) { self.fields = fields }
}

extension HTTPHeader {
  public mutating func append(_ newField:HTTPHeaderField) throws {
    if !newField.isDuplicable {
      for ii in 0..<self.fields.count {
        if self.fields[ii].name == newField.name {
          try self.fields[ii].append(newField.value)
          return
        }
      }
    }
    self.fields.append(newField)
  }
  
  public mutating func set(_ newField:HTTPHeaderField) {
    self.fields = self.fields.filter { $0.name != newField.name }
    self.fields.append(newField)
  }
  
  public func fields(forName name:HTTPHeaderFieldName) -> [HTTPHeaderField] {
    return self.fields.filter { $0.name == name }
  }
  
  public mutating func removeAll() {
    self.fields.removeAll(keepingCapacity:true)
  }
}

extension HTTPHeader: CustomStringConvertible {
  public var description: String {
    var desc = ""
    for field in self.fields {
      desc += field.description
    }
    return desc
  }
}
