/* *************************************************************************************************
 DateFormatters.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation

extension DateFormatter {
  public static let rfc1123: DateFormatter = ({
    // e.g.) Sun, 06 Nov 1994 08:49:37 GMT
    var formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "EEE, dd MMM yyyy HH:mm:ss 'GMT'"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
  })()
  
  public static let traditionalHTTPCookie: DateFormatter = ({
    // e.g.) Fri, 24-Jan-2003 16:41:00 GMT
    var formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "EEE, dd-MMM-yyyy HH:mm:ss 'GMT'"
    formatter.timeZone = TimeZone(secondsFromGMT: 0)
    return formatter
  })()
}

