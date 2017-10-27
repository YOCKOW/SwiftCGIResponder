/***************************************************************************************************
 CertainRange.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/**
 
 # CertainRange
 Wrapper for `ClosedRange`, `PartialRangeFrom`, `PartialRangeThrough`, `PartialRangeUpTo` and `Range`.
 This is expected to be used in `RangeSet`.
 
 */
internal enum CertainRange<Bound> where Bound: Comparable {
  case empty
  case universal // all elements are contained.
  case closedRange(ClosedRange<Bound>)
  case range(Range<Bound>)
  case partialRangeFrom(PartialRangeFrom<Bound>)
  case partialRangeThrough(PartialRangeThrough<Bound>)
  case partialRangeUpTo(PartialRangeUpTo<Bound>)
  
  init<R>(_ someRange:R) where R: UncountableRangeExpression, R.UncountableBound == Bound {
    switch someRange {
    case let closedRange as ClosedRange<Bound>: self = closedRange.isEmpty ? .empty : .closedRange(closedRange)
    case let range as Range<Bound>: self = range.isEmpty ? .empty : .range(range)
    case let partialRangeFrom as PartialRangeFrom<Bound>: self = .partialRangeFrom(partialRangeFrom)
    case let partialRangeThrough as PartialRangeThrough<Bound>: self = .partialRangeThrough(partialRangeThrough)
    case let partialRangeUpTo as PartialRangeUpTo<Bound>: self = .partialRangeUpTo(partialRangeUpTo)
    default: fatalError("Unknown kind of range.")
    }
  }
  
  init<R>(_ someRange:R) where R: CountableRangeExpression, R.CountableBound == Bound, Bound: Strideable, Bound.Stride: SignedInteger {
    switch someRange {
    case let countableClosedRange as CountableClosedRange<Bound>:
      self.init(countableClosedRange.closedRange)
    case let countableRange as CountableRange<Bound>:
      self.init(countableRange.range)
    case let countablePartialRangeFrom as CountablePartialRangeFrom<Bound>:
      self.init(countablePartialRangeFrom.partialRangeFrom)
    default:
      fatalError("Unknown kind of range.")
    }
  }
}

extension CertainRange {
  /// Returns `true` if `self` contains `element`
  func contains(_ element:Bound) -> Bool {
    switch self {
    case .empty: return false
    case .universal: return true
    case .closedRange(let closedRange): return closedRange.contains(element)
    case .range(let range): return range.contains(element)
    case .partialRangeFrom(let partialRangeFrom): return partialRangeFrom.contains(element)
    case .partialRangeThrough(let partialRangeThrough): return partialRangeThrough.contains(element)
    case .partialRangeUpTo(let partialRangeUpTo): return partialRangeUpTo.contains(element)
    }
  }
  
  static func ~=(lhs:CertainRange, rhs:Bound) -> Bool {
    return lhs.contains(rhs)
  }
}

extension CertainRange: Equatable {
  static func ==(lhs: CertainRange<Bound>, rhs: CertainRange<Bound>) -> Bool {
    switch (lhs, rhs) {
    case (.empty, .empty): return true
    case (.empty, .closedRange(let cr)) where cr.isEmpty: return true
    case (.empty, .range(let range)) where range.isEmpty: return true
    case (.closedRange(let cr), .empty) where cr.isEmpty: return true
    case (.range(let range), .empty) where range.isEmpty: return true
    case (.universal, .universal): return true
    case (.closedRange(let lcr), .closedRange(let rcr)):
      return lcr.lowerBound == rcr.lowerBound && lcr.upperBound == rcr.upperBound
    case (.range(let lr), .range(let rr)):
      return lr.lowerBound == rr.lowerBound && lr.upperBound == rr.upperBound
    case (.partialRangeFrom(let lprf), .partialRangeFrom(let rprf)):
      return lprf.lowerBound == rprf.lowerBound
    case (.partialRangeThrough(let lprt), .partialRangeThrough(let rprt)):
      return lprt.upperBound == rprt.upperBound
    case (.partialRangeUpTo(let lprut), .partialRangeUpTo(let rprut)):
      return lprut.upperBound == rprut.upperBound
    default: return false
    }
  }
}

