/* *************************************************************************************************
 ClientTests.swift
   © 2018,2020,2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */


@testable import CGIResponder
import Foundation
import TemporaryFile

#if swift(>=6) && canImport(Testing)
import Testing

@Suite final class ClientTests {
  @Test func test_cookies() throws {
    let cookies = "name1=value1; name2=value2; name1=another_value1"
    let items = try #require(Environment.virtual(
      variables: .virtual(["HTTP_COOKIE": cookies])
    ).client.request.cookies())
    #expect(items[0].name == "name1")
    #expect(items[0].value == "value1")
    #expect(items[1].name == "name2")
    #expect(items[1].value == "value2")
    #expect(items[2].name == "name1")
    #expect(items[2].value == "another_value1")
  }

  @Test func test_queryItems() throws {
    let urlQuery = "name1=value1&name2=value2"
    let postData = "name3=value3&name4".data(using:.utf8)!
    let contentType = ContentType(type:.application, subtype:"x-www-form-urlencoded")!
    let contentLength = postData.count

    let env: [String:String] = [
      "QUERY_STRING": urlQuery,
      "CONTENT_TYPE": contentType.description,
      "CONTENT_LENGTH": String(contentLength),
      "REQUEST_METHOD": "POST",
    ]

    let client = Environment.virtual(
      standardInput: InMemoryFile(postData),
      variables: .virtual(env)
    ).client
    let queryItems = try #require(client.request.queryItems)
    #expect(queryItems.first(where: { $0.name == "name1" })?.value == "value1")
    #expect(queryItems.first(where: { $0.name == "name2" })?.value == "value2")
    #expect(queryItems.first(where: { $0.name == "name3" })?.value == "value3")
    #expect(queryItems.first(where: { $0.name == "name4" })?.value == nil)
    #expect(queryItems.first(where: { $0.name == "name4" }) != nil)
  }

  @Test func test_queryString() {
    var client = Environment.virtual(variables: .virtual(["QUERY_STRING":"q"])).client
    #expect(client.request.queryString == "q")

    client = Environment.virtual(
      variables: .virtual([
        "QUERY_STRING":"",
        "REQUEST_URI": "/",
      ])
    ).client
    #expect(client.request.queryString == nil)

    client = Environment.virtual(
      variables: .virtual([
        "QUERY_STRING":"",
        "REQUEST_URI": "/?",
      ])
    ).client
    #expect(client.request.queryString == "")
  }

  @Test func test_formDataItems() throws {
    let boundary = "----this-is-test-boundary----"
    let testString =
      "--\(boundary)\(CRLF)" +
      "Content-Disposition: form-data; name=\"Key\"\(CRLF)" +
      "\(CRLF)" +
      "Value\(CRLF)" +
      "--\(boundary)\(CRLF)" +
      "Content-Disposition: form-data; name=\"AnotherKey\"\(CRLF)" +
      "X-Ignorable-Field: You can ignore this line!\(CRLF)" +
      "\(CRLF)" +
      "AnotherValue\(CRLF)" +
      "--\(boundary)\(CRLF)" +
      "Content-Disposition: form-data; name=\"File\"; filename=\"Filename.txt\"\(CRLF)" +
      "Content-Type: text/plain; charset=\"UTF-8\"\(CRLF)" +
      "Content-Transfer-Encoding: binary\(CRLF)" +
      "\(CRLF)" +
      "Hello, World!\n" +
      "\(CRLF)" +
      "--\(boundary)--\(CRLF)" +
      "ここまでは読み込まないでね。"
    let testData = testString.data(using:.utf8)!

    let client = Environment.virtual(
      standardInput: InMemoryFile(testData),
      variables: .virtual(["CONTENT_TYPE": "multipart/form-data; boundary=\(boundary)"])
    ).client

    let tmpDir = try TemporaryDirectory(prefix: "CGIResponder-ClientTests-")

    let iterator = try client.request.formData(savingUploadedFilesIn: tmpDir)

    let firstItem = try #require(iterator.next())
    #expect(firstItem.name == "Key")
    guard case .string(let firstValue, encoding: _) = firstItem.value.content else {
      Issue.record()
      return
    }
    #expect(firstValue == "Value")

    let secondItem = try #require(iterator.next())
    #expect(secondItem.name == "AnotherKey")
    guard case .string(let secondValue, encoding: _) = secondItem.value.content else {
      Issue.record()
      return
    }
    #expect(secondValue == "AnotherValue")

    let thirdItem = try #require(iterator.next())
    #expect(thirdItem.name == "File")
    #expect(thirdItem.value.filename == "Filename.txt")
    #expect(thirdItem.value.contentType == ContentType(pathExtension:.txt, parameters:["charset":"UTF-8"]))
    guard case .temporaryFile(let temporaryFile) = thirdItem.value.content else {
      Issue.record()
      return
    }
    try temporaryFile.seek(toOffset: 0)
    #expect(temporaryFile.availableData == "Hello, World!\n".data(using:.utf8))

    let fourthItem = iterator.next()
    #expect(fourthItem == nil)

    try tmpDir.close()
  }

  @Test func test_emptyFormDataItem() throws {
    // https://github.com/YOCKOW/SwiftCGIResponder/issues/71

    let boundary = "----empty-item-test-boundary----"
    let testString =
      "--\(boundary)\(CRLF)" +
      "Content-Disposition: form-data; name=\"Non-Empty\"\(CRLF)" +
      "\(CRLF)" +
      "Some Value\(CRLF)" +
      "--\(boundary)\(CRLF)" +
      "Content-Disposition: form-data; name=\"Empty\"\(CRLF)" +
      "\(CRLF)" +
      "\(CRLF)" +
      "--\(boundary)\(CRLF)" +
      "Content-Disposition: form-data; name=\"Another Non-Empty\"\(CRLF)" +
      "\(CRLF)" +
      "Another Value\(CRLF)" +
      "--\(boundary)--\(CRLF)"
    let testData = Data(testString.utf8)

    let client = Environment.virtual(
      standardInput: InMemoryFile(testData),
      variables: .virtual(["CONTENT_TYPE": "multipart/form-data; boundary=\(boundary)"])
    ).client
    let tmpDir = try TemporaryDirectory(prefix: "CGIResponder-ClientTests-\(#function)")
    let formData = try client.request.formData(savingUploadedFilesIn: tmpDir)
    let items = Array(formData)
    #expect(formData.error == nil)
    #expect(items.count == 3)

    func __assert(
      item: FormData.Item?,
      expectedName: String,
      expectedValue: String,
      sourceLocation: SourceLocation = #_sourceLocation
    ) throws {
      let item = try #require(item, sourceLocation: sourceLocation)
      #expect(item.name == expectedName, sourceLocation: sourceLocation)
      guard case .string(let string, _) = item.value.content else {
        Issue.record("Unexpected form-data item.", sourceLocation: sourceLocation)
        return
      }
      #expect(string == expectedValue, sourceLocation: sourceLocation)
    }

    try __assert(item: items.first, expectedName: "Non-Empty", expectedValue: "Some Value")
    try __assert(item: items.dropFirst().first, expectedName: "Empty", expectedValue: "")
    try __assert(item: items.last, expectedName: "Another Non-Empty", expectedValue: "Another Value")
  }

  @Test func test_postedJSON() throws {
    struct __Item: Decodable {
      let property: String
    }

    let json = """
    [
      {"property": "value0"},
      {"property": "value1"},
      {"property": "value2"},
    ]
    """
    let requestBody = InMemoryFile(Data(json.utf8))
    let environment = Environment.virtual(
      standardInput: requestBody,
      variables: .virtual([
        "CONTENT_TYPE": "application/json"
      ])
    )

    let decoded = try environment.client.request.decodeJSON(as: [__Item].self)
    #expect(decoded.count == 3)
    #expect(decoded.first?.property == "value0")
    #expect(decoded.dropFirst().first?.property == "value1")
    #expect(decoded.last?.property == "value2")
  }
}
#else
import XCTest

