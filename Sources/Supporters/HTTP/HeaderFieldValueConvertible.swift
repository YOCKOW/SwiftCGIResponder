/* *************************************************************************************************
 HeaderFieldValueConvertible.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// A type that can be converted to/from an instance of `HeaderFieldValue`.
public protocol HeaderFieldValueConvertible: Hashable {
  init?(headerFieldValue:HeaderFieldValue)
  var headerFieldValue:HeaderFieldValue { get }
}
