/* *************************************************************************************************
 HeaderField.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 

/// # HeaderField
/// Represents each HTTP Header Field.
public struct HeaderField {
  public enum PresenceType {
    /// There are no other fields of the same name in the same header.
    /// e.g.) "ETag"
    case single
    
    /// There may be other fields of the same name in the same header.
    /// e.g.) "Set-Cookie"
    case duplicable
    
    /// The value of the field can be appended.
    /// e.g.) "Cache-Control"
    case appendable
  }
}
