/* *************************************************************************************************
 _Export.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

// Exports types

import HTTP
public typealias HTTPETag = HTTP.ETag
public typealias HTTPETagHeaderFieldDelegate = HTTP.HeaderFieldDelegate.ETag
public typealias HTTPIfMatchHeaderFieldDelegate = HTTP.HeaderFieldDelegate.IfMatch
public typealias HTTPIfNoneMatchHeaderFieldDelegate = HTTP.HeaderFieldDelegate.IfNoneMatch

public typealias HTTPHeaderField = HTTP.HeaderField
public typealias HTTPHeaderFieldDelegate = HTTP.HeaderFieldDelegate
public typealias HTTPHeaderFieldName = HTTP.HeaderFieldName
public typealias HTTPHeaderFieldValue = HTTP.HeaderFieldValue

public typealias HTTPStatusCode = HTTP.StatusCode
