/***************************************************************************************************
 CFStringEncodings.swift
   © 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

/// Note: `CFStringEncoding` is `UInt32` both on macOS and Linux, on the other hand,
///       `CFStringEncodings` is Swift-enum on macOS and is `Int` on Linux, and furthermore,
///       `CFStringBuiltInEncodings` is Swift-enum on macOS and is `UInt32` on Linux.

import CoreFoundation
import Foundation

extension CFString {
  public struct Encoding: RawRepresentable {
    public let rawValue: CFStringEncoding // aka UInt32
    public init(rawValue: CFStringEncoding) { self.rawValue = rawValue }
    
    public static let invalidIdentifier = Encoding(rawValue:kCFStringEncodingInvalidId)
  }
}

extension CFString.Encoding {
  public init(_ stringEncoding:String.Encoding) {
    self.init(rawValue:CFStringConvertNSStringEncodingToEncoding(stringEncoding.rawValue))
  }
  
  public init(ianaCharacterSetName:CFString) {
    self.init(rawValue:CFStringConvertIANACharSetNameToEncoding(ianaCharacterSetName))
  }
  
  public var ianaCharacterSetName: CFString? {
    return CFStringConvertEncodingToIANACharSetName(self.rawValue)
  }
}

extension CFString.Encoding {
  // Built-in encodings.
  #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
  public static let macRoman = CFString.Encoding(rawValue:CFStringBuiltInEncodings.macRoman.rawValue)
  public static let windowsLatin1 = CFString.Encoding(rawValue:CFStringBuiltInEncodings.windowsLatin1.rawValue)
  public static let isoLatin1 = CFString.Encoding(rawValue:CFStringBuiltInEncodings.isoLatin1.rawValue)
  public static let nextStepLatin = CFString.Encoding(rawValue:CFStringBuiltInEncodings.nextStepLatin.rawValue)
  public static let ASCII = CFString.Encoding(rawValue:CFStringBuiltInEncodings.ASCII.rawValue)
  public static let unicode = CFString.Encoding(rawValue:CFStringBuiltInEncodings.unicode.rawValue)
  public static let UTF8 = CFString.Encoding(rawValue:CFStringBuiltInEncodings.UTF8.rawValue)
  public static let nonLossyASCII = CFString.Encoding(rawValue:CFStringBuiltInEncodings.nonLossyASCII.rawValue)
  public static let UTF16 = CFString.Encoding(rawValue:CFStringBuiltInEncodings.UTF16.rawValue)
  public static let UTF16BE = CFString.Encoding(rawValue:CFStringBuiltInEncodings.UTF16BE.rawValue)
  public static let UTF16LE = CFString.Encoding(rawValue:CFStringBuiltInEncodings.UTF16LE.rawValue)
  public static let UTF32 = CFString.Encoding(rawValue:CFStringBuiltInEncodings.UTF32.rawValue)
  public static let UTF32BE = CFString.Encoding(rawValue:CFStringBuiltInEncodings.UTF32BE.rawValue)
  public static let UTF32LE = CFString.Encoding(rawValue:CFStringBuiltInEncodings.UTF32LE.rawValue)
  #else
  public static let macRoman = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacRoman))
  public static let windowsLatin1 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingWindowsLatin1))
  public static let isoLatin1 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISOLatin1))
  public static let nextStepLatin = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingNextStepLatin))
  public static let ASCII = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingASCII))
  public static let unicode = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingUnicode))
  public static let UTF8 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingUTF8))
  public static let nonLossyASCII = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingNonLossyASCII))
  public static let UTF16 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingUTF16))
  public static let UTF16BE = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingUTF16BE))
  public static let UTF16LE = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingUTF16LE))
  public static let UTF32 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingUTF32))
  public static let UTF32BE = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingUTF32BE))
  public static let UTF32LE = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingUTF32LE))
  #endif
}

extension CFString.Encoding {
  // `CFStringEncodings`
  #if os(macOS) || os(iOS) || os(watchOS) || os(tvOS)
  public static let ANSEL = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.ANSEL.rawValue))
  public static let big5 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.big5.rawValue))
  public static let big5_E = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.big5_E.rawValue))
  public static let big5_HKSCS_1999 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.big5_HKSCS_1999.rawValue))
  public static let CNS_11643_92_P1 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.CNS_11643_92_P1.rawValue))
  public static let CNS_11643_92_P2 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.CNS_11643_92_P2.rawValue))
  public static let CNS_11643_92_P3 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.CNS_11643_92_P3.rawValue))
  public static let dosArabic = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosArabic.rawValue))
  public static let dosBalticRim = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosBalticRim.rawValue))
  public static let dosCanadianFrench = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosCanadianFrench.rawValue))
  public static let dosChineseSimplif = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosChineseSimplif.rawValue))
  public static let dosChineseTrad = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosChineseTrad.rawValue))
  public static let dosCyrillic = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosCyrillic.rawValue))
  public static let dosGreek = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosGreek.rawValue))
  public static let dosGreek1 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosGreek1.rawValue))
  public static let dosGreek2 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosGreek2.rawValue))
  public static let dosHebrew = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosHebrew.rawValue))
  public static let dosIcelandic = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosIcelandic.rawValue))
  public static let dosJapanese = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosJapanese.rawValue))
  public static let dosKorean = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosKorean.rawValue))
  public static let dosLatin1 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosLatin1.rawValue))
  public static let dosLatin2 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosLatin2.rawValue))
  public static let dosLatinUS = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosLatinUS.rawValue))
  public static let dosNordic = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosNordic.rawValue))
  public static let dosPortuguese = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosPortuguese.rawValue))
  public static let dosRussian = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosRussian.rawValue))
  public static let dosThai = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosThai.rawValue))
  public static let dosTurkish = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.dosTurkish.rawValue))
  public static let EBCDIC_CP037 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.EBCDIC_CP037.rawValue))
  public static let EBCDIC_US = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.EBCDIC_US.rawValue))
  public static let EUC_CN = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.EUC_CN.rawValue))
  public static let EUC_JP = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.EUC_JP.rawValue))
  public static let EUC_KR = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.EUC_KR.rawValue))
  public static let EUC_TW = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.EUC_TW.rawValue))
  public static let GBK_95 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.GBK_95.rawValue))
  public static let GB_18030_2000 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue))
  public static let GB_2312_80 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.GB_2312_80.rawValue))
  public static let HZ_GB_2312 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.HZ_GB_2312.rawValue))
  public static let isoLatin10 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.isoLatin10.rawValue))
  public static let isoLatin2 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.isoLatin2.rawValue))
  public static let isoLatin3 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.isoLatin3.rawValue))
  public static let isoLatin4 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.isoLatin4.rawValue))
  public static let isoLatin5 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.isoLatin5.rawValue))
  public static let isoLatin6 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.isoLatin6.rawValue))
  public static let isoLatin7 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.isoLatin7.rawValue))
  public static let isoLatin8 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.isoLatin8.rawValue))
  public static let isoLatin9 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.isoLatin9.rawValue))
  public static let isoLatinArabic = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.isoLatinArabic.rawValue))
  public static let isoLatinCyrillic = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.isoLatinCyrillic.rawValue))
  public static let isoLatinGreek = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.isoLatinGreek.rawValue))
  public static let isoLatinHebrew = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.isoLatinHebrew.rawValue))
  public static let isoLatinThai = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.isoLatinThai.rawValue))
  public static let ISO_2022_CN = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.ISO_2022_CN.rawValue))
  public static let ISO_2022_CN_EXT = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.ISO_2022_CN_EXT.rawValue))
  public static let ISO_2022_JP = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.ISO_2022_JP.rawValue))
  public static let ISO_2022_JP_1 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.ISO_2022_JP_1.rawValue))
  public static let ISO_2022_JP_2 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.ISO_2022_JP_2.rawValue))
  public static let ISO_2022_JP_3 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.ISO_2022_JP_3.rawValue))
  public static let ISO_2022_KR = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.ISO_2022_KR.rawValue))
  public static let JIS_C6226_78 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.JIS_C6226_78.rawValue))
  public static let JIS_X0201_76 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.JIS_X0201_76.rawValue))
  public static let JIS_X0208_83 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.JIS_X0208_83.rawValue))
  public static let JIS_X0208_90 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.JIS_X0208_90.rawValue))
  public static let JIS_X0212_90 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.JIS_X0212_90.rawValue))
  public static let KOI8_R = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.KOI8_R.rawValue))
  public static let KOI8_U = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.KOI8_U.rawValue))
  public static let KSC_5601_87 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.KSC_5601_87.rawValue))
  public static let ksc_5601_92_Johab = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.ksc_5601_92_Johab.rawValue))
  public static let macArabic = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macArabic.rawValue))
  public static let macArmenian = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macArmenian.rawValue))
  public static let macBengali = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macBengali.rawValue))
  public static let macBurmese = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macBurmese.rawValue))
  public static let macCeltic = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macCeltic.rawValue))
  public static let macCentralEurRoman = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macCentralEurRoman.rawValue))
  public static let macChineseSimp = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macChineseSimp.rawValue))
  public static let macChineseTrad = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macChineseTrad.rawValue))
  public static let macCroatian = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macCroatian.rawValue))
  public static let macCyrillic = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macCyrillic.rawValue))
  public static let macDevanagari = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macDevanagari.rawValue))
  public static let macDingbats = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macDingbats.rawValue))
  public static let macEthiopic = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macEthiopic.rawValue))
  public static let macExtArabic = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macExtArabic.rawValue))
  public static let macFarsi = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macFarsi.rawValue))
  public static let macGaelic = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macGaelic.rawValue))
  public static let macGeorgian = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macGeorgian.rawValue))
  public static let macGreek = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macGreek.rawValue))
  public static let macGujarati = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macGujarati.rawValue))
  public static let macGurmukhi = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macGurmukhi.rawValue))
  public static let macHFS = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macHFS.rawValue))
  public static let macHebrew = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macHebrew.rawValue))
  public static let macIcelandic = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macIcelandic.rawValue))
  public static let macInuit = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macInuit.rawValue))
  public static let macJapanese = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macJapanese.rawValue))
  public static let macKannada = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macKannada.rawValue))
  public static let macKhmer = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macKhmer.rawValue))
  public static let macKorean = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macKorean.rawValue))
  public static let macLaotian = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macLaotian.rawValue))
  public static let macMalayalam = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macMalayalam.rawValue))
  public static let macMongolian = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macMongolian.rawValue))
  public static let macOriya = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macOriya.rawValue))
  public static let macRomanLatin1 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macRomanLatin1.rawValue))
  public static let macRomanian = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macRomanian.rawValue))
  public static let macSinhalese = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macSinhalese.rawValue))
  public static let macSymbol = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macSymbol.rawValue))
  public static let macTamil = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macTamil.rawValue))
  public static let macTelugu = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macTelugu.rawValue))
  public static let macThai = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macThai.rawValue))
  public static let macTibetan = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macTibetan.rawValue))
  public static let macTurkish = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macTurkish.rawValue))
  public static let macUkrainian = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macUkrainian.rawValue))
  public static let macVT100 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macVT100.rawValue))
  public static let macVietnamese = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.macVietnamese.rawValue))
  public static let nextStepJapanese = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.nextStepJapanese.rawValue))
  public static let shiftJIS = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.shiftJIS.rawValue))
  public static let shiftJIS_X0213 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.shiftJIS_X0213.rawValue))
  public static let shiftJIS_X0213_MenKuTen = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.shiftJIS_X0213_MenKuTen.rawValue))
  public static let UTF7 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.UTF7.rawValue))
  public static let UTF7_IMAP = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.UTF7_IMAP.rawValue))
  public static let VISCII = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.VISCII.rawValue))
  public static let windowsArabic = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.windowsArabic.rawValue))
  public static let windowsBalticRim = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.windowsBalticRim.rawValue))
  public static let windowsCyrillic = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.windowsCyrillic.rawValue))
  public static let windowsGreek = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.windowsGreek.rawValue))
  public static let windowsHebrew = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.windowsHebrew.rawValue))
  public static let windowsKoreanJohab = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.windowsKoreanJohab.rawValue))
  public static let windowsLatin2 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.windowsLatin2.rawValue))
  public static let windowsLatin5 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.windowsLatin5.rawValue))
  public static let windowsVietnamese = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.windowsVietnamese.rawValue))
  public static let shiftJIS_X0213_00 = CFString.Encoding(rawValue:CFStringEncoding(CFStringEncodings.shiftJIS_X0213_00.rawValue))
  #else
  public static let macJapanese = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacJapanese))
  public static let macChineseTrad = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacChineseTrad))
  public static let macKorean = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacKorean))
  public static let macArabic = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacArabic))
  public static let macHebrew = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacHebrew))
  public static let macGreek = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacGreek))
  public static let macCyrillic = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacCyrillic))
  public static let macDevanagari = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacDevanagari))
  public static let macGurmukhi = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacGurmukhi))
  public static let macGujarati = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacGujarati))
  public static let macOriya = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacOriya))
  public static let macBengali = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacBengali))
  public static let macTamil = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacTamil))
  public static let macTelugu = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacTelugu))
  public static let macKannada = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacKannada))
  public static let macMalayalam = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacMalayalam))
  public static let macSinhalese = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacSinhalese))
  public static let macBurmese = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacBurmese))
  public static let macKhmer = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacKhmer))
  public static let macThai = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacThai))
  public static let macLaotian = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacLaotian))
  public static let macGeorgian = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacGeorgian))
  public static let macArmenian = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacArmenian))
  public static let macChineseSimp = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacChineseSimp))
  public static let macTibetan = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacTibetan))
  public static let macMongolian = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacMongolian))
  public static let macEthiopic = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacEthiopic))
  public static let macCentralEurRoman = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacCentralEurRoman))
  public static let macVietnamese = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacVietnamese))
  public static let macExtArabic = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacExtArabic))
  public static let macSymbol = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacSymbol))
  public static let macDingbats = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacDingbats))
  public static let macTurkish = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacTurkish))
  public static let macCroatian = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacCroatian))
  public static let macIcelandic = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacIcelandic))
  public static let macRomanian = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacRomanian))
  public static let macCeltic = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacCeltic))
  public static let macGaelic = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacGaelic))
  public static let macFarsi = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacFarsi))
  public static let macUkrainian = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacUkrainian))
  public static let macInuit = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacInuit))
  public static let macVT100 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacVT100))
  public static let macHFS = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacHFS))
  public static let isoLatin2 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISOLatin2))
  public static let isoLatin3 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISOLatin3))
  public static let isoLatin4 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISOLatin4))
  public static let isoLatinCyrillic = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISOLatinCyrillic))
  public static let isoLatinArabic = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISOLatinArabic))
  public static let isoLatinGreek = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISOLatinGreek))
  public static let isoLatinHebrew = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISOLatinHebrew))
  public static let isoLatin5 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISOLatin5))
  public static let isoLatin6 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISOLatin6))
  public static let isoLatinThai = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISOLatinThai))
  public static let isoLatin7 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISOLatin7))
  public static let isoLatin8 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISOLatin8))
  public static let isoLatin9 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISOLatin9))
  public static let isoLatin10 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISOLatin10))
  public static let dosLatinUS = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSLatinUS))
  public static let dosGreek = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSGreek))
  public static let dosBalticRim = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSBalticRim))
  public static let dosLatin1 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSLatin1))
  public static let dosGreek1 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSGreek1))
  public static let dosLatin2 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSLatin2))
  public static let dosCyrillic = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSCyrillic))
  public static let dosTurkish = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSTurkish))
  public static let dosPortuguese = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSPortuguese))
  public static let dosIcelandic = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSIcelandic))
  public static let dosHebrew = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSHebrew))
  public static let dosCanadianFrench = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSCanadianFrench))
  public static let dosArabic = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSArabic))
  public static let dosNordic = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSNordic))
  public static let dosRussian = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSRussian))
  public static let dosGreek2 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSGreek2))
  public static let dosThai = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSThai))
  public static let dosJapanese = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSJapanese))
  public static let dosChineseSimplif = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSChineseSimplif))
  public static let dosKorean = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSKorean))
  public static let dosChineseTrad = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingDOSChineseTrad))
  public static let windowsLatin2 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingWindowsLatin2))
  public static let windowsCyrillic = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingWindowsCyrillic))
  public static let windowsGreek = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingWindowsGreek))
  public static let windowsLatin5 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingWindowsLatin5))
  public static let windowsHebrew = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingWindowsHebrew))
  public static let windowsArabic = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingWindowsArabic))
  public static let windowsBalticRim = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingWindowsBalticRim))
  public static let windowsVietnamese = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingWindowsVietnamese))
  public static let windowsKoreanJohab = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingWindowsKoreanJohab))
  public static let ANSEL = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingANSEL))
  public static let JIS_X0201_76 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingJIS_X0201_76))
  public static let JIS_X0208_83 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingJIS_X0208_83))
  public static let JIS_X0208_90 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingJIS_X0208_90))
  public static let JIS_X0212_90 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingJIS_X0212_90))
  public static let JIS_C6226_78 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingJIS_C6226_78))
  public static let ShiftJIS_X0213 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingShiftJIS_X0213))
  public static let ShiftJIS_X0213_MenKuTen = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingShiftJIS_X0213_MenKuTen))
  public static let GB_2312_80 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingGB_2312_80))
  public static let GBK_95 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingGBK_95))
  public static let GB_18030_2000 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingGB_18030_2000))
  public static let KSC_5601_87 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingKSC_5601_87))
  public static let KSC_5601_92_Johab = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingKSC_5601_92_Johab))
  public static let CNS_11643_92_P1 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingCNS_11643_92_P1))
  public static let CNS_11643_92_P2 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingCNS_11643_92_P2))
  public static let CNS_11643_92_P3 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingCNS_11643_92_P3))
  public static let ISO_2022_JP = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISO_2022_JP))
  public static let ISO_2022_JP_2 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISO_2022_JP_2))
  public static let ISO_2022_JP_1 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISO_2022_JP_1))
  public static let ISO_2022_JP_3 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISO_2022_JP_3))
  public static let ISO_2022_CN = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISO_2022_CN))
  public static let ISO_2022_CN_EXT = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISO_2022_CN_EXT))
  public static let ISO_2022_KR = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingISO_2022_KR))
  public static let EUC_JP = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingEUC_JP))
  public static let EUC_CN = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingEUC_CN))
  public static let EUC_TW = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingEUC_TW))
  public static let EUC_KR = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingEUC_KR))
  public static let shiftJIS = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingShiftJIS))
  public static let KOI8_R = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingKOI8_R))
  public static let big5 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingBig5))
  public static let macRomanLatin1 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingMacRomanLatin1))
  public static let HZ_GB_2312 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingHZ_GB_2312))
  public static let big5_HKSCS_1999 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingBig5_HKSCS_1999))
  public static let VISCII = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingVISCII))
  public static let KOI8_U = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingKOI8_U))
  public static let big5_E = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingBig5_E))
  public static let nextStepJapanese = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingNextStepJapanese))
  public static let EBCDIC_US = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingEBCDIC_US))
  public static let EBCDIC_CP037 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingEBCDIC_CP037))
  public static let UTF7 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingUTF7))
  public static let UTF7_IMAP = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingUTF7_IMAP))
  public static let shiftJIS_X0213_00 = CFString.Encoding(rawValue:CFStringEncoding(kCFStringEncodingShiftJIS_X0213_00))
  #endif
}