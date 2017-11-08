/***************************************************************************************************
 HTTPHeaderFieldName+IANARegistered.swift
   This file was created automatically
   from https://www.iana.org/assignments/message-headers/perm-headers.csv
        https://www.iana.org/assignments/message-headers/prov-headers.csv
   at 2017-10-01T21:18:19+09:00
 **************************************************************************************************/

extension HTTPHeaderFieldName {
  public static let aIM = HTTPHeaderFieldName(rawValue:"A-IM")!
  public static let accept = HTTPHeaderFieldName(rawValue:"Accept")!
  public static let acceptAdditions = HTTPHeaderFieldName(rawValue:"Accept-Additions")!
  public static let acceptCharset = HTTPHeaderFieldName(rawValue:"Accept-Charset")!
  public static let acceptDatetime = HTTPHeaderFieldName(rawValue:"Accept-Datetime")!
  public static let acceptEncoding = HTTPHeaderFieldName(rawValue:"Accept-Encoding")!
  public static let acceptFeatures = HTTPHeaderFieldName(rawValue:"Accept-Features")!
  public static let acceptLanguage = HTTPHeaderFieldName(rawValue:"Accept-Language")!
  public static let acceptPatch = HTTPHeaderFieldName(rawValue:"Accept-Patch")!
  public static let acceptPost = HTTPHeaderFieldName(rawValue:"Accept-Post")!
  public static let acceptRanges = HTTPHeaderFieldName(rawValue:"Accept-Ranges")!
  public static let age = HTTPHeaderFieldName(rawValue:"Age")!
  public static let allow = HTTPHeaderFieldName(rawValue:"Allow")!
  public static let alpn = HTTPHeaderFieldName(rawValue:"ALPN")!
  public static let altSvc = HTTPHeaderFieldName(rawValue:"Alt-Svc")!
  public static let altUsed = HTTPHeaderFieldName(rawValue:"Alt-Used")!
  public static let alternates = HTTPHeaderFieldName(rawValue:"Alternates")!
  public static let applyToRedirectRef = HTTPHeaderFieldName(rawValue:"Apply-To-Redirect-Ref")!
  public static let authenticationControl = HTTPHeaderFieldName(rawValue:"Authentication-Control")!
  public static let authenticationInfo = HTTPHeaderFieldName(rawValue:"Authentication-Info")!
  public static let authorization = HTTPHeaderFieldName(rawValue:"Authorization")!
  public static let cExt = HTTPHeaderFieldName(rawValue:"C-Ext")!
  public static let cMan = HTTPHeaderFieldName(rawValue:"C-Man")!
  public static let cOpt = HTTPHeaderFieldName(rawValue:"C-Opt")!
  public static let cPEP = HTTPHeaderFieldName(rawValue:"C-PEP")!
  public static let cPEPInfo = HTTPHeaderFieldName(rawValue:"C-PEP-Info")!
  public static let cacheControl = HTTPHeaderFieldName(rawValue:"Cache-Control")!
  public static let calDAVTimezones = HTTPHeaderFieldName(rawValue:"CalDAV-Timezones")!
  public static let close = HTTPHeaderFieldName(rawValue:"Close")!
  public static let connection = HTTPHeaderFieldName(rawValue:"Connection")!
  public static let contentDisposition = HTTPHeaderFieldName(rawValue:"Content-Disposition")!
  public static let contentEncoding = HTTPHeaderFieldName(rawValue:"Content-Encoding")!
  public static let contentID = HTTPHeaderFieldName(rawValue:"Content-ID")!
  public static let contentLanguage = HTTPHeaderFieldName(rawValue:"Content-Language")!
  public static let contentLength = HTTPHeaderFieldName(rawValue:"Content-Length")!
  public static let contentLocation = HTTPHeaderFieldName(rawValue:"Content-Location")!
  public static let contentMd5 = HTTPHeaderFieldName(rawValue:"Content-MD5")!
  public static let contentRange = HTTPHeaderFieldName(rawValue:"Content-Range")!
  public static let contentScriptType = HTTPHeaderFieldName(rawValue:"Content-Script-Type")!
  public static let contentStyleType = HTTPHeaderFieldName(rawValue:"Content-Style-Type")!
  public static let contentType = HTTPHeaderFieldName(rawValue:"Content-Type")!
  public static let contentVersion = HTTPHeaderFieldName(rawValue:"Content-Version")!
  public static let cookie = HTTPHeaderFieldName(rawValue:"Cookie")!
  public static let dasl = HTTPHeaderFieldName(rawValue:"DASL")!
  public static let dav = HTTPHeaderFieldName(rawValue:"DAV")!
  public static let date = HTTPHeaderFieldName(rawValue:"Date")!
  public static let defaultStyle = HTTPHeaderFieldName(rawValue:"Default-Style")!
  public static let deltaBase = HTTPHeaderFieldName(rawValue:"Delta-Base")!
  public static let depth = HTTPHeaderFieldName(rawValue:"Depth")!
  public static let derivedFrom = HTTPHeaderFieldName(rawValue:"Derived-From")!
  public static let destination = HTTPHeaderFieldName(rawValue:"Destination")!
  public static let differentialID = HTTPHeaderFieldName(rawValue:"Differential-ID")!
  public static let digest = HTTPHeaderFieldName(rawValue:"Digest")!
  public static let eTag = HTTPHeaderFieldName(rawValue:"ETag")!
  public static let expect = HTTPHeaderFieldName(rawValue:"Expect")!
  public static let expires = HTTPHeaderFieldName(rawValue:"Expires")!
  public static let ext = HTTPHeaderFieldName(rawValue:"Ext")!
  public static let forwarded = HTTPHeaderFieldName(rawValue:"Forwarded")!
  public static let from = HTTPHeaderFieldName(rawValue:"From")!
  public static let getProfile = HTTPHeaderFieldName(rawValue:"GetProfile")!
  public static let hobareg = HTTPHeaderFieldName(rawValue:"Hobareg")!
  public static let host = HTTPHeaderFieldName(rawValue:"Host")!
  public static let httP2Settings = HTTPHeaderFieldName(rawValue:"HTTP2-Settings")!
  public static let im = HTTPHeaderFieldName(rawValue:"IM")!
  public static let `if` = HTTPHeaderFieldName(rawValue:"If")!
  public static let ifMatch = HTTPHeaderFieldName(rawValue:"If-Match")!
  public static let ifModifiedSince = HTTPHeaderFieldName(rawValue:"If-Modified-Since")!
  public static let ifNoneMatch = HTTPHeaderFieldName(rawValue:"If-None-Match")!
  public static let ifRange = HTTPHeaderFieldName(rawValue:"If-Range")!
  public static let ifScheduleTagMatch = HTTPHeaderFieldName(rawValue:"If-Schedule-Tag-Match")!
  public static let ifUnmodifiedSince = HTTPHeaderFieldName(rawValue:"If-Unmodified-Since")!
  public static let keepAlive = HTTPHeaderFieldName(rawValue:"Keep-Alive")!
  public static let label = HTTPHeaderFieldName(rawValue:"Label")!
  public static let lastModified = HTTPHeaderFieldName(rawValue:"Last-Modified")!
  public static let link = HTTPHeaderFieldName(rawValue:"Link")!
  public static let location = HTTPHeaderFieldName(rawValue:"Location")!
  public static let lockToken = HTTPHeaderFieldName(rawValue:"Lock-Token")!
  public static let man = HTTPHeaderFieldName(rawValue:"Man")!
  public static let maxForwards = HTTPHeaderFieldName(rawValue:"Max-Forwards")!
  public static let mementoDatetime = HTTPHeaderFieldName(rawValue:"Memento-Datetime")!
  public static let meter = HTTPHeaderFieldName(rawValue:"Meter")!
  public static let mimeVersion = HTTPHeaderFieldName(rawValue:"MIME-Version")!
  public static let negotiate = HTTPHeaderFieldName(rawValue:"Negotiate")!
  public static let opt = HTTPHeaderFieldName(rawValue:"Opt")!
  public static let optionalWWWAuthenticate = HTTPHeaderFieldName(rawValue:"Optional-WWW-Authenticate")!
  public static let orderingType = HTTPHeaderFieldName(rawValue:"Ordering-Type")!
  public static let origin = HTTPHeaderFieldName(rawValue:"Origin")!
  public static let overwrite = HTTPHeaderFieldName(rawValue:"Overwrite")!
  public static let p3p = HTTPHeaderFieldName(rawValue:"P3P")!
  public static let pep = HTTPHeaderFieldName(rawValue:"PEP")!
  public static let picsLabel = HTTPHeaderFieldName(rawValue:"PICS-Label")!
  public static let pepInfo = HTTPHeaderFieldName(rawValue:"Pep-Info")!
  public static let position = HTTPHeaderFieldName(rawValue:"Position")!
  public static let pragma = HTTPHeaderFieldName(rawValue:"Pragma")!
  public static let prefer = HTTPHeaderFieldName(rawValue:"Prefer")!
  public static let preferenceApplied = HTTPHeaderFieldName(rawValue:"Preference-Applied")!
  public static let profileObject = HTTPHeaderFieldName(rawValue:"ProfileObject")!
  public static let `protocol` = HTTPHeaderFieldName(rawValue:"Protocol")!
  public static let protocolInfo = HTTPHeaderFieldName(rawValue:"Protocol-Info")!
  public static let protocolQuery = HTTPHeaderFieldName(rawValue:"Protocol-Query")!
  public static let protocolRequest = HTTPHeaderFieldName(rawValue:"Protocol-Request")!
  public static let proxyAuthenticate = HTTPHeaderFieldName(rawValue:"Proxy-Authenticate")!
  public static let proxyAuthenticationInfo = HTTPHeaderFieldName(rawValue:"Proxy-Authentication-Info")!
  public static let proxyAuthorization = HTTPHeaderFieldName(rawValue:"Proxy-Authorization")!
  public static let proxyFeatures = HTTPHeaderFieldName(rawValue:"Proxy-Features")!
  public static let proxyInstruction = HTTPHeaderFieldName(rawValue:"Proxy-Instruction")!
  public static let `public` = HTTPHeaderFieldName(rawValue:"Public")!
  public static let publicKeyPins = HTTPHeaderFieldName(rawValue:"Public-Key-Pins")!
  public static let publicKeyPinsReportOnly = HTTPHeaderFieldName(rawValue:"Public-Key-Pins-Report-Only")!
  public static let range = HTTPHeaderFieldName(rawValue:"Range")!
  public static let redirectRef = HTTPHeaderFieldName(rawValue:"Redirect-Ref")!
  public static let referer = HTTPHeaderFieldName(rawValue:"Referer")!
  public static let retryAfter = HTTPHeaderFieldName(rawValue:"Retry-After")!
  public static let safe = HTTPHeaderFieldName(rawValue:"Safe")!
  public static let scheduleReply = HTTPHeaderFieldName(rawValue:"Schedule-Reply")!
  public static let scheduleTag = HTTPHeaderFieldName(rawValue:"Schedule-Tag")!
  public static let secWebSocketAccept = HTTPHeaderFieldName(rawValue:"Sec-WebSocket-Accept")!
  public static let secWebSocketExtensions = HTTPHeaderFieldName(rawValue:"Sec-WebSocket-Extensions")!
  public static let secWebSocketKey = HTTPHeaderFieldName(rawValue:"Sec-WebSocket-Key")!
  public static let secWebSocketProtocol = HTTPHeaderFieldName(rawValue:"Sec-WebSocket-Protocol")!
  public static let secWebSocketVersion = HTTPHeaderFieldName(rawValue:"Sec-WebSocket-Version")!
  public static let securityScheme = HTTPHeaderFieldName(rawValue:"Security-Scheme")!
  public static let server = HTTPHeaderFieldName(rawValue:"Server")!
  public static let setCookie = HTTPHeaderFieldName(rawValue:"Set-Cookie")!
  public static let setProfile = HTTPHeaderFieldName(rawValue:"SetProfile")!
  public static let slug = HTTPHeaderFieldName(rawValue:"SLUG")!
  public static let soapAction = HTTPHeaderFieldName(rawValue:"SoapAction")!
  public static let statusURI = HTTPHeaderFieldName(rawValue:"Status-URI")!
  public static let strictTransportSecurity = HTTPHeaderFieldName(rawValue:"Strict-Transport-Security")!
  public static let surrogateCapability = HTTPHeaderFieldName(rawValue:"Surrogate-Capability")!
  public static let surrogateControl = HTTPHeaderFieldName(rawValue:"Surrogate-Control")!
  public static let tcn = HTTPHeaderFieldName(rawValue:"TCN")!
  public static let te = HTTPHeaderFieldName(rawValue:"TE")!
  public static let timeout = HTTPHeaderFieldName(rawValue:"Timeout")!
  public static let topic = HTTPHeaderFieldName(rawValue:"Topic")!
  public static let trailer = HTTPHeaderFieldName(rawValue:"Trailer")!
  public static let transferEncoding = HTTPHeaderFieldName(rawValue:"Transfer-Encoding")!
  public static let ttl = HTTPHeaderFieldName(rawValue:"TTL")!
  public static let urgency = HTTPHeaderFieldName(rawValue:"Urgency")!
  public static let uri = HTTPHeaderFieldName(rawValue:"URI")!
  public static let upgrade = HTTPHeaderFieldName(rawValue:"Upgrade")!
  public static let userAgent = HTTPHeaderFieldName(rawValue:"User-Agent")!
  public static let variantVary = HTTPHeaderFieldName(rawValue:"Variant-Vary")!
  public static let vary = HTTPHeaderFieldName(rawValue:"Vary")!
  public static let via = HTTPHeaderFieldName(rawValue:"Via")!
  public static let wwwAuthenticate = HTTPHeaderFieldName(rawValue:"WWW-Authenticate")!
  public static let wantDigest = HTTPHeaderFieldName(rawValue:"Want-Digest")!
  public static let warning = HTTPHeaderFieldName(rawValue:"Warning")!
  public static let xContentTypeOptions = HTTPHeaderFieldName(rawValue:"X-Content-Type-Options")!
  public static let xFrameOptions = HTTPHeaderFieldName(rawValue:"X-Frame-Options")!
  public static let accessControlAllowCredentials = HTTPHeaderFieldName(rawValue:"Access-Control-Allow-Credentials")!
  public static let accessControlAllowHeaders = HTTPHeaderFieldName(rawValue:"Access-Control-Allow-Headers")!
  public static let accessControlAllowMethods = HTTPHeaderFieldName(rawValue:"Access-Control-Allow-Methods")!
  public static let accessControlAllowOrigin = HTTPHeaderFieldName(rawValue:"Access-Control-Allow-Origin")!
  public static let accessControlMaxAge = HTTPHeaderFieldName(rawValue:"Access-Control-Max-Age")!
  public static let accessControlRequestMethod = HTTPHeaderFieldName(rawValue:"Access-Control-Request-Method")!
  public static let accessControlRequestHeaders = HTTPHeaderFieldName(rawValue:"Access-Control-Request-Headers")!
  public static let compliance = HTTPHeaderFieldName(rawValue:"Compliance")!
  public static let contentTransferEncoding = HTTPHeaderFieldName(rawValue:"Content-Transfer-Encoding")!
  public static let cost = HTTPHeaderFieldName(rawValue:"Cost")!
  public static let ediintFeatures = HTTPHeaderFieldName(rawValue:"EDIINT-Features")!
  public static let messageID = HTTPHeaderFieldName(rawValue:"Message-ID")!
  public static let nonCompliance = HTTPHeaderFieldName(rawValue:"Non-Compliance")!
  public static let optional = HTTPHeaderFieldName(rawValue:"Optional")!
  public static let resolutionHint = HTTPHeaderFieldName(rawValue:"Resolution-Hint")!
  public static let resolverLocation = HTTPHeaderFieldName(rawValue:"Resolver-Location")!
  public static let subOK = HTTPHeaderFieldName(rawValue:"SubOK")!
  public static let subst = HTTPHeaderFieldName(rawValue:"Subst")!
  public static let title = HTTPHeaderFieldName(rawValue:"Title")!
  public static let uaColor = HTTPHeaderFieldName(rawValue:"UA-Color")!
  public static let uaMedia = HTTPHeaderFieldName(rawValue:"UA-Media")!
  public static let uaPixels = HTTPHeaderFieldName(rawValue:"UA-Pixels")!
  public static let uaResolution = HTTPHeaderFieldName(rawValue:"UA-Resolution")!
  public static let uaWindowpixels = HTTPHeaderFieldName(rawValue:"UA-Windowpixels")!
  public static let version = HTTPHeaderFieldName(rawValue:"Version")!
  public static let xDeviceAccept = HTTPHeaderFieldName(rawValue:"X-Device-Accept")!
  public static let xDeviceAcceptCharset = HTTPHeaderFieldName(rawValue:"X-Device-Accept-Charset")!
  public static let xDeviceAcceptEncoding = HTTPHeaderFieldName(rawValue:"X-Device-Accept-Encoding")!
  public static let xDeviceAcceptLanguage = HTTPHeaderFieldName(rawValue:"X-Device-Accept-Language")!
  public static let xDeviceUserAgent = HTTPHeaderFieldName(rawValue:"X-Device-User-Agent")!
}
