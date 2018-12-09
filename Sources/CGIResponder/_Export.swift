/* *************************************************************************************************
 _Export.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

// Exports types

import HTTP
import XHTML

/* ********************************************************************************************** */

/* Header */
public typealias HTTPHeader = HTTP.Header
public typealias HTTPHeaderField = HTTP.HeaderField
public typealias HTTPHeaderFieldDelegate = HTTP.HeaderFieldDelegate
public typealias HTTPHeaderFieldName = HTTP.HeaderFieldName
public typealias HTTPHeaderFieldValue = HTTP.HeaderFieldValue

/* Header Field Delegates */
public typealias HTTPContentTypeHeaderFieldDelegate = HTTP.ContentTypeHeaderFieldDelegate
public typealias HTTPETagHeaderFieldDelegate = HTTP.ETagHeaderFieldDelegate
public typealias HTTPIfMatchHeaderFieldDelegate = HTTP.IfMatchHeaderFieldDelegate
public typealias HTTPIfNoneMatchHeaderFieldDelegate = HTTP.IfNoneMatchHeaderFieldDelegate
public typealias HTTPLastModifiedHeaderFieldDelegate = HTTP.LastModifiedHeaderFieldDelegate

/* Protocols */
public typealias HTTPHeaderFieldValueConvertible = HTTP.HeaderFieldValueConvertible

/* XHTMLs */
public typealias XHTMLDocument = XHTML.Document
public typealias XHTMLVersion = XHTML.Version

/* Others */
public typealias ContentType = HTTP.MIMEType
public typealias HTTPContentDisposition = HTTP.ContentDisposition
public typealias HTTPContentTransferEncoding = HTTP.ContentTransferEncoding
public typealias HTTPCookieItem = HTTP.CookieItem
public typealias HTTPETag = HTTP.ETag
public typealias HTTPETagList = HTTP.ETagList
public typealias HTTPMethod = HTTP.Method
public typealias HTTPStatusCode = HTTP.StatusCode

/* ********************************************************************************************** */

extension HTTPHeaderFieldValueConvertible {
  public init?(httpHeaderFieldValue:HTTPHeaderFieldValue) {
    self.init(headerFieldValue:httpHeaderFieldValue)
  }
  
  public var httpHeaderFieldValue: HTTPHeaderFieldValue {
    return self.headerFieldValue
  }
}
