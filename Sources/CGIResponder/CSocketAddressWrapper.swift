/***************************************************************************************************
 CSocketAddressWrapper.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
/**
 
 # CSocketAddressWrapper
 Implements wrapper class for CSocketAddress,
 because `CSocketAddress()` or `sockaddr()` will allocate just insufficient memory space...
 
 */
public class CSocketAddressWrapper {
  private var _size: Int
  private var _pointer: UnsafeMutableRawPointer
  private var _boundPointer: UnsafeMutablePointer<CSocketAddress> {
    return self._pointer.assumingMemoryBound(to:CSocketAddress.self)
  }
  
  deinit {
    self._pointer.deallocate(bytes:self._size, alignedTo:MemoryLayout<Int8>.alignment)
  }
  
  public init<Address: CSocketAddressStructure>(socketAddress:Address) {
    self._size = Int(socketAddress.size)
    self._pointer = UnsafeMutableRawPointer.allocate(bytes:self._size,
                                                     alignedTo:MemoryLayout<Int8>.alignment)
    self._pointer.bindMemory(to:type(of:socketAddress), capacity:1).pointee = socketAddress
  }
  
  internal init(_ pointer:UnsafeMutablePointer<CSocketAddress>) {
    self._size = Int(pointer.pointee.size)
    self._pointer = UnsafeMutableRawPointer.allocate(bytes:self._size,
                                                     alignedTo:MemoryLayout<Int8>.alignment)
    self._pointer.copyBytes(from:UnsafeRawPointer(pointer), count:self._size)
  }
  
  public var size: CSocketAddressSize {
    return self._boundPointer.pointee.size
  }
  
  public var family: CAddressFamily {
    return self._boundPointer.pointee.family
  }
  
  public var socketAddress: CSocketAddressStructure {
    return CSocketAddress.actualSocketAddress(for:UnsafePointer(self._boundPointer))
  }
}
