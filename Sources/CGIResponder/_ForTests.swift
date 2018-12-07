/* *************************************************************************************************
 _ForTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Foundation

extension FileHandle {
  internal static var _changeableStandardInput: FileHandle = .standardInput
}
