/***************************************************************************************************
 HTTPHeaderField+DelegateSelector.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/// Select delegate automatically...
extension HTTPHeaderField {
  private static let specifiedFields: [HTTPHeaderFieldName:SpecifiedHTTPHeaderFieldDelegate.Type] = [
    .cacheControl:HTTPHeaderFieldDelegate.CacheControl.self,
    .contentDisposition:HTTPHeaderFieldDelegate.ContentDisposition.self,
    .contentLength:HTTPHeaderFieldDelegate.ContentLength.self,
    .contentTransferEncoding:HTTPHeaderFieldDelegate.ContentTransferEncoding.self,
    .contentType:HTTPHeaderFieldDelegate.ContentType.self,
    .eTag:HTTPHeaderFieldDelegate.ETag.self,
    .lastModified:HTTPHeaderFieldDelegate.LastModified.self,
    .setCookie:HTTPHeaderFieldDelegate.SetCookie<CGICookie>.self,
  ]
  
  /// Initialize from `name` and `value`
  /// An appropriate delegate will be chosen if `name` can specify its delegate.
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
    guard case let (nameString, valueString?) = string.splitOnce(separator:":") else { return nil }
    guard let name = HTTPHeaderFieldName(rawValue:String(nameString)),
          let value = HTTPHeaderFieldValue(rawValue:String(valueString).trimmingUnicodeScalars(in:.whitespacesAndNewlines)) else {
      return nil
    }
    self.init(name:name, value:value)
  }
}