/***************************************************************************************************
 URL+IDNA.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 
import Foundation

/// Let `URL` comform to IDNA
extension URL {
  // Validate domain label
  internal static func validate(domainLabel label:String,
                                usingSTD3ASCIIRules std3: Bool = true,
                                transitionalProcessing transitional:Bool = false) -> Bool {
    guard label == label.precomposedStringWithCanonicalMapping else { return false }
    
    let scalars: [UnicodeScalar] = Array(label.unicodeScalars)

    if scalars.count > 0 && scalars[0].value == 0x2D { return false }
    if scalars.count > 0 && UnicodeScalarSet.nonBaseCharacters.contains(scalars[0]) { return false }
    if scalars.count > 3 && scalars[2].value == 0x2D && scalars[3].value == 0x2D { return false }
    if scalars.count > 0 && scalars.last!.value == 0x2D { return false }
    for scalar in scalars {
      if scalar.value == 0x2E { return false }
      guard let status = scalar.idnaStatus(usingSTD3ASCIIRules:std3) else { return false }
      switch status {
      case .valid: break
      case .deviation: if transitional { return false }
      default: return false
      }
    }
    return true
  }
  
  /// Convert `domain`.
  /// Compromise between IDNA2003 and IDNA2008...?
  /// reference: http://www.unicode.org/reports/tr46/#Processing
  public static func convert(domain:String,
                             usingSTD3ASCIIRules std3:Bool = true,
                             transitionalProcessing transitional:Bool = false,
                             addingPunycodeEncoding punycode:Bool = true,
                             verifyDNSLength:Bool = true) -> String? {
    let input = domain.unicodeScalars
    var output: String = ""
    
    // mapping
    for scalar in input {
      guard let status = scalar.idnaStatus(usingSTD3ASCIIRules:std3) else { return nil }
      switch status {
      case .valid:
        output += String(scalar)
      case .ignored: break
      case .mapped(let results) where results != nil:
        output += String(String.UnicodeScalarView(results!))
      case .deviation(let results):
        if transitional {
          if results != nil {
            output += String(String.UnicodeScalarView(results!))
          }
        } else {
          output += String(scalar)
        }
      case .disallowed: return nil
      default: break
      }
    }
    
    // NFC
    output = output.precomposedStringWithCanonicalMapping
    
    // break
    var labels: [String] = output.components(separatedBy:".")
    
    // convert and validate
    for ii in 0..<labels.count {
      var label = labels[ii]
      if label.hasPrefix("xn--") {
        guard let decodedLabel = String(label[label.range(of:"xn--")!.upperBound..<label.endIndex]).removingPunycodeEncoding else {
          return nil
        }
        guard URL.validate(domainLabel:decodedLabel,
                           usingSTD3ASCIIRules:std3,
                           transitionalProcessing:transitional) else {
          return nil
        }
        label = decodedLabel
      } else {
        guard URL.validate(domainLabel:label,
                           usingSTD3ASCIIRules:std3,
                           transitionalProcessing:transitional) else {
          return nil
        }
      }
      
      if punycode {
        var containsNonASCII: Bool = false
        for scalar in label.unicodeScalars {
          if scalar.value > 0x007F {
            containsNonASCII = true
            break
          }
        }
        if containsNonASCII {
          guard let encodedLabel = label.addingPunycodeEncoding else { return nil }
          label = "xn--" + encodedLabel
        }
      }
      
      if verifyDNSLength {
        let length = label.unicodeScalars.count
        if length < 1 || length > 63 { return nil }
      }
      
      labels[ii] = label
    }
    
    // Combine
    output = labels.joined(separator:".")
    if verifyDNSLength {
      let max = output.hasSuffix(".") ? 254 : 253
      let length = output.unicodeScalars.count
      if length < 1 || length > max { return nil }
    }
    
    return output
  }
}

extension URL {
  /**
   Initializer using international string.
   
   - parameter:
     `internationalString` e.g.) "http://にっぽん。ＪＰ/☕︎.cgi?杯=2"
   */
  public init?(internationalString string:String) {
    guard let rangeOfColonSlashSlash = string.range(of:"://") else { return nil }
    let scheme = string[string.startIndex..<rangeOfColonSlashSlash.lowerBound].precomposedStringWithCompatibilityMapping.lowercased()
    if scheme.isEmpty { return nil }
    
    let indexOfFirstSlashAfterScheme: String.Index? = string.range(of:"/", range:rangeOfColonSlashSlash.upperBound..<string.endIndex)?.lowerBound
    
    // "user:password@host:port/path?query#fragment"
    // -> "user:password@host:port", "/path?query#fragment"
    let (authHostPort, pathQueryFragment) = ({ () -> (Substring, Substring) in
      let start = rangeOfColonSlashSlash.upperBound
      let idx = (indexOfFirstSlashAfterScheme != nil) ? indexOfFirstSlashAfterScheme! : string.endIndex
      return (string[start..<idx], string[idx..<string.endIndex])
    })()
    
    // "user:password@host:port"
    // -> "user:password", "host:port"
    let (auth, hostPort) = ({ (ahp:Substring) -> (Substring?, Substring) in
      let splitted = ahp.splitOnce(separator:"@")
      if splitted.1 == nil { return (nil, ahp) }
      return (.some(splitted.0), splitted.1!)
    })(authHostPort)
    
    // "user:password"
    // -> "user", "passsword"
    let (user, password):(Substring?, Substring?) = (auth == nil) ? (nil, nil) : ({
      let splitted = $0.splitOnce(separator:":")
      return (.some(splitted.0), splitted.1)
    })(auth!)
    if user != nil {
      guard user!.consists(of:.urlUserAllowed) else { return nil }
    }
    if password != nil {
      guard password!.consists(of:.urlPasswordAllowed) else { return nil }
    }
    
    // "host:port"
    // -> "host", "port"
    let (host, port) = hostPort.splitOnce(separator:":")
    if port != nil {
      guard let _ = UInt16(port!) else { return nil }
    }
    
    // "/path?query#fragment"
    // -> "/path?query", "fragment"
    let (pathQuery, fragment) = pathQueryFragment.splitOnce(separator:"#")
    
    // "/path?query"
    // -> "/path", "query"
    let (path, query) = pathQuery.splitOnce(separator:"?")
    
    
    // -----
    // Let's reconstruct URL.
    // -----
    var urlString = scheme + "://"
    
    // user & password
    if user != nil {
      urlString += user!
      if password != nil {
        urlString += ":" + password!
      }
      urlString += "@"
    }
    
    // host
    guard let convertedHost = URL.convert(domain:String(host)) else { return nil }
    urlString += convertedHost
    
    // port
    if port != nil { urlString += ":" + port! }
    
    // path
    guard let encodedPath = path.addingPercentEncoding(withAllowedUnicodeScalars:.urlPathAllowed) else {
      return nil
    }
    urlString += encodedPath
    
    // query
    if query != nil {
      guard let encodedQuery = query!.addingPercentEncoding(withAllowedUnicodeScalars:.urlQueryAllowed) else {
        return nil
      }
      urlString += "?" + encodedQuery
    }
    
    // fragment
    if fragment != nil {
      guard let encodedFragment = fragment!.addingPercentEncoding(withAllowedUnicodeScalars:.urlFragmentAllowed) else {
        return nil
      }
      urlString += "#" + encodedFragment
    }
    
    self.init(string:urlString)
  }
}