final class ClientTests: XCTestCase {
  func test_cookies() {
    let cookies = "name1=value1; name2=value2; name1=another_value1"
    let items = Environment.virtual(
      variables: .virtual(["HTTP_COOKIE": cookies])
    ).client.request.cookies()
    XCTAssertNotNil(items)
    XCTAssertEqual(items?[0].name, "name1")
    XCTAssertEqual(items?[0].value, "value1")
    XCTAssertEqual(items?[1].name, "name2")
    XCTAssertEqual(items?[1].value, "value2")
    XCTAssertEqual(items?[2].name, "name1")
    XCTAssertEqual(items?[2].value, "another_value1")
  }
  
  func test_queryItems() throws {
    let urlQuery = "name1=value1&name2=value2"
    let postData = "name3=value3&name4".data(using:.utf8)!
    let contentType = ContentType(type:.application, subtype:"x-www-form-urlencoded")!
    let contentLength = postData.count
    
    let env: [String:String] = [
      "QUERY_STRING": urlQuery,
      "CONTENT_TYPE": contentType.description,
      "CONTENT_LENGTH": String(contentLength),
      "REQUEST_METHOD": "POST",
    ]

    /*
      Requires workaround for
        https://github.com/YOCKOW/SwiftCGIResponder/issues/69
        https://bugs.swift.org/browse/SR-14620
    */
    
    let client = Environment.virtual(
      standardInput: InMemoryFile(postData),
      variables: .virtual(env)
    ).client
    let queryItems = try XCTUnwrap(client.request.queryItems)
    XCTAssertEqual(queryItems.first(where: { $0.name == "name1" })?.value, "value1")
    XCTAssertEqual(queryItems.first(where: { $0.name == "name2" })?.value, "value2")
    XCTAssertEqual(queryItems.first(where: { $0.name == "name3" })?.value, "value3")
    XCTAssertEqual(queryItems.first(where: { $0.name == "name4" })?.value, nil)
    XCTAssertNotNil(queryItems.first(where: { $0.name == "name4" }))
  }
  
