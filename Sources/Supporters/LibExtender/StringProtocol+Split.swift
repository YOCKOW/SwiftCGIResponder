/* *************************************************************************************************
 StringProtocol+Split.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

extension StringProtocol {
  /// shortcut for `split(separator:separator, maxSplits:1, omittingEmptySubsequences:false)`
  public func splitOnce(separator:Character) -> (Self.SubSequence, Self.SubSequence?) {
    let splitted = self.split(separator:separator, maxSplits:1, omittingEmptySubsequences:false)
    if splitted.count == 1 {
      return (splitted[0], nil)
    } else { //  splitted.count == 2
      return (splitted[0], splitted[1])
    }
  }
}
