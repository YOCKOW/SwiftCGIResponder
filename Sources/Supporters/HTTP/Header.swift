/* *************************************************************************************************
 Header.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents HTTP Header.
/// Some header fields are contained.
public struct Header {
  private var _fieldTable: [HeaderFieldName:[HeaderField]]
  private init(_ fieldTable:[HeaderFieldName:[HeaderField]]) {
    self._fieldTable = fieldTable
  }
  
  /// Inserts new field.
  ///
  /// Fatal error will occur if any header fields whose name is the same with `newField` are already
  /// contained in the header and it is not "appendable" nor "duplicable".
  public mutating func insert(_ newField:HeaderField) {
    let name = newField.name
    if let _ = self._fieldTable[name] {
      if newField.isDuplicable {
        self._fieldTable[name]!.append(newField)
      } else if newField.isAppendable {
        self._fieldTable[name]![0]._delegate.append(elementsIn:newField._delegate)
      } else {
        fatalError("Header Field named \(name.rawValue) must be single.")
      }
    } else {
      self._fieldTable[name] = [newField]
    }
  }
  
  /// Initialize with fields.
  public init<S>(_ fields:S) where S: Sequence, S.Element == HeaderField {
    self.init([:])
    for field in fields {
      self.insert(field)
    }
  }
  
  public subscript(_ name:HeaderFieldName) -> [HeaderField] {
    get {
      return self._fieldTable[name] ?? []
    }
    set {
      self._fieldTable.removeValue(forKey:name)
      for field in newValue {
        self.insert(field)
      }
    }
  }
}

extension Header: CustomStringConvertible {
  public var description: String {
    var desc = ""
    for (name, fields) in self._fieldTable {
      for field in fields {
        desc += "\(name.rawValue): \(field.value.rawValue)\u{000D}\u{000A}"
      }
    }
    desc += "\u{000D}\u{000A}"
    return desc
  }
}
