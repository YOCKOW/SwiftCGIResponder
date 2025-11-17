/* *************************************************************************************************
 CGIContentOutputStreamTests.swift
   © 2018,2024-2025 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

@testable import CGIResponder
import Foundation
import TemporaryFile
import Testing
import yExtensions

@Suite final class CGIContentOutputStreamTests {
  @Test func test_pathForUnexistingFile() {
    let path = "--hoge/fuga/piyo--"
    let unexisting = CGIContent(fileAtPath:path)

    var output = Data()
    #expect(throws: CGIResponderError.illegalOperation) {
      try output.write(unexisting)
    }
  }

  @Test func test_stream() throws {
    enum __Error: Swift.Error {
      case notFileHandle
      case missingOutput
    }

    let input: CGIContent = .streamable(InMemoryFile(Data("Hello, stream!".utf8)))
    var output: any CGIContentOutputStream = HybridTemporaryFile()
    try output.write(input)

    guard let outputFH = output as? any FileHandleProtocol else {
      throw __Error.notFileHandle
    }
    try outputFH.seek(toOffset: 0)
    guard let outputData = try outputFH.readToEnd() else {
      throw __Error.missingOutput
    }
    #expect(String(data: outputData, encoding: .utf8) == "Hello, stream!")
  }
}
