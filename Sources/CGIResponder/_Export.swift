/* *************************************************************************************************
 _Export.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

// Exports types

import HTTP

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

/* Others */
public typealias ContentType = HTTP.MIMEType
public typealias HTTPETag = HTTP.ETag
public typealias HTTPStatusCode = HTTP.StatusCode
