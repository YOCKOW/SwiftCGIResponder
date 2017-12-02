/***************************************************************************************************
 HTTPMethod.swift
   This file was created automatically
   from https://www.iana.org/assignments/http-methods/methods.csv
   at 2017-12-02T09:57:48+09:00
 **************************************************************************************************/

public enum HTTPMethod: String {
  case acl = "ACL"
  case baselineControl = "BASELINE-CONTROL"
  case bind = "BIND"
  case checkin = "CHECKIN"
  case checkout = "CHECKOUT"
  case connect = "CONNECT"
  case copy = "COPY"
  case delete = "DELETE"
  case get = "GET"
  case head = "HEAD"
  case label = "LABEL"
  case link = "LINK"
  case lock = "LOCK"
  case merge = "MERGE"
  case mkactivity = "MKACTIVITY"
  case mkcalendar = "MKCALENDAR"
  case mkcol = "MKCOL"
  case mkredirectref = "MKREDIRECTREF"
  case mkworkspace = "MKWORKSPACE"
  case move = "MOVE"
  case options = "OPTIONS"
  case orderpatch = "ORDERPATCH"
  case patch = "PATCH"
  case post = "POST"
  case pri = "PRI"
  case propfind = "PROPFIND"
  case proppatch = "PROPPATCH"
  case put = "PUT"
  case rebind = "REBIND"
  case report = "REPORT"
  case search = "SEARCH"
  case trace = "TRACE"
  case unbind = "UNBIND"
  case uncheckout = "UNCHECKOUT"
  case unlink = "UNLINK"
  case unlock = "UNLOCK"
  case update = "UPDATE"
  case updateredirectref = "UPDATEREDIRECTREF"
  case versionControl = "VERSION-CONTROL"
}
