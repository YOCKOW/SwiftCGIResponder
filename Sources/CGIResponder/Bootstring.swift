/***************************************************************************************************
 Bootstring.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/
 


public enum BootstringError : Error {
  case invalidParameters
  case invalidInput
  case overflow
  case unexpectedError(message:String)
}

/**
 
 # Bootstring
 Bootstring is one of string encoding methods. Punycode is an instance of Bootstring.
 reference: https://tools.ietf.org/html/rfc3492
 
 */
public struct Bootstring {
  public var base: Int
  public var minimumThreshold: Int // `tmin` in RFC 3492
  public var maximumThreshold: Int // `tmax` in RFC 3492
  public var skew: Int
  public var damp: Int
  public var initialBias: Int // `initial_bias` in RFC 3492
  public var initialScalar: UnicodeScalar // `iniaial_n` in RFC 3492
  
  public var additionalBasicScalars: Set<UnicodeScalar>? // not in use for Punycode
  public var delimiter: UnicodeScalar
  public var digitEncoder: (Int) -> UnicodeScalar?
  public var digitDecoder: (UnicodeScalar) -> Int?
  
  public init(base:Int,
              minimumThreshold:Int,
              maximumThreshold:Int,
              skew:Int,
              damp:Int,
              initialBias:Int,
              initialScalar:UnicodeScalar,
              additionalBasicScalars: Set<UnicodeScalar>?,
              delimiter:UnicodeScalar,
              digitEncoder:@escaping (Int) -> UnicodeScalar?,
              digitDecoder:@escaping (UnicodeScalar) -> Int?) {
    self.base = base
    self.minimumThreshold = minimumThreshold
    self.maximumThreshold = maximumThreshold
    self.skew = skew
    self.damp = damp
    self.initialBias = initialBias
    self.initialScalar = initialScalar
    self.additionalBasicScalars = additionalBasicScalars
    self.delimiter = delimiter
    self.digitEncoder = digitEncoder
    self.digitDecoder = digitDecoder
  }
  
  public var isValid: Bool {
    if self.minimumThreshold < 0 { return false }
    if self.minimumThreshold > self.maximumThreshold { return false }
    if self.maximumThreshold > self.base - 1 { return false }
    if self.skew < 1 { return false }
    if self.damp < 2 { return false }
    if self.initialBias % self.base > self.base - self.minimumThreshold { return false }
    return true
  }
}

extension Bootstring {
  public static let punycode = Bootstring(
    base:36,
    minimumThreshold:1,
    maximumThreshold:26,
    skew:38,
    damp:700,
    initialBias:72,
    initialScalar:UnicodeScalar(0x80),
    additionalBasicScalars: nil,
    delimiter:UnicodeScalar("-")!,
    digitEncoder: {
      switch $0 {
      case 0..<26: return UnicodeScalar($0 + 0x61)! // a-z
      case 26..<36: return UnicodeScalar($0 - 26 + 0x30)! // 0-9
      default: return nil
      }
    },
    digitDecoder: {
      switch $0.value {
      case 0x30...0x39: return Int($0.value - 0x30 + 26) // 0-9
      case 0x41...0x5A: return Int($0.value - 0x41) // A-Z
      case 0x61...0x7A: return Int($0.value - 0x61) // a-z
      default: return nil
      }
    }
  )
}

extension Bootstring {
  fileprivate func adapt(delta:Int,
                         numberOfHandledCodePoints numpoints:Int,
                         firstTime:Bool) -> Int {
    // reference: https://tools.ietf.org/html/rfc3492#section-6.1
    var delta = delta / ((firstTime) ?  self.damp : 2)
    delta += delta / numpoints
    
    let minimumDelta = ((self.base - self.minimumThreshold) * self.maximumThreshold) / 2
    var kk: Int = 0
    while delta > minimumDelta {
      delta /= self.base - self.minimumThreshold
      kk += self.base
    }
    return kk + (((self.base - self.minimumThreshold + 1) * delta) / (delta + self.skew))
  }
}

