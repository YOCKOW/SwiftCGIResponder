/***************************************************************************************************
 CUNIXSocketAddress.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import Foundation

/// Extend `CUNIXSocketAddress` (a.k.a. `sockaddr_un`)
extension CUNIXSocketAddress: CSocketAddressStructure {
  public private(set) var size: CSocketAddressSize {
    get {
      #if os(OSX) || os(iOS) || os(watchOS) || os(tvOS)
        return self.sun_len
      #else
        return CSocketAddressSize(MemoryLayout<CUNIXSocketAddress>.size)
      #endif
    }
    set {
      #if os(OSX) || os(iOS) || os(watchOS) || os(tvOS)
        self.sun_len = newValue
      #endif
    }
  }
  
  public private(set) var family: CAddressFamily {
    get {
      return CAddressFamily(rawValue:self.sun_family) // AF_UNIX or AF_LOCAL
    }
    set {
      self.sun_family = newValue.rawValue
    }
  }
  
  private var _pathLength: Int { return MemoryLayout.size(ofValue:self.sun_path) }
  
  private var _data: Data {
    mutating get {
      return withUnsafePointer(to:&self.sun_path) {
        return Data(bytes:UnsafeRawPointer($0), count:self._pathLength)
      }
    }
    set(newData) {
      guard newData.count <= self._pathLength else { fatalError("Too long") }
      withUnsafeMutablePointer(to:&self.sun_path) {
        $0.withMemoryRebound(to:UInt8.self, capacity:self._pathLength) {
          newData.copyBytes(to:$0, count:newData.count)
        }
      }
    }
  }
  
  public var path: String {
    get {
      var myself = self
      return String(data:myself._data, encoding:.utf8)!
    }
    set {
      guard let data = newValue.data(using:.utf8) else { fatalError("Invalid String") }
      self._data = data
    }
  }
  
  public init?(path:String) {
    self.init()
    guard let data = path.data(using:.utf8), data.count <= self._pathLength else { return nil }
    self.size = CSocketAddressSize(MemoryLayout<CUNIXSocketAddress>.size)
    self.family = .unix
    self._data = Data(repeating:0, count:self._pathLength) // reset
    self._data = data
  }
}
