/* *************************************************************************************************
 _StandardInputTests.swift
   © 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

@testable import CGIResponder

import Foundation
import TemporaryFile
import yProtocols

func withStandardInput(data:Data, _ body:() throws -> Void) rethrows {
  try TemporaryFile {
    let originalStandardInput = _changeableStandardInput
    _changeableStandardInput = AnyFileHandle($0)
    
    try $0.write(contentsOf: data)
    try $0.seek(toOffset: 0)
    try body()
    
    _changeableStandardInput = originalStandardInput
  }
}
