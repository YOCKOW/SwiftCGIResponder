/* *************************************************************************************************
 _StandardInputTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

@testable import CGIResponder

import Foundation
import TemporaryFile

func withStandardInput(data:Data, _ body:() throws -> Void) rethrows {
  try TemporaryFile {
    let originalStandardInput = FileHandle._changeableStandardInput
    FileHandle._changeableStandardInput = $0
    defer {
      FileHandle._changeableStandardInput = originalStandardInput
    }
    
    $0.write(data)
    $0.seek(toFileOffset:0)
    try body()
  }
}
