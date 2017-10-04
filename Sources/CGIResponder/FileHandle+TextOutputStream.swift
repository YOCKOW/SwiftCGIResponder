/***************************************************************************************************
 FileHandle+TextOutputStream.swift
   © 2017年 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
 
import Foundation

/// Let `FileHandle` conform to TextOutputStream
extension FileHandle: TextOutputStream {
  public func write(_ string:String, using encoding:String.Encoding) {
    self.write(string.data(using:encoding)!)
  }
  public func write(_ string:String) {
    self.write(string, using:.utf8)
  }
}

/// Print objects to standard error
internal func warn(_ items: Any..., separator: String = " ", terminator: String = "\n") {
  var stderr = FileHandle.standardError
  let numberOfItems = items.count
  if numberOfItems == 0 {
    print("", separator:separator, terminator:terminator, to:&stderr)
  } else if numberOfItems == 1 {
    print(items[0], separator:separator, terminator:terminator, to:&stderr)
  } else {
    for ii in 0..<numberOfItems {
      if ii < numberOfItems - 1 {
        print(items[ii], separator, separator:"", terminator:"", to:&stderr)
      } else {
        print(items[ii], separator:"", terminator:terminator, to:&stderr)
      }
    }
  }
}