extension CertainRange: Comparable {
  // How to compare?
  // * First, compare lower bounds. Next, compare upper bounds if the lower bounds are equal.
  // * .empty < [others] < .universal
  // * `PartialRangeFrom`'s upper bound is +∞
  // * `PartialRange(Through|UpTo)`'s lower bound is -∞
  static func <(lhs: CertainRange<Bound>, rhs: CertainRange<Bound>) -> Bool {
    guard lhs != rhs else { return false }
    
    switch (lhs, rhs) {
    
    case (.empty, _): return true
    case (_, .empty): return false
    case (.universal, _): return false
    case (_, .universal): return true
    
    // `lhs` is ClosedRange<Bound>
    case (.closedRange(let lcr), .closedRange(let rcr)):
      if lcr.lowerBound == rcr.lowerBound { return lcr.upperBound < rcr.upperBound }
      else { return lcr.lowerBound < rcr.lowerBound }
    case (.closedRange(let lcr), .range(let rr)):
      if lcr.lowerBound == rr.lowerBound { return lcr.upperBound < rr.upperBound }
      else { return lcr.lowerBound < rr.lowerBound }
    case (.closedRange(let lcr), .partialRangeFrom(let rprf)):
      if lcr.lowerBound == rprf.lowerBound { return true }
      else { return lcr.lowerBound < rprf.lowerBound }
    case (.closedRange, _):
      return false
    
    // `lhs` is Range<Bound>
    case (.range(let lr), .closedRange(let rcr)):
      if lr.lowerBound == rcr.lowerBound { return lr.upperBound <= rcr.upperBound } // yes, `<=`
      else { return lr.lowerBound < rcr.lowerBound }
    case (.range(let lr), .range(let rr)):
      if lr.lowerBound == rr.lowerBound { return lr.upperBound < rr.upperBound }
      else { return lr.lowerBound < rr.lowerBound }
    case (.range(let lr), .partialRangeFrom(let rprf)):
      if lr.lowerBound == rprf.lowerBound { return true }
      else { return lr.lowerBound < rprf.lowerBound }
    case (.range, _):
      return false
      
    // `lhs` is PartialRangeFrom<Bound>
    case (.partialRangeFrom(let lprf), .closedRange(let rcr)):
      if lprf.lowerBound == rcr.lowerBound { return false }
      else { return lprf.lowerBound < rcr.lowerBound }
    case (.partialRangeFrom(let lprf), .range(let rr)):
      if lprf.lowerBound == rr.lowerBound { return false }
      else { return lprf.lowerBound < rr.lowerBound }
    case (.partialRangeFrom(let lprf), .partialRangeFrom(let rprf)):
      return lprf.lowerBound < rprf.lowerBound
    case (.partialRangeFrom, _):
      return false
      
    // `lhs` is PartialRangeThrough<Bound>
    case (.partialRangeThrough(let lprt), .partialRangeThrough(let rprt)):
      return lprt.upperBound < rprt.upperBound
    case (.partialRangeThrough(let lprt), .partialRangeUpTo(let rprut)):
      return lprt.upperBound < rprut.upperBound
    case (.partialRangeThrough, _):
      return true
      
    // `lhs` is PartialRangeUpTo<Bound>
    case (.partialRangeUpTo(let lprut), .partialRangeThrough(let rprt)):
      return lprut.upperBound <= rprt.upperBound // yes, `<=`
    case (.partialRangeUpTo(let lprut), .partialRangeUpTo(let rprut)):
      return lprut.upperBound < rprut.upperBound
    case (.partialRangeUpTo, _):
      return true
      
    }
  }
}

