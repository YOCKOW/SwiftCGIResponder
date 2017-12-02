/***************************************************************************************************
 BootstringTests.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

import XCTest
@testable import CGIResponder

class BootstringTests: XCTestCase {
  
  // https://tools.ietf.org/html/rfc3492#section-7
  let sampleStrings: [String] = [
    "\u{0644}\u{064A}\u{0647}\u{0645}\u{0627}\u{0628}\u{062A}\u{0643}\u{0644}\u{0645}\u{0648}\u{0634}\u{0639}\u{0631}\u{0628}\u{064A}\u{061F}",
    "egbpdaj6bu4bxfgehfvwxn",
    
    "他们为什么不说中文",
    "ihqwcrb4cv8a8dqg056pqjye",
    
    "他們爲什麽不說中文",
    "ihqwctvzc91f659drss3x8bo0yb",
    
    "Pročprostěnemluvíčesky",
    "Proprostnemluvesky-uyb24dma41a",
    
    "למההםפשוטלאמדבריםעברית",
    "4dbcagdahymbxekheh6e0a7fei0b",
    
    "\u{092F}\u{0939}\u{0932}\u{094B}\u{0917}\u{0939}\u{093F}\u{0928}\u{094D}\u{0926}\u{0940}\u{0915}\u{094D}\u{092F}\u{094B}\u{0902}\u{0928}\u{0939}\u{0940}\u{0902}\u{092C}\u{094B}\u{0932}\u{0938}\u{0915}\u{0924}\u{0947}\u{0939}\u{0948}\u{0902}",
    "i1baa7eci9glrd9b2ae1bj0hfcgg6iyaf8o0a1dig0cd",
    
    "なぜみんな日本語を話してくれないのか",
    "n8jok5ay5dzabd5bym9f0cm5685rrjetr6pdxa",
    
    "세계의모든사람들이한국어를이해한다면얼마나좋을까",
    "989aomsvi5e83db1d2a355cv1e0vak1dwrv93d5xbh15a0dt30a5jpsd879ccm6fea98c",
    
    "почемужеонинеговорятпорусски",
    "b1abfaaepdrnnbgefbadotcwatmq2g4l",
    
    "PorquénopuedensimplementehablarenEspañol",
    "PorqunopuedensimplementehablarenEspaol-fmd56a",
    
    "TạisaohọkhôngthểchỉnóitiếngViệt",
    "TisaohkhngthchnitingVit-kjcr8268qyxafd2f1b9g",
    
    "3年B組金八先生",
    "3B-ww4c5e180e575a65lsy2b",
    
    "安室奈美恵-with-SUPER-MONKEYS",
    "-with-SUPER-MONKEYS-pc58ag80a8qai00g7n9n",
    
    "Hello-Another-Way-それぞれの場所",
    "Hello-Another-Way--fc4qua05auwb3674vfr0b",
    
    "ひとつ屋根の下2",
    "2-u9tlzr9756bt3uc0v",
    
    "MajiでKoiする5秒前",
    "MajiKoi5-783gue6qz075azm5e",
    
    "パフィーdeルンバ",
    "de-jg4avhby1noc0d",
    
    "そのスピードで",
    "d9juau41awczczp",
    
    "-> $1.00 <-",
    "-> $1.00 <--"
  ]
  
  func testEncode() {
    for ii in 0..<(sampleStrings.count / 2) {
      let target = sampleStrings[ii * 2]
      let result = sampleStrings[ii * 2 + 1]
      
      let encoded = target.addingPunycodeEncoding
      XCTAssertNotNil(encoded)
      XCTAssertEqual(encoded!, result)
    }
  }
  
  func testDecode() {
    for ii in 0..<(sampleStrings.count / 2) {
      let target = sampleStrings[ii * 2 + 1]
      let result = sampleStrings[ii * 2]
      
      let decoded = target.removingPunycodeEncoding
      XCTAssertNotNil(decoded)
      XCTAssertEqual(decoded!, result)
    }
  }
  
  static var allTests: [(String, (BootstringTests) -> () -> Void)] = [
    ("Encode", testEncode),
    ("Decode", testDecode),
  ]
}

