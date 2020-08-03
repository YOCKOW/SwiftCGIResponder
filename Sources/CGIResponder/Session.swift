/* *************************************************************************************************
 session.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation
import TimeSpecification
import yExtensions

/// A type that holds information related to a session.
public struct Session<UserInfo>: Codable where UserInfo: Codable {
  /// The version of `Session`.
  private static var _version: UInt8 { return 0 }
  
  /// The identifier of this session.
  public let id: UUID
  
  /// The time when the session was created.
  public let creationTime: NanosecondAbsoluteTime
  
  /// The valid period of this session.
  public var duration: NanosecondTimeInterval
  
  /// The time when the session will expire.
  public var expirationTime: NanosecondAbsoluteTime {
    get {
      return self.creationTime + self.duration
    }
    set {
      self.duration = newValue - self.creationTime
    }
  }
  
  /// Other information related to this session.
  public var userInfo: UserInfo
  
  /// Returns a Boolean value that indicates whether the session has expired or not.
  public var hasExpired: Bool {
    return self.expirationTime < .timeIntervalSinceReferenceDate
  }
  
  public enum CodingKeys: String, CodingKey {
    case version
    case id
    case creationTime
    case duration
    case userInfo
  }
  
  private init(id: UUID,
               creationTime: NanosecondAbsoluteTime, duration: NanosecondTimeInterval,
               userInfo: UserInfo) {
    self.id = id
    self.creationTime = creationTime
    self.duration = duration
    self.userInfo = userInfo
  }
  
  /// - parameters:
  ///    * id: The identifier of this session. It must not duplicate other identifiers.
  ///    * duration: The valid period of this session.
  ///    * userInfo: Some information related to this session.
  public init(id: UUID = .init(), duration: NanosecondTimeInterval, userInfo: UserInfo) {
    self.init(id: id,
              creationTime: TimeSpecification.timeIntervalSinceReferenceDate,
              duration: duration,
              userInfo: userInfo)
  }
  
  /// - parameters:
  ///    * id: The identifier of this session. It must not duplicate other identifiers.
  ///    * duration: The valid period of this session in seconds.
  ///    * userInfo: Some information related to this session.
  public init(id: UUID = .init(), duration: TimeInterval, userInfo: UserInfo) {
    self.init(id: id,
              duration: TimeSpecification(duration),
              userInfo: userInfo)
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let version = try container.decode(UInt8.self, forKey: .version)
    if version != 0 {
      throw DecodingError.dataCorruptedError(forKey: .version,
                                             in: container,
                                             debugDescription: "Unsupported version of session.")
    }
    self.init(id: try container.decode(UUID.self, forKey: .id),
              creationTime: try container.decode(TimeSpecification.self, forKey: .creationTime),
              duration: try container.decode(TimeSpecification.self, forKey: .duration),
              userInfo: try container.decode(UserInfo.self, forKey: .userInfo))
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(type(of: self)._version, forKey: .version)
    try container.encode(self.id, forKey: .id)
    try container.encode(self.creationTime, forKey: .creationTime)
    try container.encode(self.duration, forKey: .duration)
    try container.encode(self.userInfo, forKey: .userInfo)
  }
}

extension Session: Equatable where UserInfo: Equatable {}

extension Session: Hashable where UserInfo: Hashable {}
