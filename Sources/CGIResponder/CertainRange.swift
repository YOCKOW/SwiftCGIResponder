/***************************************************************************************************
 CertainRange.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/**
 
 # CertainRange
 Wrapper for `ClosedRange`, `LeftOpenRange`, `OpenRange`, `PartialRangeFrom`, `PartialRangeGreaterThan`,
 `PartialRangeThrough`, `PartialRangeUpTo` and `Range`.
 This is expected to be used in `Multirange`.
 
 */
internal enum CertainRange<Bound> where Bound: Comparable {
  case empty
  case universal // all elements are contained.
  case closedRange(ClosedRange<Bound>)
  case leftOpenRange(LeftOpenRange<Bound>)
  case openRange(OpenRange<Bound>)
  case range(Range<Bound>)
  case partialRangeFrom(PartialRangeFrom<Bound>)
  case partialRangeGreaterThan(PartialRangeGreaterThan<Bound>)
  case partialRangeThrough(PartialRangeThrough<Bound>)
  case partialRangeUpTo(PartialRangeUpTo<Bound>)
  
  init<R>(_ someRange:R) where R: UncountableRangeExpression, R.UncountableBound == Bound {
    switch someRange {
    case let closedRange as ClosedRange<Bound>: self = closedRange.isEmpty ? .empty : .closedRange(closedRange)
    case let leftOpenRange as LeftOpenRange<Bound>: self = leftOpenRange.isEmpty ? .empty : .leftOpenRange(leftOpenRange)
    case let openRange as OpenRange<Bound>: self = openRange.isEmpty ? .empty : .openRange(openRange)
    case let range as Range<Bound>: self = range.isEmpty ? .empty : .range(range)
    case let partialRangeFrom as PartialRangeFrom<Bound>: self = .partialRangeFrom(partialRangeFrom)
    case let partialRangeGreaterThan as PartialRangeGreaterThan<Bound>: self = .partialRangeGreaterThan(partialRangeGreaterThan)
    case let partialRangeThrough as PartialRangeThrough<Bound>: self = .partialRangeThrough(partialRangeThrough)
    case let partialRangeUpTo as PartialRangeUpTo<Bound>: self = .partialRangeUpTo(partialRangeUpTo)
    default: fatalError("Unknown kind of range.")
    }
  }
  