  func test_queryString() {
    var client = Environment.virtual(variables: .virtual(["QUERY_STRING":"q"])).client
    XCTAssertEqual(client.request.queryString, "q")
    
    client = Environment.virtual(
      variables: .virtual([
        "QUERY_STRING":"",
        "REQUEST_URI": "/",
      ])
    ).client
    XCTAssertEqual(client.request.queryString, nil)
    
    client = Environment.virtual(
      variables: .virtual([
        "QUERY_STRING":"",
        "REQUEST_URI": "/?",
      ])
    ).client
    XCTAssertEqual(client.request.queryString, "")
  }
  
  func test_formDataItems() throws {
    let boundary = "----this-is-test-boundary----"
    let testString =
      "--\(boundary)\(CRLF)" +
      "Content-Disposition: form-data; name=\"Key\"\(CRLF)" +
      "\(CRLF)" +
      "Value\(CRLF)" +
      "--\(boundary)\(CRLF)" +
      "Content-Disposition: form-data; name=\"AnotherKey\"\(CRLF)" +
      "X-Ignorable-Field: You can ignore this line!\(CRLF)" +
      "\(CRLF)" +
      "AnotherValue\(CRLF)" +
      "--\(boundary)\(CRLF)" +
      "Content-Disposition: form-data; name=\"File\"; filename=\"Filename.txt\"\(CRLF)" +
      "Content-Type: text/plain; charset=\"UTF-8\"\(CRLF)" +
      "Content-Transfer-Encoding: binary\(CRLF)" +
      "\(CRLF)" +
      "Hello, World!\n" +
      "\(CRLF)" +
      "--\(boundary)--\(CRLF)" +
      "ここまでは読み込まないでね。"
    let testData = testString.data(using:.utf8)!
    
    let client = Environment.virtual(
      standardInput: InMemoryFile(testData),
      variables: .virtual(["CONTENT_TYPE": "multipart/form-data; boundary=\(boundary)"])
    ).client
    
    let tmpDir = try TemporaryDirectory(prefix: "CGIResponder-ClientTests-")
    
    let iterator = try client.request.formData(savingUploadedFilesIn: tmpDir)
    XCTAssertNotNil(iterator)
    
    let firstItem = iterator.next()
    XCTAssertNotNil(firstItem)
    XCTAssertEqual(firstItem?.name, "Key")
    guard case .string(let firstValue, encoding:_)? = firstItem?.value.content else { XCTFail(); return }
    XCTAssertEqual(firstValue, "Value")
    
    let secondItem = iterator.next()
    XCTAssertNotNil(secondItem)
    XCTAssertEqual(secondItem?.name, "AnotherKey")
    guard case .string(let secondValue, encoding:_)? = secondItem?.value.content else { XCTFail(); return }
    XCTAssertEqual(secondValue, "AnotherValue")
    
    let thirdItem = iterator.next()
    XCTAssertNotNil(thirdItem)
    XCTAssertEqual(thirdItem?.name, "File")
    XCTAssertEqual(thirdItem?.value.filename, "Filename.txt")
    XCTAssertEqual(thirdItem?.value.contentType,
                   ContentType(pathExtension:.txt, parameters:["charset":"UTF-8"]))
    guard case .temporaryFile(let temporaryFile) = thirdItem?.value.content else { XCTFail(); return }
    try temporaryFile.seek(toOffset: 0)
    XCTAssertEqual(temporaryFile.availableData, "Hello, World!\n".data(using:.utf8))
    
    let fourthItem = iterator.next()
    XCTAssertNil(fourthItem)
    
    try tmpDir.close()
  }

