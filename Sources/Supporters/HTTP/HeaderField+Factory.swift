/* *************************************************************************************************
 HeaderField+Factory.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

extension HeaderField {
  private static func _create<D>(_ delegate:D) -> HeaderField where D:HeaderFieldDelegate {
    return HeaderField(delegate:delegate)
  }
  private static func _create<D>(_ delegate:D) -> HeaderField where D:AppendableHeaderFieldDelegate {
    return HeaderField(delegate:delegate)
  }
  
  public static func cacheControl(_ directives:CacheControlDirectiveSet) -> HeaderField {
    return ._create(CacheControlHeaderFieldDelegate(directives))
  }
  
  /// Creates the HTTP header field of "Content-Length"
  public static func contentLength(_ length:UInt) -> HeaderField {
    return ._create(ContentLengthHeaderFieldDelegate(length))
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
  public static func ifMatch(_ list:ETagList) -> HeaderField {
    return ._create(IfMatchHeaderFieldDelegate(list))
  }
  
  /// Creates the HTTP header field of "If-None-Match"
  public static func ifNoneMatch(_ list:ETagList) -> HeaderField {
    return ._create(IfNoneMatchHeaderFieldDelegate(list))
  }
  
  public static func lastModified(_ date:Date) -> HeaderField {
    return ._create(LastModifiedHeaderFieldDelegate(date))
  }
  
  public static func setCookie<C>(_ cookie:C) -> HeaderField where C:RFC6265Cookie {
    return ._create(SetCookieHeaderFieldDelegate(cookie:cookie))
  }
}

