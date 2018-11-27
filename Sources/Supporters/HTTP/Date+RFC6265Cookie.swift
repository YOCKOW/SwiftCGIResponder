/* *************************************************************************************************
 Date+RFC6265Cookie.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
import BonaFideCharacterSet

extension UnicodeScalarSet {
  fileprivate static let _cookieDateSeparator = UnicodeScalarSet(unicodeScalarsIn:"\u{0009}").union(
    UnicodeScalarSet(unicodeScalarsIn:UnicodeScalar(0x20)...UnicodeScalar(0x2F))
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:UnicodeScalar(0x3B)...UnicodeScalar(0x40))
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:UnicodeScalar(0x5B)...UnicodeScalar(0x60))
    ).union(
      UnicodeScalarSet(unicodeScalarsIn:UnicodeScalar(0x7B)...UnicodeScalar(0x7E))
    )
  
  fileprivate static let _numbers = UnicodeScalarSet(unicodeScalarsIn:UnicodeScalar(0x30)...UnicodeScalar(0x39))
}

private func _convert_year(_ string:String) -> Int? {
  var output = String.UnicodeScalarView()
  for scalar in string.unicodeScalars {
    guard UnicodeScalarSet._numbers.contains(scalar) else { break }
    output.append(scalar)
  }
  guard output.count >= 2 else { return nil }
  guard let result = Int(String(String.UnicodeScalarView(output))) else { return nil }
  switch result {
  case 0...69: return result + 2000
  case 70...99: return result + 1900
  default: break
  }
  guard result > 1600 else { return nil }
  return result
}

private func _convert_month(_ string:String) -> Int8? {
  guard string.unicodeScalars.count >= 3 else { return nil }
  let prefix = string[string.startIndex ..< string.index(string.startIndex, offsetBy:3)].lowercased()
  switch prefix {
  case "jan": return 1
  case "feb": return 2
  case "mar": return 3
  case "apr": return 4
  case "may": return 5
  case "jun": return 6
  case "jul": return 7
  case "aug": return 8
  case "sep": return 9
  case "oct": return 10
  case "nov": return 11
  case "dec": return 12
  default: return nil
  }
}

private func _convert_day(_ string:String) -> Int8? {
  var output = String.UnicodeScalarView()
  for scalar in string.unicodeScalars {
    guard UnicodeScalarSet._numbers.contains(scalar) else { break }
    output.append(scalar)
  }
  guard output.count >= 2 else { return nil }
  guard let result = Int8(String(String.UnicodeScalarView(output))), result > 0, result < 32 else { return nil }
  return result
}

private func _convert_time(_ string:String) -> (hour:Int8, minute:Int8, second:Int8)? {
  let components = string.components(separatedBy:":")
  guard components.count >= 3 else { return nil }
  guard let hour = Int8(components[0]), hour >= 0, hour < 24 else { return nil }
  guard let min = Int8(components[1]), min >= 0, min < 60 else { return nil }
  var secScalars = String.UnicodeScalarView()
  for scalar in components[2].unicodeScalars {
    guard UnicodeScalarSet._numbers.contains(scalar) else { break }
    secScalars.append(scalar)
  }
  guard secScalars.count >= 1 else { return nil }
  guard let sec = Int8(String(String.UnicodeScalarView(secScalars))), sec >= 0, sec <= 60 else { return nil }
  return (hour:hour, minute:min, second:sec)
}

extension Date {
  /// Initialize with "cookie-date" string.
  /// See [RFC 6265 #5.1.1](https://tools.ietf.org/html/rfc6265#section-5.1.1)
  public init?(cookieDateString string:String) {
    if let date = DateFormatter.rfc1123.date(from:string) {
      self.init(timeInterval:0, since:date)
    } else if let date = DateFormatter.traditionalHTTPCookie.date(from:string) {
      self.init(timeInterval:0, since:date)
    } else {
      let components = string.components(separatedBy:._cookieDateSeparator)
      
      var year: Int = 0
      var month: Int8 = 0
      var day: Int8 = 0
      var time: (hour:Int8, minute:Int8, second:Int8) = (hour:-1, minute:-1, second:-1)
      
      // parse
      for component in components {
        if time.hour < 0, let tt = _convert_time(component) {
          time = tt
        } else if day < 1, let dd = _convert_day(component) {
          day = dd
        } else if month < 1, let mm = _convert_month(component) {
          month = mm
        } else if year < 1, let yy = _convert_year(component) {
          year = yy
        }
      }
      
      guard year > 1600 && day >= 1 && day <= 31 && time.hour >= 0 && time.hour < 24 &&
        time.minute >= 0 && time.minute <= 59 && time.second >= 0 && time.second <= 60 else {
          return nil
      }
      
      let dateComponents = DateComponents(
        calendar:Calendar(identifier:.gregorian),
        timeZone:TimeZone(secondsFromGMT:0)!,
        year:year,
        month:Int(month),
        day:Int(day),
        hour:Int(time.hour),
        minute:Int(time.minute),
        second:Int(time.second)
      )
      
      guard let date = dateComponents.date else { return nil }
      self.init(timeInterval:0, since:date)
    }
  }
}


