/* *************************************************************************************************
 FormDataItem.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
/// Represents item of contents of "multipart/form-data"
public struct FormDataItem {
  /// Represents value of item.
  /// `content` may be expressed by `String` or `URL`, so its type is `CGIContent`.
  public struct Value {
    public var content: CGIContent
    public var filename: String?
    public var contentType: ContentType?
    public init(content:CGIContent, filename:String? = nil, contentType:ContentType? = nil) {
      self.content = content
      self.filename = filename
      self.contentType = contentType
    }
  }
  
  public var name: String
  public var value: Value
  public init(name:String, value:Value) {
    self.name = name
    self.value = value
  }
}

