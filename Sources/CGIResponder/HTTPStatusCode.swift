/***************************************************************************************************
 HTTPStatusCode.swift
   This file was created automatically
   from https://www.iana.org/assignments/http-status-codes/http-status-codes-1.csv
   at 2017-10-01T18:21:51+09:00
 **************************************************************************************************/

public enum HTTPStatusCode: UInt16 {
  case `continue` = 100
  case switchingProtocols = 101
  case processing = 102
  case ok = 200
  case created = 201
  case accepted = 202
  case nonAuthoritativeInformation = 203
  case noContent = 204
  case resetContent = 205
  case partialContent = 206
  case multiStatus = 207
  case alreadyReported = 208
  case imUsed = 226
  case multipleChoices = 300
  case movedPermanently = 301
  case found = 302
  case seeOther = 303
  case notModified = 304
  case useProxy = 305
  case temporaryRedirect = 307
  case permanentRedirect = 308
  case badRequest = 400
  case unauthorized = 401
  case paymentRequired = 402
  case forbidden = 403
  case notFound = 404
  case methodNotAllowed = 405
  case notAcceptable = 406
  case proxyAuthenticationRequired = 407
  case requestTimeout = 408
  case conflict = 409
  case gone = 410
  case lengthRequired = 411
  case preconditionFailed = 412
  case payloadTooLarge = 413
  case uriTooLong = 414
  case unsupportedMediaType = 415
  case rangeNotSatisfiable = 416
  case expectationFailed = 417
  case misdirectedRequest = 421
  case unprocessableEntity = 422
  case locked = 423
  case failedDependency = 424
  case upgradeRequired = 426
  case preconditionRequired = 428
  case tooManyRequests = 429
  case requestHeaderFieldsTooLarge = 431
  case unavailableForLegalReasons = 451
  case internalServerError = 500
  case notImplemented = 501
  case badGateway = 502
  case serviceUnavailable = 503
  case gatewayTimeout = 504
  case httpVersionNotSupported = 505
  case variantAlsoNegotiates = 506
  case insufficientStorage = 507
  case loopDetected = 508
  case notExtended = 510
  case networkAuthenticationRequired = 511
}
extension HTTPStatusCode{
  public var reasonPhrase: String {
    switch self {
    case .continue: return "Continue" // 100
    case .switchingProtocols: return "Switching Protocols" // 101
    case .processing: return "Processing" // 102
    case .ok: return "OK" // 200
    case .created: return "Created" // 201
    case .accepted: return "Accepted" // 202
    case .nonAuthoritativeInformation: return "Non-Authoritative Information" // 203
    case .noContent: return "No Content" // 204
    case .resetContent: return "Reset Content" // 205
    case .partialContent: return "Partial Content" // 206
    case .multiStatus: return "Multi-Status" // 207
    case .alreadyReported: return "Already Reported" // 208
    case .imUsed: return "IM Used" // 226
    case .multipleChoices: return "Multiple Choices" // 300
    case .movedPermanently: return "Moved Permanently" // 301
    case .found: return "Found" // 302
    case .seeOther: return "See Other" // 303
    case .notModified: return "Not Modified" // 304
    case .useProxy: return "Use Proxy" // 305
    case .temporaryRedirect: return "Temporary Redirect" // 307
    case .permanentRedirect: return "Permanent Redirect" // 308
    case .badRequest: return "Bad Request" // 400
    case .unauthorized: return "Unauthorized" // 401
    case .paymentRequired: return "Payment Required" // 402
    case .forbidden: return "Forbidden" // 403
    case .notFound: return "Not Found" // 404
    case .methodNotAllowed: return "Method Not Allowed" // 405
    case .notAcceptable: return "Not Acceptable" // 406
    case .proxyAuthenticationRequired: return "Proxy Authentication Required" // 407
    case .requestTimeout: return "Request Timeout" // 408
    case .conflict: return "Conflict" // 409
    case .gone: return "Gone" // 410
    case .lengthRequired: return "Length Required" // 411
    case .preconditionFailed: return "Precondition Failed" // 412
    case .payloadTooLarge: return "Payload Too Large" // 413
    case .uriTooLong: return "URI Too Long" // 414
    case .unsupportedMediaType: return "Unsupported Media Type" // 415
    case .rangeNotSatisfiable: return "Range Not Satisfiable" // 416
    case .expectationFailed: return "Expectation Failed" // 417
    case .misdirectedRequest: return "Misdirected Request" // 421
    case .unprocessableEntity: return "Unprocessable Entity" // 422
    case .locked: return "Locked" // 423
    case .failedDependency: return "Failed Dependency" // 424
    case .upgradeRequired: return "Upgrade Required" // 426
    case .preconditionRequired: return "Precondition Required" // 428
    case .tooManyRequests: return "Too Many Requests" // 429
    case .requestHeaderFieldsTooLarge: return "Request Header Fields Too Large" // 431
    case .unavailableForLegalReasons: return "Unavailable For Legal Reasons" // 451
    case .internalServerError: return "Internal Server Error" // 500
    case .notImplemented: return "Not Implemented" // 501
    case .badGateway: return "Bad Gateway" // 502
    case .serviceUnavailable: return "Service Unavailable" // 503
    case .gatewayTimeout: return "Gateway Timeout" // 504
    case .httpVersionNotSupported: return "HTTP Version Not Supported" // 505
    case .variantAlsoNegotiates: return "Variant Also Negotiates" // 506
    case .insufficientStorage: return "Insufficient Storage" // 507
    case .loopDetected: return "Loop Detected" // 508
    case .notExtended: return "Not Extended" // 510
    case .networkAuthenticationRequired: return "Network Authentication Required" // 511
    }
  }
}