extension UnicodeScalar {
  fileprivate func isBasicScalar(in bootstring:Bootstring) -> Bool {
    if self < bootstring.initialScalar { return true }
    if let additionalBasicScalars = bootstring.additionalBasicScalars {
      return additionalBasicScalars.contains(self)
    }
    return false
  }
}

extension Bootstring {
  public func decode(_ string:String) throws -> String {
    if !self.isValid { throw BootstringError.invalidParameters }
    
    // reference: https://tools.ietf.org/html/rfc3492#section-6.2
    let input:[UnicodeScalar] = Array(string.unicodeScalars)
    var output:[UnicodeScalar] = []
    
    var lastIndexOfDelimiter: Int = 0
    for ii in (0..<input.count).reversed() {
      if input[ii] == self.delimiter {
        lastIndexOfDelimiter = ii
        break
      }
    }
    
    /*
     Quoted from RFC 3492 #Section 6.2:
     consume all code points before the last delimiter (if there is one)
     and copy them to output, fail on any non-basic code point
     if more than zero code points were consumed then consume one more
     (which will be the last delimiter)
     */
    for ii in 0..<lastIndexOfDelimiter {
      let scalar = input[ii]
      guard scalar.isBasicScalar(in:self) else { throw BootstringError.invalidInput }
      output.append(input[ii])
    }
    
    // From here, starts the decoding!
    var nn: UnicodeScalar = self.initialScalar
    var bias: Int = self.initialBias
    var next: Int = (lastIndexOfDelimiter == 0) ? 0 : lastIndexOfDelimiter + 1
    var index: Int = 0
    while next < input.count {
      let oldIndex: Int = index
      var ww: Int = 1
      var kk: Int = self.base
      while true {
        guard next < input.count else { throw BootstringError.invalidInput }
        guard let digit = self.digitDecoder(input[next]) else { throw BootstringError.invalidInput }
        guard digit < self.base else { throw BootstringError.invalidInput }
        guard digit <= (Int.max - index) / ww else { throw BootstringError.overflow }
        
        next += 1
        index += digit * ww
        
        let tt: Int
        switch kk {
        case 0...(bias + self.minimumThreshold): tt = self.minimumThreshold
        case (bias + self.maximumThreshold)...Int.max: tt = self.maximumThreshold
        default: tt = kk - bias
        }
        
        if digit < tt { break }
        guard ww <= Int.max / (self.base - tt) else { throw BootstringError.overflow }
        
        ww *= self.base - tt
        kk += self.base
      }
      
      bias = self.adapt(delta:index - oldIndex,
                        numberOfHandledCodePoints:output.count + 1,
                        firstTime: oldIndex == 0)
      guard index / (output.count + 1) <= (Int.max - Int(nn.value)) else {
        throw BootstringError.overflow
      }
      guard let _nn = UnicodeScalar(Int(nn.value) + (index / (output.count + 1))) else {
        throw BootstringError.invalidInput
      }
      nn = _nn
      index %= (output.count + 1)
      
      guard self.digitDecoder(nn) == nil else { throw BootstringError.invalidInput }
      output.insert(nn, at:index)
      index += 1
    }
    
    return String(String.UnicodeScalarView(output))
  }
  