  func test_emptyFormDataItem() throws {
    // https://github.com/YOCKOW/SwiftCGIResponder/issues/71

    let boundary = "----empty-item-test-boundary----"
    let testString =
      "--\(boundary)\(CRLF)" +
      "Content-Disposition: form-data; name=\"Non-Empty\"\(CRLF)" +
      "\(CRLF)" +
      "Some Value\(CRLF)" +
      "--\(boundary)\(CRLF)" +
      "Content-Disposition: form-data; name=\"Empty\"\(CRLF)" +
      "\(CRLF)" +
      "\(CRLF)" +
      "--\(boundary)\(CRLF)" +
      "Content-Disposition: form-data; name=\"Another Non-Empty\"\(CRLF)" +
      "\(CRLF)" +
      "Another Value\(CRLF)" +
      "--\(boundary)--\(CRLF)"
    let testData = Data(testString.utf8)

    let client = Environment.virtual(
      standardInput: InMemoryFile(testData),
      variables: .virtual(["CONTENT_TYPE": "multipart/form-data; boundary=\(boundary)"])
    ).client
    let tmpDir = try TemporaryDirectory(prefix: "CGIResponder-ClientTests-\(#function)")
    let formData = try client.request.formData(savingUploadedFilesIn: tmpDir)
    let items = Array(formData)
    XCTAssertNil(formData.error)
    XCTAssertEqual(items.count, 3)

    func __assert(
      item: FormData.Item?,
      expectedName: String,
      expectedValue: String,
      file: StaticString = #filePath,
      line: UInt = #line
    ) throws {
      let item = try XCTUnwrap(item)
      XCTAssertEqual(item.name, expectedName, file: file, line: line)
      guard case .string(let string, _) = item.value.content else {
        XCTFail("Unexpected form-data item.", file: file, line: line)
        return
      }
      XCTAssertEqual(string, expectedValue, file: file, line: line)
    }

    try __assert(item: items.first, expectedName: "Non-Empty", expectedValue: "Some Value")
    try __assert(item: items.dropFirst().first, expectedName: "Empty", expectedValue: "")
    try __assert(item: items.last, expectedName: "Another Non-Empty", expectedValue: "Another Value")
  }

  func test_postedJSON() throws {
    struct __Item: Decodable {
      let property: String
    }

    let json = """
    [
      {"property": "value0"},
      {"property": "value1"},
      {"property": "value2"},
    ]
    """
    let requestBody = InMemoryFile(Data(json.utf8))
    let environment = Environment.virtual(
      standardInput: requestBody,
      variables: .virtual([
        "CONTENT_TYPE": "application/json"
      ])
    )

    let decoded = try environment.client.request.decodeJSON(as: [__Item].self)
    XCTAssertEqual(decoded.count, 3)
    XCTAssertEqual(decoded.first?.property, "value0")
    XCTAssertEqual(decoded.dropFirst().first?.property, "value1")
    XCTAssertEqual(decoded.last?.property, "value2")
  }
}
#endif
