/* *************************************************************************************************
 Data+View.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import CoreFoundation
import Foundation

extension Data {
  public struct View<UnsignedIntegerType>
    where UnsignedIntegerType: UnsignedInteger & FixedWidthInteger
  {
    fileprivate enum _Endianness {
      case bigEndian, littleEndian
      // Should implement the case like `case middleEndian(ByteOrder)`?
      fileprivate init(_ cfEndian:CFByteOrder) {
        if cfEndian == CFByteOrderBigEndian.rawValue {
          self = .bigEndian
        } else if cfEndian == CFByteOrderLittleEndian.rawValue {
          self = .littleEndian
        } else {
          fatalError("Unsupported endianness.")
        }
      }
    }
    
    /// Index of view.
    public struct Index: Comparable {
      private var _index: Int
      private var _relativeRange: Range<Data.RelativeIndex>
      
      fileprivate init(index:Int) {
        assert(index >= 0)
        self._index = index
        
        let length = MemoryLayout<UnsignedIntegerType>.size
        let lower = Data.RelativeIndex(distance:index * length)!
        let upper = Data.RelativeIndex(distance:(index + 1) * length)!
        self._relativeRange = lower..<upper
      }
      
      fileprivate init(range:Range<Data.Index>) {
        assert(range.lowerBound >= 0)
        assert(range.upperBound - range.lowerBound == MemoryLayout<UnsignedIntegerType>.size)
        self._index = range.lowerBound / MemoryLayout<UnsignedIntegerType>.size
        self._relativeRange =
          Data.RelativeIndex(distance:range.lowerBound)!..<Data.RelativeIndex(distance:range.upperBound)!
      }
      
      fileprivate static func +(lhs:Index, rhs:Int) -> Index {
        return Index(index:lhs._index + rhs)
      }
      
      public static func ==(lhs:Index, rhs:Index) -> Bool {
        return lhs._index == rhs._index
      }
      
      public static func <(lhs:Index, rhs:Index) -> Bool {
        return lhs._index < rhs._index
      }
      
      fileprivate func subdata(for data:Data) -> Data {
        return data[self._relativeRange]
      }
    }
    
    private var _endianness: _Endianness
    private var _data: Data

    fileprivate init?(data:Data, endianness:_Endianness = .init(CFByteOrderGetCurrent())) {
      guard data.count % MemoryLayout<UnsignedIntegerType>.size == 0 else { return nil }
      self._data = data
      self._endianness = endianness
    }
  }
}

extension Data {
  /// A view of a data's contents as a collection of `UInt8`.
  public typealias UInt8View = View<UInt8>
  public var uint8View: UInt8View { return UInt8View(data:self)! }
  
  /// A view of a data's contents as a collection of `UInt16` in big endian.
  /// This property may be `nil` if the size of the data is not a multiple of the size of `UInt16`.
  public typealias UInt16BigEndianView = View<UInt16>
  public var uint16BigEndianView: UInt16BigEndianView? {
    return UInt16BigEndianView(data:self, endianness:.bigEndian)
  }
  
  /// A view of a data's contents as a collection of `UInt16` in little endian.
  /// This property may be `nil` if the size of the data is not a multiple of the size of `UInt16`.
  public typealias UInt16LittleEndianView = View<UInt16>
  public var uint16LittleEndianView: UInt16LittleEndianView? {
    return UInt16LittleEndianView(data:self, endianness:.littleEndian)
  }
  
  /// A view of a data's contents as a collection of `UInt16` in host's endian.
  /// This property may be `nil` if the size of the data is not a multiple of the size of `UInt16`.
  public typealias UInt16View = View<UInt16>
  public var uint16View: UInt16View? {
    return UInt16View(data:self)
  }
  
  /// A view of a data's contents as a collection of `UInt32` in big endian.
  /// This property may be `nil` if the size of the data is not a multiple of the size of `UInt32`.
  public typealias UInt32BigEndianView = View<UInt32>
  public var uint32BigEndianView: UInt32BigEndianView? {
    return UInt32BigEndianView(data:self, endianness:.bigEndian)
  }
  
  /// A view of a data's contents as a collection of `UInt32` in little endian.
  /// This property may be `nil` if the size of the data is not a multiple of the size of `UInt32`.
  public typealias UInt32LittleEndianView = View<UInt32>
  public var uint32LittleEndianView: UInt32LittleEndianView? {
    return UInt32LittleEndianView(data:self, endianness:.littleEndian)
  }
  
  /// A view of a data's contents as a collection of `UInt32` in host's endian.
  /// This property may be `nil` if the size of the data is not a multiple of the size of `UInt32`.
  public typealias UInt32View = View<UInt32>
  public var uint32View: UInt32View? {
    return UInt32View(data:self)
  }
  
  /// A view of a data's contents as a collection of `UInt64` in big endian.
  /// This property may be `nil` if the size of the data is not a multiple of the size of `UInt64`.
  public typealias UInt64BigEndianView = View<UInt64>
  public var uint64BigEndianView: UInt64BigEndianView? {
    return UInt64BigEndianView(data:self, endianness:.bigEndian)
  }
  
  /// A view of a data's contents as a collection of `UInt64` in little endian.
  /// This property may be `nil` if the size of the data is not a multiple of the size of `UInt64`.
  public typealias UInt64LittleEndianView = View<UInt64>
  public var uint64LittleEndianView: UInt64LittleEndianView? {
    return UInt64LittleEndianView(data:self, endianness:.littleEndian)
  }
  
  /// A view of a data's contents as a collection of `UInt64` in host's endian.
  /// This property may be `nil` if the size of the data is not a multiple of the size of `UInt64`.
  public typealias UInt64View = View<UInt64>
  public var uint64View: UInt64View? {
    return UInt64View(data:self)
  }
}


extension Data.View {
  public var startIndex: Data.View<UnsignedIntegerType>.Index {
    return Index(index:0)
  }

  public var endIndex: Data.View<UnsignedIntegerType>.Index {
    let distance = self._data.endIndex - self._data.startIndex
    return Index(range:distance..<(distance + MemoryLayout<UnsignedIntegerType>.size))
  }
  
  public var count: Int {
    return (self._data.endIndex - self._data.startIndex) / MemoryLayout<UnsignedIntegerType>.size
  }

  public func index(_ index:Data.View<UnsignedIntegerType>.Index,
                    offsetBy distance:Int) -> Data.View<UnsignedIntegerType>.Index
  {
    return index + distance
  }

  public func index(after index:Data.View<UnsignedIntegerType>.Index)
    -> Data.View<UnsignedIntegerType>.Index
  {
    return self.index(index, offsetBy:1)
  }

  public func index(before index:Data.View<UnsignedIntegerType>.Index)
    -> Data.View<UnsignedIntegerType>.Index
  {
    return self.index(index, offsetBy:-1)
  }

  private func _subdata(at index:Data.View<UnsignedIntegerType>.Index) -> Data {
    return index.subdata(for:self._data)
  }

  public subscript(_ index:Data.View<UnsignedIntegerType>.Index) -> UnsignedIntegerType {
    let data = self._subdata(at:index)
    assert(data.count == MemoryLayout<UnsignedIntegerType>.size)

    var unswapped: UnsignedIntegerType = 0
    Swift.withUnsafeMutableBytes(of:&unswapped) { (pointer:UnsafeMutableRawBufferPointer) -> Void in
      for ii in 0..<data.count {
        pointer[ii] = data[Data.RelativeIndex(distance:ii)!]
      }
    }
    
    switch self._endianness {
    case .bigEndian: return UnsignedIntegerType(bigEndian:unswapped)
    case .littleEndian: return UnsignedIntegerType(littleEndian:unswapped)
    }
  }
}

extension Data.View: Sequence {
  public struct Iterator: IteratorProtocol {
    public typealias Element = UnsignedIntegerType
    private var _view: Data.View<UnsignedIntegerType>
    private var _index: Data.View<UnsignedIntegerType>.Index
    fileprivate init(_ view:Data.View<UnsignedIntegerType>) {
      self._view = view
      self._index = view.startIndex
    }
    public mutating func next() -> UnsignedIntegerType? {
      guard self._index < self._view.endIndex else { return nil }
      let result = self._view[self._index]
      self._index = self._view.index(after:self._index)
      return result
    }
  }

  public func makeIterator() -> Data.View<UnsignedIntegerType>.Iterator {
    return Iterator(self)
  }
}

extension Data.View: RandomAccessCollection {}
