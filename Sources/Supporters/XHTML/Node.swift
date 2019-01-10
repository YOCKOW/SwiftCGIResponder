/* *************************************************************************************************
 Node.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// The nodes in the abstract, logical tree structure
/// that represents an XHTML document like `XMLNode`.
public protocol Node: class {
  var xmlString: String { get }
}
