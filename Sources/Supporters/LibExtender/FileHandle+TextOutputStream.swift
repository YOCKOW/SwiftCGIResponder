/* *************************************************************************************************
 FileHandle+TextOutputStream.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation

extension FileHandle: TextOutputStream {
  /// Appends `string` using `encoding` to the stream.
  public func write(_ string:String, using encoding:String.Encoding) {
    self.write(string.data(using:encoding)!)
  }
  
  /// Write `string` using UTF-8 encoding to the receiver.
  public func write(_ string:String) {
    self.write(string, using:.utf8)
  }
}

extension FileHandle {
  internal static var _changeableStandardError: FileHandle = .standardError
}

/// Print objects to standard error
public func warn(_ items: Any..., separator: String = " ", terminator: String = "\n") {
  var stderr = FileHandle._changeableStandardError
  let numberOfItems = items.count
  switch numberOfItems {
  case 0:
    print("", separator:separator, terminator:terminator, to:&stderr)
  case 1:
    print(items[0], separator:separator, terminator:terminator, to:&stderr)
  default:
    for ii in 0..<(numberOfItems - 1) {
      print(items[ii], separator, separator:"", terminator:"", to:&stderr)
    }
    print(items.last!, separator:"", terminator:terminator, to:&stderr)
  }
}

