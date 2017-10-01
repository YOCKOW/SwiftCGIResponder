/***************************************************************************************************
 HTTPHeaderField+DelegateSelector.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/// Select delegate automatically...
extension HTTPHeaderField {
  private static let specifiedFields: [HTTPHeaderFieldName:SpecifiedHTTPHeaderFieldDelegate.Type] = [
    .contentLength:HTTPHeaderFieldDelegate.ContentLength.self
  ]
  public init?(name:HTTPHeaderFieldName, value:HTTPHeaderFieldValue) {
    if let metatype = HTTPHeaderField.specifiedFields[name] {
      guard let delegate = metatype.init(value:value) else { return nil }
      self.init(delegate:delegate)
    } else {
      self.init(delegate:UnspecifiedHTTPHeaderFieldDelegate(name:name, value:value)!)
    }
  }
}

extension HTTPHeaderField {
  /// Initialize HTTPHeaderField from `string`
  public init?(string:String) {
    let nameAndValue = string.split(separator:":", maxSplits:1, omittingEmptySubsequences:false)
    if nameAndValue.count != 2 { return nil }
    guard let name = HTTPHeaderFieldName(rawValue:String(nameAndValue[0])),
      let value = HTTPHeaderFieldValue(rawValue:String(nameAndValue[1]).trimmingCharacters(in:CharacterSet.whitespacesAndNewlines)) else {
        return nil
    }
    self.init(name:name, value:value)
  }
}
