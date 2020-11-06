/* *************************************************************************************************
 session.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation
import TimeSpecification
import yExtensions

/// Represents the identifier for Session.
public struct SessionID: Equatable, Hashable, LosslessStringConvertible, Codable {
  public enum Length {
    /// 128-bit length
    case normal

    /// 256-bit length
    case long
  }

  private enum _Variant: Equatable, Hashable {
    case normal((UInt64, UInt64))
    case long((UInt64, UInt64, UInt64, UInt64))

    static func random<G>(length: Length, using generator: inout G) -> _Variant where G: RandomNumberGenerator {
      func __randomUInt64() -> UInt64 {
        return .random(in: .min ... .max, using: &generator)
      }

      switch length {
      case .normal:
        return .normal((__randomUInt64(), __randomUInt64()))
      case .long:
        return .long((__randomUInt64(), __randomUInt64(), __randomUInt64(), __randomUInt64()))
      }
    }

    static func ==(lhs: SessionID._Variant, rhs: SessionID._Variant) -> Bool {
      switch (lhs, rhs) {
      case (.normal(let tupleL), .normal(let tupleR)):
        return tupleL.0 == tupleR.0 && tupleL.1 == tupleR.1
      case (.long(let tupleL), .long(let tupleR)):
        return (
          tupleL.0 == tupleR.0 && tupleL.1 == tupleR.1 &&
          tupleL.2 == tupleR.2 && tupleL.3 == tupleR.3
        )
      default:
        return false
      }
    }

    func hash(into hasher: inout Hasher) {
      switch self {
      case .normal((let u0, let u1)):
        hasher.combine(u0)
        hasher.combine(u1)
      case .long((let u0, let u1, let u2, let u3)):
        hasher.combine(u0)
        hasher.combine(u1)
        hasher.combine(u2)
        hasher.combine(u3)
      }
    }

    init(uuid: UUID) {
      var nTuple: (UInt64, UInt64) = (0, 0)
      _ = withUnsafeMutableBytes(of: &nTuple) { (nTuplePointer) in
        Swift.withUnsafeBytes(of: uuid.uuid) {
          $0.copyBytes(to: nTuplePointer)
        }
      }
      self = .normal(nTuple)
    }

    func withUnsafeBytes<T>(_ body: (UnsafeRawBufferPointer) throws -> T) rethrows -> T {
      switch self {
      case .normal(let nTuple):
        return try Swift.withUnsafeBytes(of: nTuple, body)
      case .long(let lTuple):
        return try Swift.withUnsafeBytes(of: lTuple, body)
      }
    }

    func base32EncodedData(using version: Base32Version, padding: Bool) -> Data {
      return withUnsafeBytes { $0.base32EncodedData(using: version, padding: padding) }
    }

    init?(base32EncodedData data: Data, version: Base32Version) {
      guard data.count < 53 else { return nil }
      guard let decoded = Data(base32Encoded: data, version: version) else { return nil }
      switch decoded.count {
      case 16:
        var nTuple: (UInt64, UInt64) = (0, 0)
        _ = withUnsafeMutableBytes(of: &nTuple) { decoded.copyBytes(to: $0) }
        self = .normal(nTuple)
      case 32:
        var lTuple: (UInt64, UInt64, UInt64, UInt64) = (0, 0, 0, 0)
        _ = withUnsafeMutableBytes(of: &lTuple) { decoded.copyBytes(to: $0) }
        self = .long(lTuple)
      default:
        return nil
      }
    }
  }

  private let _variant: _Variant

  private init(_ variant: _Variant) {
    self._variant = variant
  }

  /// Initialize with UUID. For forward compatibility.
  public init(uuid: UUID) {
    self.init(_Variant(uuid: uuid))
  }

  /// Returns a random identifier, using the given generator as a source for randomness.
  public static func random<G>(length: Length, using generator: inout G) -> SessionID where G: RandomNumberGenerator {
    return .init(_Variant.random(length: length, using: &generator))
  }

  /// Returns a random identifier.
  public static func random(length: Length = .long) -> SessionID {
    var generator = SystemRandomNumberGenerator()
    return random(length: length, using: &generator)
  }

  internal var _base32EncodedData: Data {
    return _variant.base32EncodedData(using: .rfc4648, padding: false)
  }

  internal var _base32EncodedString: String {
    return String(data: _base32EncodedData,
                  encoding: .utf8)!
  }

  internal init?<S>(_base32EncodedString string: S) where S: StringProtocol {
    let data = Data(string.utf8)
    guard let variant = _Variant(base32EncodedData: data, version: .rfc4648) else { return nil }
    self.init(variant)
  }

  public var description: String {
    return _base32EncodedString
  }

  public init?(_ description: String) {
    self.init(_base32EncodedString: description)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(description)
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    guard let instance = Self(try container.decode(String.self)) else {
      throw DecodingError.dataCorruptedError(in: container,
                                             debugDescription: "Unexpected string for `SessionID`.")
    }
    self = instance
  }

  public func withUnsafeBytes<T>(_ body: (UnsafeRawBufferPointer) throws -> T) rethrows -> T {
    return try _variant.withUnsafeBytes(body)
  }
}

/// A type that holds information related to a session.
public struct Session<UserInfo>: Codable where UserInfo: Codable {
  /// The version of `Session`.
  private static var _version: UInt8 { return 1 }
  
  /// The identifier of this session.
  public let id: SessionID
  
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
  
  private init(id: SessionID,
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
  public init(id: SessionID = .random(), duration: NanosecondTimeInterval, userInfo: UserInfo) {
    self.init(id: id,
              creationTime: TimeSpecification.timeIntervalSinceReferenceDate,
              duration: duration,
              userInfo: userInfo)
  }
  
  /// - parameters:
  ///    * id: The identifier of this session. It must not duplicate other identifiers.
  ///    * duration: The valid period of this session in seconds.
  ///    * userInfo: Some information related to this session.
  public init(id: SessionID = .random(), duration: TimeInterval, userInfo: UserInfo) {
    self.init(id: id,
              duration: TimeSpecification(duration),
              userInfo: userInfo)
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let version = try container.decode(UInt8.self, forKey: .version)
    if version > 1 {
      throw DecodingError.dataCorruptedError(forKey: .version,
                                             in: container,
                                             debugDescription: "Unsupported version of session.")
    }

    let id: SessionID = try ({
      switch version {
      case 0:
        return SessionID(uuid: try container.decode(UUID.self, forKey: .id))
      case 1...:
        return try container.decode(SessionID.self, forKey: .id)
      default:
        fatalError("Never reach.")
      }
    })()

    self.init(id: id,
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
