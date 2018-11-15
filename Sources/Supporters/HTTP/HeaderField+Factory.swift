/* *************************************************************************************************
 HeaderField+Factory.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
extension HeaderField {
  private static func _create<D>(_ delegate:D) -> HeaderField where D:HeaderFieldDelegate {
    return HeaderField(delegate:delegate)
  }
  private static func _create<D>(_ delegate:D) -> HeaderField where D:AppendableHeaderFieldDelegate {
    return HeaderField(delegate:delegate)
  }
  
  
  /// Creates the HTTP header field of "Content-Type"
  public static func contentType(_ contentType:MIMEType) -> HeaderField {
    return ._create(ContentTypeHeaderFieldDelegate(contentType))
  }
  
  /// Creates the HTTP header field of "ETag"
  public static func eTag(_ eTag:ETag) -> HeaderField {
    return ._create(ETagHeaderFieldDelegate(eTag))
  }
  
  /// Creates the HTTP header field of "If-Match"
  public static func ifMatch(_ eTags:[ETag]) -> HeaderField {
    return ._create(IfMatchHeaderFieldDelegate(eTags))
  }
  
  /// Creates the HTTP header field of "If-None-Match"
  public static func ifNoneMatch(_ eTags:[ETag]) -> HeaderField {
    return ._create(IfMatchHeaderFieldDelegate(eTags))
  }
}

