/***************************************************************************************************
 ContentDispositionValue.swift
   This file was created automatically
   from https://www.iana.org/assignments/cont-disp/cont-disp-1.csv
   at 2017-12-03T22:29:52+09:00
 **************************************************************************************************/

public enum ContentDispositionValue: String {
  case inline = "inline"
  case attachment = "attachment"
  case formData = "form-data"
  case signal = "signal"
  case alert = "alert"
  case icon = "icon"
  case render = "render"
  case recipientListHistory = "recipient-list-history"
  case session = "session"
  case aib = "aib"
  case earlySession = "early-session"
  case recipientList = "recipient-list"
  case notification = "notification"
  case byReference = "by-reference"
  case infoPackage = "info-package"
  case recordingSession = "recording-session"
  public init(rawValue:String) {
    switch rawValue.lowercased() {
    case "inline": self = .inline
    case "attachment": self = .attachment
    case "form-data": self = .formData
    case "signal": self = .signal
    case "alert": self = .alert
    case "icon": self = .icon
    case "render": self = .render
    case "recipient-list-history": self = .recipientListHistory
    case "session": self = .session
    case "aib": self = .aib
    case "early-session": self = .earlySession
    case "recipient-list": self = .recipientList
    case "notification": self = .notification
    case "by-reference": self = .byReference
    case "info-package": self = .infoPackage
    case "recording-session": self = .recordingSession
    default: self = .attachment
    }
  }
}