  public func encode(_ string:String) throws -> String {
    if !self.isValid { throw BootstringError.invalidParameters }
    
    // reference: https://tools.ietf.org/html/rfc3492#section-6.3
    let input:[UnicodeScalar] = Array(string.unicodeScalars)
    var output:[UnicodeScalar] = []
    var nonBasicScalars:[(scalar:UnicodeScalar, index:Int)] = []
    
    for ii in 0..<input.count {
      let scalar = input[ii]
      if scalar.isBasicScalar(in:self) {
        output.append(scalar)
      } else {
        nonBasicScalars.append((scalar:scalar, index:ii))
      }
    }
    
    // sort by value of scalar
    nonBasicScalars.sort {
      if $0.scalar < $1.scalar { return true }
      else if $0.scalar > $1.scalar { return false }
      else { return $0.index < $1.index }
    }
    
    let numberOfBasicCodePoints: Int = output.count
    var numberOfHandledCodePoints: Int = numberOfBasicCodePoints
    if numberOfBasicCodePoints > 0 { output.append(self.delimiter) }
    
    // Encoding Loop
    var bias: Int = self.initialBias
    var oldIndex: Int = 0
    for ii in 0..<nonBasicScalars.count {
      let info = nonBasicScalars[ii]
      let target: Int = Int(info.scalar.value)
      let targetIndex: Int = info.index
      let basis: Int = Int(((ii == 0) ? self.initialScalar : nonBasicScalars[ii - 1].scalar).value)
      let basisIndex: Int = (ii == 0) ? 0 : nonBasicScalars[ii - 1].index
      // target >= basis is always true because `nonBasicScalars` has been sorted
      // targetIndex < basisIndex is true when target == basis, likewise
      
      // Calculate delta
      var delta: Int = 0
      if target == basis {
        for jj in basisIndex..<targetIndex {
          if Int(input[jj].value) < target || input[jj].isBasicScalar(in:self)  {
            delta += 1
            // NEVER overflow: delta <= targetIndex - basisIndex
          }
        }
      } else {
        if ii != 0 {
          for jj in basisIndex..<input.count {
            if Int(input[jj].value) < basis || input[jj].isBasicScalar(in:self)  {
              delta += 1
              // NEVER overflow: delta <= input.count
            }
          }
          guard delta < Int.max else { throw BootstringError.overflow }
          delta += 1
        }
        for jj in 0..<targetIndex {
          if Int(input[jj].value) < target || input[jj].isBasicScalar(in:self)  {
            guard delta < Int.max else { throw BootstringError.overflow }
            delta += 1
          }
        }
        
        // adjustment
        let diff: Int = target - basis - ((ii == 0) ? 0 : 1)
        guard diff <= (Int.max - delta) / (numberOfHandledCodePoints + 1) else {
          throw BootstringError.overflow
        }
        delta += diff * (numberOfHandledCodePoints + 1)
      }
      
      // convert delta to variable-lenth integer
      var qq: Int = delta
      var kk: Int = self.base
      while true {
        defer { kk += self.base }
        let tt: Int
        switch kk {
        case 0...(bias + self.minimumThreshold): tt = self.minimumThreshold
        case (bias + self.maximumThreshold)...Int.max: tt = self.maximumThreshold
        default: tt = kk - bias
        }
        if qq < tt { break }
        
        guard let digit = self.digitEncoder(tt + (qq - tt) % (self.base - tt)) else {
          throw BootstringError.invalidInput
        }
        output.append(digit)
        qq = (qq - tt) / (self.base - tt)
      }
      guard let digit = self.digitEncoder(qq) else { throw BootstringError.invalidInput }
      output.append(digit)
      
      numberOfHandledCodePoints += 1
      
      bias = self.adapt(delta:delta,
                        numberOfHandledCodePoints:numberOfHandledCodePoints,
                        firstTime:ii == 0)
    }
    
    return String(String.UnicodeScalarView(output))
  }
}


extension String {
  public func addingBootstringEncoding(with encoder:Bootstring) -> String? {
    return try? encoder.encode(self)
  }
  public func removingBootstringEncoding(with decoder:Bootstring) -> String? {
    return try? decoder.decode(self)
  }
  public var addingPunycodeEncoding: String? {
    return self.addingBootstringEncoding(with:Bootstring.punycode)
  }
  public var removingPunycodeEncoding: String? {
    return self.removingBootstringEncoding(with:Bootstring.punycode)
  }
}
