/***************************************************************************************************
 HTTPHeader.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # HTTPHeader
 Represents for HTTP Header
 
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

//
//extension HTTPHeader {
//  public mutating func set(_ newField:HTTPHeaderField) {
//    self.fields = self.fields.filter { $0.name != newField.name }
//    self.fields.append(newField)
//  }
//
//  public mutating func append(_ newField:HTTPHeaderField) throws {
//    if !newField.isDuplicable {
//      for ii in 0..<self.fields.count {
//        if self.fields[ii].name == newField.name {
//          try self.fields[ii].append(newField)
//          return
//        }
//      }
//    }
//    self.fields.append(newField)
//  }
//
//  public func fields(forName name:HTTPHeaderFieldName) -> [HTTPHeaderField] {
//    let fields = self.fields.filter { $0.name == name }
//    return fields
//  }
//
//  public func field(forName name:HTTPHeaderFieldName) -> HTTPHeaderField? {
//    let fields = self.fields(forName:name)
//    guard fields.count > 0 else { return nil }
//    return fields[0]
//  }
//
//  public mutating func removeAll() {
//    self.fields.removeAll(keepingCapacity:true)
//  }
//}
//
//
//extension HTTPHeader: CustomStringConvertible {
//  public var description: String {
//    var desc = ""
//    for field in self.fields {
//      desc += field.description
//    }
//    return desc
//  }
//}
//
