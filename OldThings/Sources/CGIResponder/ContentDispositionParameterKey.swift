/***************************************************************************************************
 ContentDispositionParameterKey.swift
   This file was created automatically
   from https://www.iana.org/assignments/cont-disp/cont-disp-2.csv
   at 2017-12-03T22:29:51+09:00
 **************************************************************************************************/

public struct ContentDispositionParameterKey: RawRepresentable {
  public let rawValue: String
  public init(rawValue:String) { self.rawValue = rawValue }
}
extension ContentDispositionParameterKey: Hashable {
  public var hashValue: Int { return self.rawValue.hashValue }
  public static func ==(lhs:ContentDispositionParameterKey, rhs:ContentDispositionParameterKey) -> Bool {
    return lhs.rawValue == rhs.rawValue
  }
}
extension ContentDispositionParameterKey {
  public static let filename = ContentDispositionParameterKey(rawValue:"filename")
  public static let creationDate = ContentDispositionParameterKey(rawValue:"creation-date")
  public static let modificationDate = ContentDispositionParameterKey(rawValue:"modification-date")
  public static let readDate = ContentDispositionParameterKey(rawValue:"read-date")
  public static let size = ContentDispositionParameterKey(rawValue:"size")
  public static let name = ContentDispositionParameterKey(rawValue:"name")
  public static let voice = ContentDispositionParameterKey(rawValue:"voice")
  public static let handling = ContentDispositionParameterKey(rawValue:"handling")
  public static let previewType = ContentDispositionParameterKey(rawValue:"preview-type")
}