  init(_ value:Bound) {
    self.init(ClosedRange<Bound>(uncheckedBounds:(lower:value, upper:value)))
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
    case .leftOpenRange(let leftOpenRange): return leftOpenRange.contains(element)
    case .openRange(let openRange): return openRange.contains(element)
    case .range(let range): return range.contains(element)
    case .partialRangeFrom(let partialRangeFrom): return partialRangeFrom.contains(element)
    case .partialRangeGreaterThan(let partialRangeGreaterThan): return partialRangeGreaterThan.contains(element)
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
    case (.empty, .leftOpenRange(let lor)) where lor.isEmpty: return true
    case (.empty, .openRange(let or)) where or.isEmpty: return true
    case (.empty, .range(let range)) where range.isEmpty: return true
    case (.closedRange(let cr), .empty) where cr.isEmpty: return true
    case (.leftOpenRange(let lor), .empty) where lor.isEmpty: return true
    case (.openRange(let or), .empty) where or.isEmpty: return true
    case (.range(let range), .empty) where range.isEmpty: return true
    case (.universal, .universal): return true
    case (.closedRange(let lcr), .closedRange(let rcr)):
      return lcr.lowerBound == rcr.lowerBound && lcr.upperBound == rcr.upperBound
    case (.leftOpenRange(let llor), .leftOpenRange(let rlor)):
      return llor == rlor
    case (.openRange(let lor), .openRange(let ror)):
      return lor == ror
    case (.range(let lr), .range(let rr)):
      return lr.lowerBound == rr.lowerBound && lr.upperBound == rr.upperBound
    case (.partialRangeFrom(let lprf), .partialRangeFrom(let rprf)):
      return lprf.lowerBound == rprf.lowerBound
    case (.partialRangeGreaterThan(let lprgt), .partialRangeGreaterThan(let rprgt)):
      return lprgt.lowerBound == rprgt.lowerBound
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
  // * .universal < [others] < .empty
  // * `PartialRange(From|GreaterThan)`'s upper bound is +∞
  // * `PartialRange(Through|UpTo)`'s lower bound is -∞
  static func <(lhs: CertainRange<Bound>, rhs: CertainRange<Bound>) -> Bool {
    guard lhs != rhs else { return false }
    
    switch (lhs, rhs) {
    
    case (.empty, _): return false
    case (_, .empty): return true
    case (.universal, _): return true
    case (_, .universal): return false
    
    // `lhs` is ClosedRange<Bound>
    case (.closedRange(let lcr), .closedRange(let rcr)):
      if lcr.lowerBound == rcr.lowerBound { return lcr.upperBound < rcr.upperBound }
      else { return lcr.lowerBound < rcr.lowerBound }
    case (.closedRange(let lcr), .leftOpenRange(let rlor)):
      return lcr.lowerBound <= rlor.lowerBound // Lower bound of `LeftOpenRange` is not included in the range.
    case (.closedRange(let lcr), .openRange(let ror)):
      return lcr.lowerBound <= ror.lowerBound // Lower bound of `OpenRange` is not included in the range.
    case (.closedRange(let lcr), .range(let rr)):
      if lcr.lowerBound == rr.lowerBound { return lcr.upperBound < rr.upperBound }
      else { return lcr.lowerBound < rr.lowerBound }
    case (.closedRange(let lcr), .partialRangeFrom(let rprf)):
      if lcr.lowerBound == rprf.lowerBound { return true }
      else { return lcr.lowerBound < rprf.lowerBound }
    case (.closedRange(let lcr), .partialRangeGreaterThan(let rprgt)):
      return lcr.lowerBound <= rprgt.lowerBound // Lower bound of `PartialRangeGreaterThan` is not included in the range.
    case (.closedRange, _):
      return false
    
    // `lhs` is LeftOpenRange<Bound>
    case (.leftOpenRange(let llor), .closedRange(let rcr)):
      return llor.lowerBound < rcr.lowerBound
    case (.leftOpenRange(let llor), .leftOpenRange(let rlor)):
      if llor.lowerBound == rlor.lowerBound { return llor.upperBound < rlor.upperBound }
      else { return llor.lowerBound < rlor.lowerBound }
    case (.leftOpenRange(let llor), .openRange(let ror)):
      if llor.lowerBound == ror.lowerBound { return llor.upperBound <= ror.upperBound }
      else { return llor.lowerBound < ror.lowerBound }
    case (.leftOpenRange(let llor), .range(let rr)):
      return llor.lowerBound < rr.lowerBound
    case (.leftOpenRange(let llor), .partialRangeFrom(let rprf)):
      return llor.lowerBound < rprf.lowerBound
    case (.leftOpenRange(let llor), .partialRangeGreaterThan(let rprgt)):
      if llor.lowerBound == rprgt.lowerBound { return true }
      else { return llor.lowerBound < rprgt.lowerBound }
    case (.leftOpenRange, _):
      return false
      
    // `lhs` is OpenRange<Bound>
    case (.openRange(let lor), .closedRange(let rcr)):
      return lor.lowerBound < rcr.lowerBound
    case (.openRange(let lor), .leftOpenRange(let  rlor)):
      if lor.lowerBound == rlor.lowerBound { return lor.upperBound < rlor.upperBound }
      else { return lor.lowerBound < rlor.lowerBound }
    case (.openRange(let lor), .openRange(let ror)):
      if lor.lowerBound == ror.lowerBound { return lor.upperBound < ror.upperBound }
      else { return lor.lowerBound < ror.lowerBound }
    case (.openRange(let lor), .range(let rr)):
      return lor.lowerBound < rr.lowerBound
    case (.openRange(let lor), .partialRangeFrom(let rprf)):
      return lor.lowerBound < rprf.lowerBound
    case (.openRange(let lor), .partialRangeGreaterThan(let rprgt)):
      if lor.lowerBound == rprgt.lowerBound { return true }
      else { return lor.lowerBound < rprgt.lowerBound }
    case (.openRange, _):
      return false
      
    // `lhs` is Range<Bound>
    case (.range(let lr), .closedRange(let rcr)):
      if lr.lowerBound == rcr.lowerBound { return lr.upperBound <= rcr.upperBound } // yes, `<=`
      else { return lr.lowerBound < rcr.lowerBound }
    case (.range(let lr), .leftOpenRange(let rlor)):
      return lr.lowerBound <= rlor.lowerBound
    case (.range(let lr), .openRange(let ror)):
      return lr.lowerBound <= ror.lowerBound
    case (.range(let lr), .range(let rr)):
      if lr.lowerBound == rr.lowerBound { return lr.upperBound < rr.upperBound }
      else { return lr.lowerBound < rr.lowerBound }
    case (.range(let lr), .partialRangeFrom(let rprf)):
      if lr.lowerBound == rprf.lowerBound { return true }
      else { return lr.lowerBound < rprf.lowerBound }
    case (.range(let lr), .partialRangeGreaterThan(let rprgt)):
      return lr.lowerBound <= rprgt.lowerBound
    case (.range, _):
      return false
      
    // `lhs` is PartialRangeFrom<Bound>
    case (.partialRangeFrom(let lprf), .closedRange(let rcr)):
      if lprf.lowerBound == rcr.lowerBound { return false }
      else { return lprf.lowerBound < rcr.lowerBound }
    case (.partialRangeFrom(let lprf), .leftOpenRange(let rlor)):
      return lprf.lowerBound <= rlor.lowerBound
    case (.partialRangeFrom(let lprf), .openRange(let ror)):
      return lprf.lowerBound <= ror.lowerBound
    case (.partialRangeFrom(let lprf), .range(let rr)):
      if lprf.lowerBound == rr.lowerBound { return false }
      else { return lprf.lowerBound < rr.lowerBound }
    case (.partialRangeFrom(let lprf), .partialRangeFrom(let rprf)):
      return lprf.lowerBound < rprf.lowerBound
    case (.partialRangeFrom(let lprf), .partialRangeGreaterThan(let rprgt)):
      return lprf.lowerBound <= rprgt.lowerBound
    case (.partialRangeFrom, _):
      return false
      
    // `lhs` is PartialRangeGreaterThan<Bound>
    case (.partialRangeGreaterThan(let lprgt), .closedRange(let rcr)):
      return lprgt.lowerBound < rcr.lowerBound
    case (.partialRangeGreaterThan(let lprgt), .leftOpenRange(let rlor)):
      return lprgt.lowerBound < rlor.lowerBound
    case (.partialRangeGreaterThan(let lprgt), .openRange(let ror)):
      return lprgt.lowerBound < ror.lowerBound
    case (.partialRangeGreaterThan(let lprgt), .range(let rr)):
      return lprgt.lowerBound < rr.lowerBound
    case (.partialRangeGreaterThan(let lprgt), .partialRangeFrom(let rprf)):
      return lprgt.lowerBound < rprf.lowerBound
    case (.partialRangeGreaterThan(let lprgt), .partialRangeGreaterThan(let rprgt)):
      return lprgt.lowerBound < rprgt.lowerBound
    case (.partialRangeGreaterThan, _):
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
  /// Returns joined range, or `nil` if `self` doesn't overlap `other`
  func joined(with other:CertainRange<Bound>) -> CertainRange<Bound>? {
    if self == other { return self }
    
    let sorted: (CertainRange<Bound>, CertainRange<Bound>) = self < other ? (self, other) : (other, self)
    // -> Always sorted.0 < sorted.1
    
    switch (sorted.0, sorted.1) {
      
    // NEVER: case (.empty, _)
    // NEVER: case (_, .universal)
    case (_, .empty):
      return sorted.0
    case (.universal, _):
      return .universal
      
    // Code below includes workarounds for
    // "Matching a generic value in multiple patterns is not yet supported; use separate cases instead"
      
    // ClosedRange + ***
    case (.closedRange(let cr1), .closedRange(let cr2)) where cr1.overlaps(cr2):
      return .closedRange(cr1.lowerBound...max(cr1.upperBound, cr2.upperBound))
    case (.closedRange(let cr), .leftOpenRange(let lor)) where cr.upperBound >= lor.lowerBound:
      return .closedRange(cr.lowerBound...max(cr.upperBound, lor.upperBound))
    case (.closedRange(let cr), .openRange(let or)) where cr.upperBound >= or.lowerBound:
      if cr.upperBound >= or.upperBound { return .closedRange(cr) }
      else { return .range(cr.lowerBound..<or.upperBound) }
    case (.closedRange(let cr), .range(let rr)) where cr.upperBound >= rr.lowerBound:
      if cr.upperBound >= rr.upperBound { return .closedRange(cr) }
      else { return .range(cr.lowerBound..<rr.upperBound) }
    case (.closedRange(let cr), .partialRangeFrom(let prf)) where cr.upperBound >= prf.lowerBound:
      return .partialRangeFrom(cr.lowerBound...)
    case (.closedRange(let cr), .partialRangeGreaterThan(let prgt)) where cr.upperBound >= prgt.lowerBound:
      return .partialRangeFrom(cr.lowerBound...)
    
    // LeftOpenRange + ***
    case (.leftOpenRange(let lor), .closedRange(let cr)) where lor.upperBound >= cr.lowerBound:
      return .leftOpenRange(lor.lowerBound<..max(lor.upperBound, cr.upperBound))
    case (.leftOpenRange(let lor1), .leftOpenRange(let lor2)) where lor1.upperBound >= lor2.lowerBound:
      return .leftOpenRange(lor1.lowerBound<..max(lor1.upperBound, lor2.upperBound))
    case (.leftOpenRange(let lor), .openRange(let or)) where lor.upperBound >= or.lowerBound:
      if lor.upperBound >= or.upperBound { return .leftOpenRange(lor) }
      else { return .openRange(lor.lowerBound<.<or.upperBound) }
    case (.leftOpenRange(let lor), .range(let rr)) where lor.upperBound >= rr.lowerBound:
      if lor.upperBound >= rr.upperBound { return .leftOpenRange(lor) }
      else { return .range(lor.lowerBound..<rr.upperBound) }
    case (.leftOpenRange(let lor), .partialRangeFrom(let prf)) where lor.upperBound >= prf.lowerBound:
      return .partialRangeGreaterThan(lor.lowerBound<..)
    case (.leftOpenRange(let lor), .partialRangeGreaterThan(let prgt)) where lor.upperBound >= prgt.lowerBound:
      return .partialRangeGreaterThan(lor.lowerBound<..)
      
    // OpenRange + ***
    case (.openRange(let or), .closedRange(let cr)) where or.upperBound >= cr.lowerBound:
      if or.upperBound > cr.upperBound { return .openRange(or) }
      else { return .leftOpenRange(or.lowerBound<..cr.upperBound) }
    case (.openRange(let or), .leftOpenRange(let lor)) where or.upperBound >= lor.lowerBound:
      if or.upperBound > lor.upperBound { return .openRange(or) }
      else { return .leftOpenRange(or.lowerBound<..lor.upperBound) }
    case (.openRange(let or1), .openRange(let or2)) where or1.overlaps(or2):
      return .openRange(or1.lowerBound<.<max(or1.upperBound, or2.upperBound))
    case (.openRange(let or), .range(let rr)) where or.upperBound >= rr.lowerBound:
      return .openRange(or.lowerBound<.<max(or.upperBound, rr.upperBound))
    case (.openRange(let or), .partialRangeFrom(let prf)) where or.upperBound >= prf.lowerBound:
      return .partialRangeGreaterThan(or.lowerBound<..)
    case (.openRange(let or), .partialRangeGreaterThan(let prgt)) where or.upperBound > prgt.lowerBound:
      return .partialRangeGreaterThan(or.lowerBound<..)
      
    // Range + ***
    case (.range(let rr), .closedRange(let cr)) where rr.upperBound >= cr.lowerBound:
      if rr.upperBound > cr.upperBound { return .range(rr) }
      else { return .closedRange(rr.lowerBound...cr.upperBound) }
    case (.range(let rr), .leftOpenRange(let lor)) where rr.upperBound > lor.lowerBound:
      if rr.upperBound > lor.upperBound { return .range(rr) }
      else { return .closedRange(rr.lowerBound...lor.upperBound) }
    case (.range(let rr), .openRange(let or)) where rr.upperBound > or.lowerBound:
      return .range(rr.lowerBound..<max(rr.upperBound, or.upperBound))
    case (.range(let r1), .range(let r2)) where r1.upperBound >= r2.lowerBound:
      return .range(r1.lowerBound..<max(r1.upperBound, r2.upperBound))
    case (.range(let rr), .partialRangeFrom(let prf)) where rr.upperBound >= prf.lowerBound:
      return .partialRangeFrom(rr.lowerBound...)
    case (.range(let rr), .partialRangeGreaterThan(let prgt)) where rr.upperBound > prgt.lowerBound:
      return .partialRangeFrom(rr.lowerBound...)
      
    // PartialRangeFrom + ***
    case (.partialRangeFrom(let prf), .closedRange):
      return .partialRangeFrom(prf)
    case (.partialRangeFrom(let prf), .leftOpenRange):
      return .partialRangeFrom(prf)
    case (.partialRangeFrom(let prf), .openRange):
      return .partialRangeFrom(prf)
    case (.partialRangeFrom(let prf), .range):
      return .partialRangeFrom(prf)
    case (.partialRangeFrom(let prf), .partialRangeFrom):
      return .partialRangeFrom(prf)
    case (.partialRangeFrom(let prf), .partialRangeGreaterThan):
      return .partialRangeFrom(prf)
    case (.partialRangeFrom(let prf), .partialRangeThrough(let prt)) where prf.lowerBound >= prt.upperBound:
      return .universal
    case (.partialRangeFrom(let prf), .partialRangeUpTo(let prut)) where prf.lowerBound >= prut.upperBound:
      return .universal
      
    // PartialRangeGreaterThan + ***
    case (.partialRangeGreaterThan(let prgt), .closedRange):
      return .partialRangeGreaterThan(prgt)
    case (.partialRangeGreaterThan(let prgt), .leftOpenRange):
        return .partialRangeGreaterThan(prgt)
    case (.partialRangeGreaterThan(let prgt), .openRange):
      return .partialRangeGreaterThan(prgt)
    case (.partialRangeGreaterThan(let prgt), .range):
      return .partialRangeGreaterThan(prgt)
    case (.partialRangeGreaterThan(let prgt), .partialRangeFrom):
      return .partialRangeGreaterThan(prgt)
    case (.partialRangeGreaterThan(let prgt), .partialRangeGreaterThan):
      return .partialRangeGreaterThan(prgt)
    case (.partialRangeGreaterThan(let prgt), .partialRangeThrough(let prt)) where prgt.lowerBound >= prt.upperBound:
      return .universal
    case (.partialRangeGreaterThan(let prgt), .partialRangeUpTo(let prut)) where prgt.lowerBound > prut.upperBound:
      return .universal
      
    // PartialRangeThrough + ***
    case (.partialRangeThrough(let prt), .closedRange(let cr)) where prt.upperBound >= cr.lowerBound:
      return .partialRangeThrough(...max(prt.upperBound, cr.upperBound))
    case (.partialRangeThrough(let prt), .leftOpenRange(let lor)) where prt.upperBound >= lor.lowerBound:
      return .partialRangeThrough(...max(prt.upperBound, lor.upperBound))
    case (.partialRangeThrough(let prt), .openRange(let or)) where prt.upperBound >= or.lowerBound:
      if prt.upperBound >= or.upperBound { return .partialRangeThrough(prt) }
      else { return .partialRangeUpTo(..<or.upperBound) }
    case (.partialRangeThrough(let prt), .range(let rr)) where prt.upperBound >= rr.lowerBound:
      if prt.upperBound >= rr.upperBound { return .partialRangeThrough(prt) }
      else { return .partialRangeUpTo(..<rr.upperBound) }
    case (.partialRangeThrough(let prt), .partialRangeFrom(let prf)) where prt.upperBound >= prf.lowerBound:
      return .universal
    case (.partialRangeThrough(let prt), .partialRangeGreaterThan(let prgt)) where prt.upperBound >= prgt.lowerBound:
      return .universal
    case (.partialRangeThrough, .partialRangeThrough(let prt2)):
      return .partialRangeThrough(prt2)
    case (.partialRangeThrough, .partialRangeUpTo(let prut)):
      return .partialRangeUpTo(prut)
      
    // PartialRangeUpTo + ***
    case (.partialRangeUpTo(let prut), .closedRange(let cr)) where prut.upperBound >= cr.lowerBound:
      if prut.upperBound > cr.upperBound { return .partialRangeUpTo(prut) }
      else { return .partialRangeThrough(...cr.upperBound) }
    case (.partialRangeUpTo(let prut), .leftOpenRange(let lor)) where prut.upperBound > lor.lowerBound:
      if prut.upperBound > lor.upperBound { return .partialRangeUpTo(prut) }
      else { return .partialRangeThrough(...lor.upperBound) }
    case (.partialRangeUpTo(let prut), .openRange(let or)) where prut.upperBound > or.lowerBound:
      return .partialRangeUpTo(..<max(prut.upperBound, or.upperBound))
    case (.partialRangeUpTo(let prut), .range(let rr)) where prut.upperBound >= rr.lowerBound:
      return .partialRangeUpTo(..<max(prut.upperBound, rr.upperBound))
    case (.partialRangeUpTo(let prut), .partialRangeFrom(let prf)) where prut.upperBound >= prf.lowerBound:
      return .universal
    case (.partialRangeUpTo(let prut), .partialRangeGreaterThan(let prgt)) where prut.upperBound > prgt.lowerBound:
      return .universal
    case (.partialRangeUpTo, .partialRangeThrough(let prt)):
      return .partialRangeThrough(prt)
    case (.partialRangeUpTo, .partialRangeUpTo(let prut2)):
      return .partialRangeUpTo(prut2)
    
    // else...
    default:
      return nil
    }
  }
}

extension CertainRange {
  /**
   
   - returns:
     Subtracted range(s).
     Under some conditions, `other` divides the range. That is why a tuple is returned.
   
   */
  public func subtracting(_ other:CertainRange<Bound>) -> (CertainRange<Bound>, CertainRange<Bound>?) {
    // The result must be .empty when...
    if self == other || self == .empty || other == .universal { return (.empty, nil) }
    if other == .empty { return (self, nil) }
    
    switch (self, other) {
    
    // .universal - ***
    case (.universal, .closedRange(let cr)):
      return (.partialRangeUpTo(..<cr.lowerBound), .partialRangeGreaterThan(cr.upperBound<..))
    case (.universal, .leftOpenRange(let lor)):
      return (.partialRangeThrough(...lor.lowerBound), .partialRangeGreaterThan(lor.upperBound<..))
    case (.universal, .openRange(let or)):
      return (.partialRangeThrough(...or.lowerBound), .partialRangeFrom(or.upperBound...))
    case (.universal, .range(let rr)):
      return (.partialRangeUpTo(..<rr.lowerBound), .partialRangeFrom(rr.upperBound...))
    case (.universal, .partialRangeFrom(let prf)):
      return (.partialRangeUpTo(..<prf.lowerBound), nil)
    case (.universal, .partialRangeGreaterThan(let prgt)):
      return (.partialRangeThrough(...prgt.lowerBound), nil)
    case (.universal, .partialRangeThrough(let prt)):
      return (.partialRangeGreaterThan(prt.upperBound<..), nil)
    case (.universal, .partialRangeUpTo(let prut)):
      return (.partialRangeFrom(prut.upperBound...), nil)
      
    // ClosedRange - ***
    case (.closedRange(let cr1), .closedRange(let cr2)):
      if !cr1.overlaps(cr2) {
        return (self, nil)
      } else if cr2.lowerBound >= cr1.lowerBound {
        if cr2.upperBound >= cr1.upperBound {
          return (.range(cr1.lowerBound..<cr2.lowerBound), nil)
        } else {
          return (.range(cr1.lowerBound..<cr2.lowerBound), .leftOpenRange(cr2.upperBound<..cr1.upperBound))
        }
      } else {
        if cr2.upperBound >= cr1.upperBound {
          return (.empty, nil)
        } else {
          return (.leftOpenRange(cr2.upperBound<..cr1.upperBound), nil)
        }
      }
    case (.closedRange(let cr), .leftOpenRange(let lor)):
      if lor.upperBound < cr.lowerBound || cr.upperBound <= lor.lowerBound {
        return (self, nil)
      } else if lor.lowerBound < cr.lowerBound {
        if lor.upperBound >= cr.upperBound {
          return (.empty, nil)
        } else {
          return (.leftOpenRange(lor.upperBound<..cr.upperBound), nil)
        }
      } else {
        if lor.upperBound >= cr.upperBound {
          return (.closedRange(cr.lowerBound...lor.lowerBound), nil)
        } else {
          return (.closedRange(cr.lowerBound...lor.lowerBound), .leftOpenRange(lor.upperBound<..cr.upperBound))
        }
      }
    case (.closedRange(let cr), .openRange(let or)):
      if or.upperBound <= cr.lowerBound || cr.upperBound <= or.lowerBound {
        return (self, nil)
      } else if or.lowerBound < cr.lowerBound {
        if or.upperBound > cr.upperBound {
          return (.empty, nil)
        } else {
          return (.closedRange(or.upperBound...cr.upperBound), nil)
        }
      } else {
        if or.upperBound > cr.upperBound {
          return (.closedRange(cr.lowerBound...or.lowerBound), nil)
        } else {
          return (.closedRange(cr.lowerBound...or.lowerBound), .closedRange(or.upperBound...cr.upperBound))
        }
      }
    case (.closedRange(let cr), .range(let rr)):
      if rr.upperBound <= cr.lowerBound || cr.upperBound < rr.lowerBound {
        return (self, nil)
      } else if rr.lowerBound <= cr.lowerBound {
        if rr.upperBound > cr.upperBound {
          return (.empty, nil)
        } else {
          return (.closedRange(rr.upperBound...cr.upperBound), nil)
        }
      } else {
        if rr.upperBound > cr.upperBound {
          return (.range(cr.lowerBound..<rr.lowerBound), nil)
        } else {
          return (.range(cr.lowerBound..<rr.lowerBound), .closedRange(rr.upperBound...cr.upperBound))
        }
      }
    case (.closedRange(let cr), .partialRangeFrom(let prf)):
      if prf.lowerBound > cr.upperBound {
        return (self, nil)
      } else if prf.lowerBound <= cr.lowerBound {
        return (.empty, nil)
      } else {
        return (.range(cr.lowerBound..<prf.lowerBound), nil)
      }
    case (.closedRange(let cr), .partialRangeGreaterThan(let prgt)):
      if prgt.lowerBound >= cr.upperBound {
        return (self, nil)
      } else if prgt.lowerBound < cr.lowerBound {
        return (.empty, nil)
      } else {
        return (.closedRange(cr.lowerBound...prgt.lowerBound), nil)
      }
    case (.closedRange(let cr), .partialRangeThrough(let prt)):
      if prt.upperBound < cr.lowerBound {
        return (self, nil)
      } else if prt.upperBound >= cr.upperBound {
        return (.empty, nil)
      } else {
        return (.leftOpenRange(prt.upperBound<..cr.upperBound), nil)
      }
    case (.closedRange(let cr), .partialRangeUpTo(let prut)):
      if prut.upperBound <= cr.lowerBound {
        return (self, nil)
      } else if prut.upperBound > cr.upperBound {
        return (.empty, nil)
      } else {
        return (.closedRange(prut.upperBound...cr.upperBound), nil)
      }
      
    // LeftOpenRange - ***
    case (.leftOpenRange(let lor), .closedRange(let cr)):
      if cr.upperBound <= lor.lowerBound || lor.upperBound < cr.lowerBound {
        return (self, nil)
      } else if cr.lowerBound <= lor.lowerBound {
        if cr.upperBound >= lor.upperBound {
          return (.empty, nil)
        } else {
          return (.leftOpenRange(cr.upperBound<..lor.upperBound), nil)
        }
      } else {
        if cr.upperBound >= lor.upperBound {
          return (.openRange(lor.lowerBound<.<cr.lowerBound), nil)
        } else {
          return (.openRange(lor.lowerBound<.<cr.lowerBound), .leftOpenRange(cr.upperBound<..lor.upperBound))
        }
      }
    case (.leftOpenRange(let lor1), .leftOpenRange(let lor2)):
      if lor2.upperBound <= lor1.lowerBound || lor1.upperBound <= lor2.lowerBound {
        return (self, nil)
      } else if lor2.lowerBound <= lor1.lowerBound {
        if lor2.upperBound >= lor1.upperBound {
          return (.empty, nil)
        } else {
          return (.leftOpenRange(lor2.upperBound<..lor1.upperBound), nil)
        }
      } else {
        if lor2.upperBound >= lor1.upperBound {
          return (.leftOpenRange(lor1.lowerBound<..lor2.lowerBound), nil)
        } else {
          return (.leftOpenRange(lor1.lowerBound<..lor2.lowerBound), .leftOpenRange(lor2.upperBound<..lor1.upperBound))
        }
      }
    case (.leftOpenRange(let lor), .openRange(let or)):
      if or.upperBound <= lor.lowerBound || lor.upperBound <= or.lowerBound {
        return (self, nil)
      } else if or.lowerBound <= lor.lowerBound {
        if or.upperBound > lor.upperBound {
          return (.empty, nil)
        } else {
          return (.closedRange(or.upperBound...lor.upperBound), nil)
        }
      } else {
        if or.upperBound > lor.upperBound {
          return (.leftOpenRange(lor.lowerBound<..or.lowerBound), nil)
        } else {
          return (.leftOpenRange(lor.lowerBound<..or.lowerBound), .closedRange(or.upperBound...lor.upperBound))
        }
      }
    case (.leftOpenRange(let lor), .range(let rr)):
      if rr.upperBound <= lor.lowerBound || lor.upperBound < rr.lowerBound {
        return (self, nil)
      } else if rr.lowerBound <= lor.lowerBound {
        if rr.upperBound > lor.upperBound {
          return (.empty, nil)
        } else {
          return (.closedRange(rr.upperBound...lor.upperBound), nil)
        }
      } else {
        if rr.upperBound > lor.upperBound {
          return (.openRange(lor.lowerBound<.<rr.lowerBound), nil)
        } else {
          return (.openRange(lor.lowerBound<.<rr.lowerBound), .closedRange(rr.upperBound...lor.upperBound))
        }
      }
    case (.leftOpenRange(let lor), .partialRangeFrom(let prf)):
      if prf.lowerBound > lor.upperBound {
        return (self, nil)
      } else if prf.lowerBound <= lor.lowerBound {
        return (.empty, nil)
      } else {
        return (.openRange(lor.lowerBound<.<prf.lowerBound), nil)
      }
    case (.leftOpenRange(let lor), .partialRangeGreaterThan(let prgt)):
      if prgt.lowerBound >= lor.upperBound {
        return (self, nil)
      } else if prgt.lowerBound < lor.lowerBound {
        return (.empty, nil)
      } else {
        return (.leftOpenRange(lor.lowerBound<..prgt.lowerBound), nil)
      }
    case (.leftOpenRange(let lor), .partialRangeThrough(let prt)):
      if prt.upperBound <= lor.lowerBound {
        return (self, nil)
      } else if prt.upperBound >= lor.upperBound {
        return (.empty, nil)
      } else {
        return (.leftOpenRange(prt.upperBound<..lor.upperBound), nil)
      }
    case (.leftOpenRange(let lor), .partialRangeUpTo(let prut)):
      if prut.upperBound <= lor.lowerBound {
        return (self, nil)
      } else if prut.upperBound > lor.upperBound {
        return (.empty, nil)
      } else {
        return (.closedRange(prut.upperBound...lor.upperBound), nil)
      }
      
    // OpenRange - ***
    case (.openRange(let or), .closedRange(let cr)):
      if cr.upperBound <= or.lowerBound || or.upperBound <= cr.lowerBound {
        return (self, nil)
      } else if cr.lowerBound <= or.lowerBound {
        if cr.upperBound >= or.upperBound {
          return (.empty, nil)
        } else {
          return (.openRange(cr.upperBound<.<or.upperBound), nil)
        }
      } else {
        if cr.upperBound >= or.upperBound {
          return (.openRange(or.lowerBound<.<cr.lowerBound), nil)
        } else {
          return (.openRange(or.lowerBound<.<cr.lowerBound), .openRange(cr.upperBound<.<or.upperBound))
        }
      }
    case (.openRange(let or), .leftOpenRange(let lor)):
      if lor.upperBound <= or.lowerBound || or.upperBound <= lor.lowerBound {
        return (self, nil)
      } else if lor.lowerBound <= or.lowerBound {
        if lor.upperBound >= or.upperBound {
          return (.empty, nil)
        } else {
          return (.openRange(lor.upperBound<.<or.upperBound), nil)
        }
      } else {
        if lor.upperBound >= or.upperBound {
          return (.leftOpenRange(or.lowerBound<..lor.lowerBound), nil)
        } else {
          return (.leftOpenRange(or.lowerBound<..lor.lowerBound), .openRange(lor.upperBound<.<or.upperBound))
        }
      }
    case (.openRange(let or1), .openRange(let or2)):
      if or2.upperBound <= or1.lowerBound || or1.upperBound <= or2.lowerBound {
        return (self, nil)
      } else if or2.lowerBound <= or1.lowerBound {
        if or2.upperBound >= or1.upperBound {
          return (.empty, nil)
        } else {
          return (.range(or2.upperBound..<or1.upperBound), nil)
        }
      } else {
        if or2.upperBound >= or1.upperBound {
          return (.leftOpenRange(or1.lowerBound<..or2.lowerBound), nil)
        } else {
          return (.leftOpenRange(or1.lowerBound<..or2.lowerBound), .range(or2.upperBound..<or1.upperBound))
        }
      }
    case (.openRange(let or), .range(let rr)):
      if rr.upperBound <= or.lowerBound || or.upperBound <= rr.lowerBound {
        return (self, nil)
      } else if rr.lowerBound <= or.lowerBound {
        if rr.upperBound >= or.upperBound {
          return (.empty, nil)
        } else {
          return (.range(rr.upperBound..<or.upperBound), nil)
        }
      } else {
        if rr.upperBound > or.upperBound {
          return (.openRange(or.lowerBound<.<rr.lowerBound), nil)
        } else {
          return (.openRange(or.lowerBound<.<rr.lowerBound), .range(rr.upperBound..<or.upperBound))
        }
      }
    case (.openRange(let or), .partialRangeFrom(let prf)):
      if prf.lowerBound >= or.upperBound {
        return (self, nil)
      } else if prf.lowerBound <= or.lowerBound {
        return (.empty, nil)
      } else {
        return (.openRange(or.lowerBound<.<prf.lowerBound), nil)
      }
    case (.openRange(let or), .partialRangeGreaterThan(let prgt)):
      if prgt.lowerBound >= or.upperBound {
        return (self, nil)
      } else if prgt.lowerBound <= or.lowerBound {
        return (.empty, nil)
      } else {
        return (.leftOpenRange(or.lowerBound<..prgt.lowerBound), nil)
      }
    case (.openRange(let or), .partialRangeThrough(let prt)):
      if prt.upperBound <= or.lowerBound {
        return (self, nil)
      } else if prt.upperBound >= or.upperBound {
        return (.empty, nil)
      } else {
        return (.openRange(prt.upperBound<.<or.upperBound), nil)
      }
    case (.openRange(let or), .partialRangeUpTo(let prut)):
      if prut.upperBound <= or.lowerBound {
        return (self, nil)
      } else if prut.upperBound >= or.upperBound {
        return (.empty, nil)
      } else {
        return (.range(prut.upperBound..<or.upperBound), nil)
      }
      
    // Range - ***
    case (.range(let rr), .closedRange(let cr)):
      if cr.upperBound < rr.lowerBound || rr.upperBound <= cr.lowerBound {
        return (self, nil)
      } else if cr.lowerBound <= rr.lowerBound {
        if cr.upperBound >= rr.upperBound {
          return (.empty, nil)
        } else {
          return (.openRange(cr.upperBound<.<rr.upperBound), nil)
        }
      } else {
        if cr.upperBound >= rr.upperBound {
          return (.range(rr.lowerBound..<cr.lowerBound), nil)
        } else {
          return (.range(rr.lowerBound..<cr.lowerBound), .openRange(cr.upperBound<.<rr.upperBound))
        }
      }
    case (.range(let rr), .leftOpenRange(let lor)):
      if lor.upperBound < rr.lowerBound || rr.upperBound <= lor.lowerBound {
        return (self, nil)
      } else if lor.lowerBound < rr.lowerBound {
        if lor.upperBound >= rr.upperBound {
          return (.empty, nil)
        } else {
          return (.openRange(lor.upperBound<.<rr.upperBound), nil)
        }
      } else {
        if lor.upperBound >= rr.upperBound {
          return (.closedRange(rr.lowerBound...lor.lowerBound), nil)
        } else {
          return (.closedRange(rr.lowerBound...lor.lowerBound), .openRange(lor.upperBound<.<rr.upperBound))
        }
      }
    case (.range(let rr), .openRange(let or)):
      if or.upperBound <= rr.lowerBound || rr.upperBound <= or.lowerBound {
        return (self, nil)
      } else if or.lowerBound < rr.lowerBound {
        if or.upperBound >= rr.upperBound {
          return (.empty, nil)
        } else {
          return (.range(or.upperBound..<rr.upperBound), nil)
        }
      } else {
        if or.upperBound >= rr.upperBound {
          return (.closedRange(rr.lowerBound...or.lowerBound), nil)
        } else {
          return (.closedRange(rr.lowerBound...or.lowerBound), .range(or.upperBound..<rr.upperBound))
        }
      }
    case (.range(let rr1), .range(let rr2)):
      if rr2.upperBound <= rr1.lowerBound || rr1.upperBound <= rr2.lowerBound {
        return (self, nil)
      } else if rr2.lowerBound <= rr1.lowerBound {
        if rr2.upperBound >= rr1.upperBound {
          return (.empty, nil)
        } else {
          return (.range(rr2.upperBound..<rr1.upperBound), nil)
        }
      } else {
        if rr2.upperBound >= rr1.upperBound {
          return (.range(rr1.lowerBound..<rr2.lowerBound), nil)
        } else {
          return (.range(rr1.lowerBound..<rr2.lowerBound), .range(rr2.upperBound..<rr1.upperBound))
        }
      }
    case (.range(let rr), .partialRangeFrom(let prf)):
      if prf.lowerBound >= rr.upperBound {
        return (self, nil)
      } else if prf.lowerBound <= rr.lowerBound {
        return (.empty, nil)
      } else {
        return (.range(rr.lowerBound..<prf.lowerBound), nil)
      }
    case (.range(let rr), .partialRangeGreaterThan(let prgt)):
      if prgt.lowerBound >= rr.upperBound {
        return (self, nil)
      } else if prgt.lowerBound < rr.lowerBound {
        return (.empty, nil)
      } else {
        return (.closedRange(rr.lowerBound...prgt.lowerBound), nil)
      }
    case (.range(let rr), .partialRangeThrough(let prt)):
      if prt.upperBound < rr.lowerBound {
        return (self, nil)
      } else if prt.upperBound >= rr.upperBound {
        return (.empty, nil)
      } else {
        return (.openRange(prt.upperBound<.<rr.upperBound), nil)
      }
    case (.range(let rr), .partialRangeUpTo(let prut)):
      if prut.upperBound <= rr.lowerBound {
        return (self, nil)
      } else if prut.upperBound >= rr.upperBound {
        return (.empty, nil)
      } else {
        return (.range(prut.upperBound..<rr.upperBound), nil)
      }
      
    // PartialRangeFrom - ***
    case (.partialRangeFrom(let prf), .closedRange(let cr)):
      if cr.upperBound < prf.lowerBound {
        return (self, nil)
      } else if cr.lowerBound <= prf.lowerBound {
        return (.partialRangeGreaterThan(cr.upperBound<..), nil)
      } else {
        return (.range(prf.lowerBound..<cr.lowerBound), .partialRangeGreaterThan(cr.upperBound<..))
      }
    case (.partialRangeFrom(let prf), .leftOpenRange(let lor)):
      if lor.upperBound < prf.lowerBound {
        return (self, nil)
      } else if lor.lowerBound < prf.lowerBound {
        return (.partialRangeGreaterThan(lor.upperBound<..), nil)
      } else {
        return (.closedRange(prf.lowerBound...lor.lowerBound), .partialRangeGreaterThan(lor.upperBound<..))
      }
    case (.partialRangeFrom(let prf), .openRange(let or)):
      if or.upperBound <= prf.lowerBound {
        return (self, nil)
      } else if or.lowerBound < prf.lowerBound {
        return (.partialRangeFrom(or.upperBound...), nil)
      } else {
        return (.closedRange(prf.lowerBound...or.lowerBound), .partialRangeFrom(or.upperBound...))
      }
    case (.partialRangeFrom(let prf), .range(let rr)):
      if rr.upperBound <= prf.lowerBound {
        return (self, nil)
      } else if rr.lowerBound <= prf.lowerBound {
        return (.partialRangeFrom(rr.upperBound...), nil)
      } else {
        return (.range(prf.lowerBound..<rr.lowerBound), .partialRangeFrom(rr.upperBound...))
      }
    case (.partialRangeFrom(let prf1), .partialRangeFrom(let prf2)):
      if prf2.lowerBound <= prf1.lowerBound {
        return (.empty, nil)
      } else {
        return (.range(prf1.lowerBound..<prf2.lowerBound), nil)
      }
    case (.partialRangeFrom(let prf), .partialRangeGreaterThan(let prgt)):
      if prgt.lowerBound < prf.lowerBound {
        return (.empty, nil)
      } else {
        return (.closedRange(prf.lowerBound...prgt.lowerBound), nil)
      }
    case (.partialRangeFrom(let prf), .partialRangeThrough(let prt)):
      if prt.upperBound < prf.lowerBound {
        return (self, nil)
      } else {
        return (.partialRangeGreaterThan(prt.upperBound<..), nil)
      }
    case (.partialRangeFrom(let prf), .partialRangeUpTo(let prut)):
      if prut.upperBound <= prf.lowerBound {
        return (self, nil)
      } else {
        return (.partialRangeFrom(prut.upperBound...), nil)
      }
      
    // PartialRangeGreaterThan - ***
    case (.partialRangeGreaterThan(let prgt), .closedRange(let cr)):
      if cr.upperBound <= prgt.lowerBound {
        return (self, nil)
      } else if cr.lowerBound <= prgt.lowerBound {
        return (.partialRangeGreaterThan(cr.upperBound<..), nil)
      } else {
        return (.openRange(prgt.lowerBound<.<cr.lowerBound), .partialRangeGreaterThan(cr.upperBound<..))
      }
    case (.partialRangeGreaterThan(let prgt), .leftOpenRange(let lor)):
      if lor.upperBound <= prgt.lowerBound {
        return (self, nil)
      } else if lor.lowerBound <= prgt.lowerBound {
        return (.partialRangeGreaterThan(lor.upperBound<..), nil)
      } else {
        return (.leftOpenRange(prgt.lowerBound<..lor.lowerBound), .partialRangeGreaterThan(lor.upperBound<..))
      }
    case (.partialRangeGreaterThan(let prgt), .openRange(let or)):
      if or.upperBound <= prgt.lowerBound {
        return (self, nil)
      } else if or.lowerBound <= prgt.lowerBound {
        return (.partialRangeFrom(or.upperBound...), nil)
      } else {
        return (.leftOpenRange(prgt.lowerBound<..or.lowerBound), .partialRangeFrom(or.upperBound...))
      }
    case (.partialRangeGreaterThan(let prgt), .range(let rr)):
      if rr.upperBound <= prgt.lowerBound {
        return (self, nil)
      } else if rr.lowerBound <= prgt.lowerBound {
        return (.partialRangeFrom(rr.upperBound...), nil)
      } else {
        return (.openRange(prgt.lowerBound<.<rr.lowerBound), .partialRangeFrom(rr.upperBound...))
      }
    case (.partialRangeGreaterThan(let prgt), .partialRangeFrom(let prf)):
      if prf.lowerBound <= prgt.lowerBound {
        return (.empty, nil)
      } else {
        return (.openRange(prgt.lowerBound<.<prf.lowerBound), nil)
      }
    case (.partialRangeGreaterThan(let prgt1), .partialRangeGreaterThan(let prgt2)):
      if prgt2.lowerBound <= prgt1.lowerBound {
        return (.empty, nil)
      } else {
        return (.leftOpenRange(prgt1.lowerBound<..prgt2.lowerBound), nil)
      }
    case (.partialRangeGreaterThan(let prgt), .partialRangeThrough(let prt)):
      if prt.upperBound <= prgt.lowerBound {
        return (self, nil)
      } else {
        return (.partialRangeGreaterThan(prt.upperBound<..), nil)
      }
    case (.partialRangeGreaterThan(let prgt), .partialRangeUpTo(let prut)):
      if prut.upperBound <= prgt.lowerBound {
        return (self, nil)
      } else {
        return (.partialRangeFrom(prut.upperBound...), nil)
      }
    
    // PartialRangeThrough - ***
    case (.partialRangeThrough(let prt), .closedRange(let cr)):
      if cr.lowerBound > prt.upperBound {
        return (self, nil)
      } else if cr.upperBound >= prt.upperBound {
        return (.partialRangeUpTo(..<cr.lowerBound), nil)
      } else {
        return (.partialRangeUpTo(..<cr.lowerBound), .leftOpenRange(cr.upperBound<..prt.upperBound))
      }
    case (.partialRangeThrough(let prt), .leftOpenRange(let lor)):
      if lor.lowerBound >= prt.upperBound {
        return (self, nil)
      } else if lor.upperBound >= prt.upperBound {
        return (.partialRangeThrough(...lor.lowerBound), nil)
      } else {
        return (.partialRangeThrough(...lor.lowerBound), .leftOpenRange(lor.upperBound<..prt.upperBound))
      }
    case (.partialRangeThrough(let prt), .openRange(let or)):
      if or.lowerBound >= prt.upperBound {
        return (self, nil)
      } else if or.upperBound > prt.upperBound {
        return (.partialRangeThrough(...or.lowerBound), nil)
      } else {
        return (.partialRangeThrough(...or.lowerBound), .closedRange(or.upperBound...prt.upperBound))
      }
    case (.partialRangeThrough(let prt), .range(let rr)):
      if rr.lowerBound > prt.upperBound {
        return (self, nil)
      } else if rr.upperBound >= prt.upperBound {
        return (.partialRangeUpTo(..<rr.lowerBound), nil)
      } else {
        return (.partialRangeUpTo(..<rr.lowerBound), .closedRange(rr.upperBound...prt.upperBound))
      }
    case (.partialRangeThrough(let prt), .partialRangeFrom(let prf)):
      if prf.lowerBound > prt.upperBound {
        return (self, nil)
      } else {
        return (.partialRangeUpTo(..<prf.lowerBound), nil)
      }
    case (.partialRangeThrough(let prt), .partialRangeGreaterThan(let prgt)):
      if prgt.lowerBound >= prt.upperBound {
        return (self, nil)
      } else {
        return (.partialRangeThrough(...prgt.lowerBound), nil)
      }
    case (.partialRangeThrough(let prt1), .partialRangeThrough(let prt2)):
      if prt2.upperBound >= prt1.upperBound {
        return (.empty, nil)
      } else {
        return (.leftOpenRange(prt2.upperBound<..prt1.upperBound), nil)
      }
    case (.partialRangeThrough(let prt), .partialRangeUpTo(let prut)):
      if prut.upperBound > prt.upperBound {
        return (.empty, nil)
      } else {
        return (.closedRange(prut.upperBound...prt.upperBound), nil)
      }
    
    // PartialRangeUpTo - ***
    case (.partialRangeUpTo(let prut), .closedRange(let cr)):
      if cr.lowerBound >= prut.upperBound {
        return (self, nil)
      } else if cr.upperBound >= prut.upperBound {
        return (.partialRangeUpTo(..<cr.lowerBound), nil)
      } else {
        return (.partialRangeUpTo(..<cr.lowerBound), .openRange(cr.upperBound<.<prut.upperBound))
      }
    case (.partialRangeUpTo(let prut), .leftOpenRange(let lor)):
      if lor.lowerBound >= prut.upperBound {
        return (self, nil)
      } else if lor.upperBound >= prut.upperBound {
        return (.partialRangeThrough(...lor.lowerBound), nil)
      } else {
        return (.partialRangeThrough(...lor.lowerBound), .openRange(lor.upperBound<.<prut.upperBound))
      }
    case (.partialRangeUpTo(let prut), .openRange(let or)):
      if or.lowerBound >= prut.upperBound {
        return (self, nil)
      } else if or.upperBound >= prut.upperBound {
        return (.partialRangeThrough(...or.lowerBound), nil)
      } else {
        return (.partialRangeThrough(...or.lowerBound), .range(or.upperBound..<prut.upperBound))
      }
    case (.partialRangeUpTo(let prut), .range(let rr)):
      if rr.lowerBound >= prut.upperBound {
        return (self, nil)
      } else if rr.upperBound >= prut.upperBound {
        return (.partialRangeUpTo(..<rr.lowerBound), nil)
      } else {
        return (.partialRangeUpTo(..<rr.lowerBound), .range(rr.upperBound..<prut.upperBound))
      }
    case (.partialRangeUpTo(let prut), .partialRangeFrom(let prf)):
      if prf.lowerBound >= prut.upperBound {
        return (self, nil)
      } else {
        return (.partialRangeUpTo(..<prf.lowerBound), nil)
      }
    case (.partialRangeUpTo(let prut), .partialRangeGreaterThan(let prgt)):
      if prgt.lowerBound >= prut.upperBound {
        return (self, nil)
      } else {
        return (.partialRangeThrough(...prgt.lowerBound), nil)
      }
    case (.partialRangeUpTo(let prut), .partialRangeThrough(let prt)):
      if prt.upperBound >= prut.upperBound {
        return (.empty, nil)
      } else {
        return (.openRange(prt.upperBound<.<prut.upperBound), nil)
      }
    case (.partialRangeUpTo(let prut1), .partialRangeUpTo(let prut2)):
      if prut2.upperBound >= prut1.upperBound {
        return (.empty, nil)
      } else {
        return (.range(prut2.upperBound..<prut1.upperBound), nil)
      }
      
    
    // Must not be reached.
    default:
      fatalError("Failed to subtract.")
      
    }
  }
}
