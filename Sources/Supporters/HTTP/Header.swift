/* *************************************************************************************************
 Header.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents HTTP Header.
/// Some header fields are contained.
public struct Header {
  private var _fields: [HeaderField]
  
  private mutating func _normalize() {
    var organized = Dictionary<HeaderFieldName,[HeaderField]>(minimumCapacity:self._fields.count)
    
    for field in self._fields {
      let name = field.name
      if organized[name] == nil { organized[name] = [] }
      organized[name]!.append(field)
    }
    
    var normalized:[HeaderField] = []
    
    for name in organized.keys {
      let fields = organized[name]!
      if fields[0].isAppendable {
        var field = fields[0]
        for ii in 1..<fields.count {
          field._delegate.appen(elementsIn:fields[ii]._delegate)
        }
        normalized.append(field)
      } else if fields[0].isDuplicable {
        normalized.append(contentsOf:fields)
      } else {
        guard fields.count == 1 else {
          fatalError("Header Field named \(name) must be single.")
        }
        normalized.append(fields[0])
      }
    }
    
    self._fields = normalized
  }
  
  public var fields: [HeaderField] {
    get { return self._fields }
    set {
      self._fields = newValue
      self._normalize()
    }
  }
  
  /// Initialize with fields.
  public init<S>(_ fields:S) where S: Sequence, S.Element == HeaderField {
    self._fields = Array<HeaderField>(fields)
    self._normalize()
  }
}

