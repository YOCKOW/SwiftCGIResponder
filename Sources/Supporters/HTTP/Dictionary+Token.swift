/* *************************************************************************************************
 Dictionary+Token.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

private enum _Processing {
  case key, kvsep, value, pairsep
}
 
extension Dictionary where Key == String, Value == String {
  internal init?<S>(_tokens:S,
                    keyAndValueAreSeparatedBy kvSeparator:String = "=",
                    pairsAreSeparatedBy pairSeparator:String = ";")
    where S: Sequence, S.Element: _Token
  {
    self.init()
    
    var processing: _Processing = .key
    var nilableKey: String? = nil
    for token in _tokens {
      switch processing {
      case .key:
        if token is _Token._Separator && token._string == pairSeparator { continue }
        guard token is _Token._QuotedString || token is _Token._RawString else { return nil }
        nilableKey = token._string
        processing = .kvsep
      case .kvsep:
        guard let key = nilableKey else { fatalError("No key.") }
        switch token {
        case is _Token._Separator where token._string == kvSeparator:
          processing = .value
        case is _Token._Separator where token._string == pairSeparator:
          self[key] = ""
          processing = .key
          nilableKey = nil
        default:
          return nil
        }
      case .value:
        guard let key = nilableKey else { fatalError("No key.") }
        switch token {
        case is _Token._QuotedString, is _Token._RawString:
          self[key] = token._string
          processing = .pairsep
          nilableKey = nil
        case is _Token._Separator where token._string == pairSeparator:
          self[key] = ""
          processing = .key
          nilableKey = nil
        default:
          return nil
        }
      case .pairsep:
        guard token is _Token._Separator, token._string == pairSeparator else {
          fatalError("Expected Pair Separator.")
        }
        processing = .key
      }
    }
    
    if let key = nilableKey {
      self[key] = ""
    }
  }
}