extension CertainRange {
  /// Returns joined range or `nil` if `self` doesn't overlap `other`
  func joined(with other:CertainRange<Bound>) -> CertainRange<Bound>? {
    switch (self, other) {
    
    case (.empty, _):
      return other
    case (.universal, _):
      return .universal
    case (_, .empty):
      return self
    case (_, .universal):
      return .universal
    
    // If same kind of ranges...
    
    case (.closedRange(let cr1), .closedRange(let cr2)) where cr1.overlaps(cr2):
      return .closedRange(min(cr1.lowerBound, cr2.lowerBound)...max(cr1.upperBound, cr2.upperBound))
    case (.range(let range1), .range(let range2)) where range1.overlaps(range2):
      return .range(min(range1.lowerBound, range2.lowerBound)..<max(range1.upperBound, range2.upperBound))
    case (.partialRangeFrom(let prf1), .partialRangeFrom(let prf2)):
      return .partialRangeFrom(min(prf1.lowerBound, prf2.lowerBound)...)
    case (.partialRangeThrough(let prt1), .partialRangeThrough(let prt2)):
      return .partialRangeThrough(...max(prt1.upperBound, prt2.upperBound))
    case (.partialRangeUpTo(let prut1), .partialRangeUpTo(let prut2)):
      return .partialRangeUpTo(..<max(prut1.upperBound, prut2.upperBound))
    
    // Workarounds for "Matching a generic value in multiple patterns is not yet supported; use separate cases instead"
    
    // ClosedRange + Range
    case (.closedRange(let cr), .range(let range)) where cr.overlaps(range):
      if cr.upperBound >= range.upperBound {
        return .closedRange(min(cr.lowerBound, range.lowerBound)...cr.upperBound)
      } else {
        return .range(min(cr.lowerBound, range.lowerBound)..<range.upperBound)
      }
    case (.range(let range), .closedRange(let cr)) where cr.overlaps(range):
        if cr.upperBound >= range.upperBound {
          return .closedRange(min(cr.lowerBound, range.lowerBound)...cr.upperBound)
        } else {
          return .range(min(cr.lowerBound, range.lowerBound)..<range.upperBound)
      }
    case (.closedRange(let cr), .range(let range)) where range.upperBound == cr.lowerBound:
      return .closedRange(range.lowerBound...cr.upperBound)
    case (.range(let range), .closedRange(let cr)) where range.upperBound == cr.lowerBound:
      return .closedRange(range.lowerBound...cr.upperBound)
      
      
    // ClosedRange + PartialRangeFrom
    case (.closedRange(let cr), .partialRangeFrom(let prf)) where cr.upperBound >= prf.lowerBound:
      return .partialRangeFrom(min(cr.lowerBound, prf.lowerBound)...)
    case (.partialRangeFrom(let prf), .closedRange(let cr)) where cr.upperBound >= prf.lowerBound:
      return .partialRangeFrom(min(cr.lowerBound, prf.lowerBound)...)
    
    // ClosedRange + PartialRangeThrough
    case (.closedRange(let cr), .partialRangeThrough(let prt)) where cr.lowerBound <= prt.upperBound:
      return .partialRangeThrough(...max(cr.upperBound, prt.upperBound))
    case (.partialRangeThrough(let prt), .closedRange(let cr)) where cr.lowerBound <= prt.upperBound:
      return .partialRangeThrough(...max(cr.upperBound, prt.upperBound))
      
    // ClosedRange + PartialRangeUpTo
    case (.closedRange(let cr), .partialRangeUpTo(let prut)) where cr.lowerBound <= prut.upperBound:
      if cr.upperBound >= prut.upperBound { return .partialRangeThrough(...cr.upperBound) }
      else { return .partialRangeUpTo(..<prut.upperBound) }
    case (.partialRangeUpTo(let prut), .closedRange(let cr)) where cr.lowerBound <= prut.upperBound:
      if cr.upperBound >= prut.upperBound { return .partialRangeThrough(...cr.upperBound) }
      else { return .partialRangeUpTo(..<prut.upperBound) }
    
    // Range + PartialRangeFrom
    case (.range(let range), .partialRangeFrom(let prf)) where range.upperBound <= prf.lowerBound:
      return .partialRangeFrom(min(range.lowerBound, prf.lowerBound)...)
    case (.partialRangeFrom(let prf), .range(let range)) where range.upperBound <= prf.lowerBound:
      return .partialRangeFrom(min(range.lowerBound, prf.lowerBound)...)
      
    // Range + PartialRangeThrough
    case (.range(let range), .partialRangeThrough(let prt)) where range.lowerBound <= prt.upperBound:
      if range.upperBound > prt.upperBound { return .partialRangeUpTo(..<range.upperBound) }
      else { return .partialRangeThrough(...prt.upperBound) }
    case (.partialRangeThrough(let prt), .range(let range)) where range.lowerBound <= prt.upperBound:
      if range.upperBound > prt.upperBound { return .partialRangeUpTo(..<range.upperBound) }
      else { return .partialRangeThrough(...prt.upperBound) }
      
    // Range + PartialRangeUpTo
    case (.range(let range), .partialRangeUpTo(let prut)) where range.lowerBound <= prut.upperBound:
      return .partialRangeUpTo(..<max(range.upperBound, prut.upperBound))
    case (.partialRangeUpTo(let prut), .range(let range)) where range.lowerBound <= prut.upperBound:
      return .partialRangeUpTo(..<max(range.upperBound, prut.upperBound))
    
    // PartialRangeFrom + PartialRangeThrough
    case (.partialRangeFrom(let prf), .partialRangeThrough(let prt)) where prf.lowerBound >= prt.upperBound:
      return .universal
    case (.partialRangeThrough(let prt), .partialRangeFrom(let prf)) where prf.lowerBound >= prt.upperBound:
      return .universal
  
    // PartialRangeThrough + PartialRangeUpTo
    case (.partialRangeThrough(let prt), .partialRangeUpTo(let prut)):
      if prt.upperBound >= prut.upperBound { return .partialRangeThrough(...prt.upperBound) }
      else { return .partialRangeUpTo(..<prut.upperBound) }
    case (.partialRangeUpTo(let prut), .partialRangeThrough(let prt)):
      if prt.upperBound >= prut.upperBound { return .partialRangeThrough(...prt.upperBound) }
      else { return .partialRangeUpTo(..<prut.upperBound) }
    
    
    default:
      return nil
    }
  }
}
