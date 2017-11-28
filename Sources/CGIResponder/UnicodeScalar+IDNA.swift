/***************************************************************************************************
 UnicodeScalar+IDNA.swift
   This file was created automatically
   from http://www.unicode.org/Public/idna/latest/IdnaMappingTable.txt
   at 2017-11-28T09:15:55+09:00
 **************************************************************************************************/

/*
  UNICODE, INC. LICENSE AGREEMENT - DATA FILES AND SOFTWARE
  
  Unicode Data Files include all data files under the directories
  http://www.unicode.org/Public/, http://www.unicode.org/reports/,
  http://www.unicode.org/cldr/data/, http://source.icu-project.org/repos/icu/, and
  http://www.unicode.org/utility/trac/browser/.
  
  Unicode Data Files do not include PDF online code charts under the
  directory http://www.unicode.org/Public/.
  
  Software includes any source code published in the Unicode Standard
  or under the directories
  http://www.unicode.org/Public/, http://www.unicode.org/reports/,
  http://www.unicode.org/cldr/data/, http://source.icu-project.org/repos/icu/, and
  http://www.unicode.org/utility/trac/browser/.
  
  NOTICE TO USER: Carefully read the following legal agreement.
  BY DOWNLOADING, INSTALLING, COPYING OR OTHERWISE USING UNICODE INC.'S
  DATA FILES ("DATA FILES"), AND/OR SOFTWARE ("SOFTWARE"),
  YOU UNEQUIVOCALLY ACCEPT, AND AGREE TO BE BOUND BY, ALL OF THE
  TERMS AND CONDITIONS OF THIS AGREEMENT.
  IF YOU DO NOT AGREE, DO NOT DOWNLOAD, INSTALL, COPY, DISTRIBUTE OR USE
  THE DATA FILES OR SOFTWARE.
  
  COPYRIGHT AND PERMISSION NOTICE
  
  Copyright © 1991-2017 Unicode, Inc. All rights reserved.
  Distributed under the Terms of Use in http://www.unicode.org/copyright.html.
  
  Permission is hereby granted, free of charge, to any person obtaining
  a copy of the Unicode data files and any associated documentation
  (the "Data Files") or Unicode software and any associated documentation
  (the "Software") to deal in the Data Files or Software
  without restriction, including without limitation the rights to use,
  copy, modify, merge, publish, distribute, and/or sell copies of
  the Data Files or Software, and to permit persons to whom the Data Files
  or Software are furnished to do so, provided that either
  (a) this copyright and permission notice appear with all copies
  of the Data Files or Software, or
  (b) this copyright and permission notice appear in associated
  Documentation.
  
  THE DATA FILES AND SOFTWARE ARE PROVIDED "AS IS", WITHOUT WARRANTY OF
  ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
  NONINFRINGEMENT OF THIRD PARTY RIGHTS.
  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR HOLDERS INCLUDED IN THIS
  NOTICE BE LIABLE FOR ANY CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL
  DAMAGES, OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
  DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
  TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
  PERFORMANCE OF THE DATA FILES OR SOFTWARE.
  
  Except as contained in this notice, the name of a copyright holder
  shall not be used in advertising or otherwise to promote the sale,
  use or other dealings in these Data Files or Software without prior
  written authorization of the copyright holder.

 */


extension UnicodeScalar {
  public enum IDNAStatus {
    case valid
    case ignored
    case mapped([UnicodeScalar]?)
    case deviation([UnicodeScalar]?)
    case disallowed
  }
}
extension UnicodeScalar {
  fileprivate var isValidButDisallowedInIDNA2008: Bool {
    let value: UInt32 = self.value
    if (0x00A1 <= value && value <= 0x00A7) { return true }
    if value == 0x00A9 { return true }
    if (0x00AB <= value && value <= 0x00AC) { return true }
    if value == 0x00AE { return true }
    if (0x00B0 <= value && value <= 0x00B1) { return true }
    if value == 0x00B6 { return true }
    if value == 0x00BB { return true }
    if value == 0x00BF { return true }
    if value == 0x00D7 { return true }
    if value == 0x00F7 { return true }
    if (0x02C2 <= value && value <= 0x02C5) { return true }
    if (0x02D2 <= value && value <= 0x02D7) { return true }
    if value == 0x02DE { return true }
    if value == 0x02DF { return true }
    if (0x02E5 <= value && value <= 0x02E9) { return true }
    if (0x02EA <= value && value <= 0x02EB) { return true }
    if value == 0x02ED { return true }
    if (0x02EF <= value && value <= 0x02FF) { return true }
    if value == 0x03F6 { return true }
    if value == 0x0482 { return true }
    if (0x0488 <= value && value <= 0x0489) { return true }
    if (0x055A <= value && value <= 0x055F) { return true }
    if value == 0x0589 { return true }
    if value == 0x058A { return true }
    if (0x058D <= value && value <= 0x058E) { return true }
    if value == 0x058F { return true }
    if value == 0x05BE { return true }
    if value == 0x05C0 { return true }
    if value == 0x05C3 { return true }
    if value == 0x05C6 { return true }
    if (0x0606 <= value && value <= 0x060A) { return true }
    if value == 0x060B { return true }
    if value == 0x060C { return true }
    if (0x060D <= value && value <= 0x060F) { return true }
    if value == 0x061B { return true }
    if value == 0x061E { return true }
    if value == 0x061F { return true }
    if value == 0x0640 { return true }
    if (0x066A <= value && value <= 0x066D) { return true }
    if value == 0x06D4 { return true }
    if value == 0x06DE { return true }
    if value == 0x06E9 { return true }
    if (0x0700 <= value && value <= 0x070D) { return true }
    if (0x07F6 <= value && value <= 0x07FA) { return true }
    if (0x0830 <= value && value <= 0x083E) { return true }
    if value == 0x085E { return true }
    if (0x0964 <= value && value <= 0x0965) { return true }
    if value == 0x0970 { return true }
    if (0x09F2 <= value && value <= 0x09FA) { return true }
    if value == 0x09FB { return true }
    if value == 0x09FD { return true }
    if value == 0x0AF0 { return true }
    if value == 0x0AF1 { return true }
    if value == 0x0B70 { return true }
    if (0x0B72 <= value && value <= 0x0B77) { return true }
    if (0x0BF0 <= value && value <= 0x0BF2) { return true }
    if (0x0BF3 <= value && value <= 0x0BFA) { return true }
    if (0x0C78 <= value && value <= 0x0C7F) { return true }
    if value == 0x0D4F { return true }
    if (0x0D58 <= value && value <= 0x0D5E) { return true }
    if (0x0D70 <= value && value <= 0x0D75) { return true }
    if (0x0D76 <= value && value <= 0x0D78) { return true }
    if value == 0x0D79 { return true }
    if value == 0x0DF4 { return true }
    if value == 0x0E3F { return true }
    if value == 0x0E4F { return true }
    if (0x0E5A <= value && value <= 0x0E5B) { return true }
    if (0x0F01 <= value && value <= 0x0F0A) { return true }
    if (0x0F0D <= value && value <= 0x0F17) { return true }
    if (0x0F1A <= value && value <= 0x0F1F) { return true }
    if (0x0F2A <= value && value <= 0x0F34) { return true }
    if value == 0x0F36 { return true }
    if value == 0x0F38 { return true }
    if (0x0F3A <= value && value <= 0x0F3D) { return true }
    if value == 0x0F85 { return true }
    if (0x0FBE <= value && value <= 0x0FC5) { return true }
    if (0x0FC7 <= value && value <= 0x0FCC) { return true }
    if value == 0x0FCE { return true }
    if value == 0x0FCF { return true }
    if (0x0FD0 <= value && value <= 0x0FD1) { return true }
    if (0x0FD2 <= value && value <= 0x0FD4) { return true }
    if (0x0FD5 <= value && value <= 0x0FD8) { return true }
    if (0x0FD9 <= value && value <= 0x0FDA) { return true }
    if (0x104A <= value && value <= 0x104F) { return true }
    if (0x109E <= value && value <= 0x109F) { return true }
    if value == 0x10FB { return true }
    if (0x1100 <= value && value <= 0x1159) { return true }
    if (0x115A <= value && value <= 0x115E) { return true }
    if (0x1161 <= value && value <= 0x11A2) { return true }
    if (0x11A3 <= value && value <= 0x11A7) { return true }
    if (0x11A8 <= value && value <= 0x11F9) { return true }
    if (0x11FA <= value && value <= 0x11FF) { return true }
    if value == 0x1360 { return true }
    if (0x1361 <= value && value <= 0x137C) { return true }
    if (0x1390 <= value && value <= 0x1399) { return true }
    if value == 0x1400 { return true }
    if (0x166D <= value && value <= 0x166E) { return true }
    if (0x169B <= value && value <= 0x169C) { return true }
    if (0x16EB <= value && value <= 0x16F0) { return true }
    if (0x1735 <= value && value <= 0x1736) { return true }
    if (0x17D4 <= value && value <= 0x17D6) { return true }
    if (0x17D8 <= value && value <= 0x17DB) { return true }
    if (0x17F0 <= value && value <= 0x17F9) { return true }
    if (0x1800 <= value && value <= 0x1805) { return true }
    if (0x1807 <= value && value <= 0x180A) { return true }
    if value == 0x1940 { return true }
    if (0x1944 <= value && value <= 0x1945) { return true }
    if value == 0x19DA { return true }
    if (0x19DE <= value && value <= 0x19DF) { return true }
    if (0x19E0 <= value && value <= 0x19FF) { return true }
    if (0x1A1E <= value && value <= 0x1A1F) { return true }
    if (0x1AA0 <= value && value <= 0x1AA6) { return true }
    if (0x1AA8 <= value && value <= 0x1AAD) { return true }
    if value == 0x1ABE { return true }
    if (0x1B5A <= value && value <= 0x1B6A) { return true }
    if (0x1B74 <= value && value <= 0x1B7C) { return true }
    if (0x1BFC <= value && value <= 0x1BFF) { return true }
    if (0x1C3B <= value && value <= 0x1C3F) { return true }
    if (0x1C7E <= value && value <= 0x1C7F) { return true }
    if (0x1CC0 <= value && value <= 0x1CC7) { return true }
    if value == 0x1CD3 { return true }
    if value == 0x2010 { return true }
    if (0x2012 <= value && value <= 0x2016) { return true }
    if (0x2018 <= value && value <= 0x2023) { return true }
    if value == 0x2027 { return true }
    if (0x2030 <= value && value <= 0x2032) { return true }
    if value == 0x2035 { return true }
    if (0x2038 <= value && value <= 0x203B) { return true }
    if value == 0x203D { return true }
    if (0x203F <= value && value <= 0x2046) { return true }
    if (0x204A <= value && value <= 0x204D) { return true }
    if (0x204E <= value && value <= 0x2052) { return true }
    if (0x2053 <= value && value <= 0x2054) { return true }
    if (0x2055 <= value && value <= 0x2056) { return true }
    if (0x2058 <= value && value <= 0x205E) { return true }
    if (0x20A0 <= value && value <= 0x20A7) { return true }
    if (0x20A9 <= value && value <= 0x20AA) { return true }
    if value == 0x20AB { return true }
    if value == 0x20AC { return true }
    if (0x20AD <= value && value <= 0x20AF) { return true }
    if (0x20B0 <= value && value <= 0x20B1) { return true }
    if (0x20B2 <= value && value <= 0x20B5) { return true }
    if (0x20B6 <= value && value <= 0x20B8) { return true }
    if value == 0x20B9 { return true }
    if value == 0x20BA { return true }
    if (0x20BB <= value && value <= 0x20BD) { return true }
    if value == 0x20BE { return true }
    if value == 0x20BF { return true }
    if (0x20D0 <= value && value <= 0x20E1) { return true }
    if (0x20E2 <= value && value <= 0x20E3) { return true }
    if (0x20E4 <= value && value <= 0x20EA) { return true }
    if value == 0x20EB { return true }
    if (0x20EC <= value && value <= 0x20EF) { return true }
    if value == 0x20F0 { return true }
    if value == 0x2104 { return true }
    if value == 0x2108 { return true }
    if value == 0x2114 { return true }
    if (0x2117 <= value && value <= 0x2118) { return true }
    if (0x211E <= value && value <= 0x211F) { return true }
    if value == 0x2123 { return true }
    if value == 0x2125 { return true }
    if value == 0x2127 { return true }
    if value == 0x2129 { return true }
    if value == 0x212E { return true }
    if value == 0x213A { return true }
    if (0x2141 <= value && value <= 0x2144) { return true }
    if (0x214A <= value && value <= 0x214B) { return true }
    if value == 0x214C { return true }
    if value == 0x214D { return true }
    if value == 0x214F { return true }
    if (0x2180 <= value && value <= 0x2182) { return true }
    if (0x2185 <= value && value <= 0x2188) { return true }
    if (0x218A <= value && value <= 0x218B) { return true }
    if (0x2190 <= value && value <= 0x21EA) { return true }
    if (0x21EB <= value && value <= 0x21F3) { return true }
    if (0x21F4 <= value && value <= 0x21FF) { return true }
    if (0x2200 <= value && value <= 0x222B) { return true }
    if value == 0x222E { return true }
    if (0x2231 <= value && value <= 0x225F) { return true }
    if (0x2261 <= value && value <= 0x226D) { return true }
    if (0x2270 <= value && value <= 0x22F1) { return true }
    if (0x22F2 <= value && value <= 0x22FF) { return true }
    if value == 0x2300 { return true }
    if value == 0x2301 { return true }
    if (0x2302 <= value && value <= 0x2328) { return true }
    if (0x232B <= value && value <= 0x237A) { return true }
    if value == 0x237B { return true }
    if value == 0x237C { return true }
    if (0x237D <= value && value <= 0x239A) { return true }
    if (0x239B <= value && value <= 0x23CE) { return true }
    if (0x23CF <= value && value <= 0x23D0) { return true }
    if (0x23D1 <= value && value <= 0x23DB) { return true }
    if (0x23DC <= value && value <= 0x23E7) { return true }
    if value == 0x23E8 { return true }
    if (0x23E9 <= value && value <= 0x23F3) { return true }
    if (0x23F4 <= value && value <= 0x23FA) { return true }
    if (0x23FB <= value && value <= 0x23FE) { return true }
    if value == 0x23FF { return true }
    if (0x2400 <= value && value <= 0x2424) { return true }
    if (0x2425 <= value && value <= 0x2426) { return true }
    if (0x2440 <= value && value <= 0x244A) { return true }
    if (0x24EB <= value && value <= 0x24FE) { return true }
    if value == 0x24FF { return true }
    if (0x2500 <= value && value <= 0x2595) { return true }
    if (0x2596 <= value && value <= 0x259F) { return true }
    if (0x25A0 <= value && value <= 0x25EF) { return true }
    if (0x25F0 <= value && value <= 0x25F7) { return true }
    if (0x25F8 <= value && value <= 0x25FF) { return true }
    if (0x2600 <= value && value <= 0x2613) { return true }
    if (0x2614 <= value && value <= 0x2615) { return true }
    if (0x2616 <= value && value <= 0x2617) { return true }
    if value == 0x2618 { return true }
    if value == 0x2619 { return true }
    if (0x261A <= value && value <= 0x266F) { return true }
    if (0x2670 <= value && value <= 0x2671) { return true }
    if (0x2672 <= value && value <= 0x267D) { return true }
    if (0x267E <= value && value <= 0x267F) { return true }
    if (0x2680 <= value && value <= 0x2689) { return true }
    if (0x268A <= value && value <= 0x2691) { return true }
    if (0x2692 <= value && value <= 0x269C) { return true }
    if value == 0x269D { return true }
    if (0x269E <= value && value <= 0x269F) { return true }
    if (0x26A0 <= value && value <= 0x26A1) { return true }
    if (0x26A2 <= value && value <= 0x26B1) { return true }
    if value == 0x26B2 { return true }
    if (0x26B3 <= value && value <= 0x26BC) { return true }
    if (0x26BD <= value && value <= 0x26BF) { return true }
    if (0x26C0 <= value && value <= 0x26C3) { return true }
    if (0x26C4 <= value && value <= 0x26CD) { return true }
    if value == 0x26CE { return true }
    if (0x26CF <= value && value <= 0x26E1) { return true }
    if value == 0x26E2 { return true }
    if value == 0x26E3 { return true }
    if (0x26E4 <= value && value <= 0x26E7) { return true }
    if (0x26E8 <= value && value <= 0x26FF) { return true }
    if value == 0x2700 { return true }
    if (0x2701 <= value && value <= 0x2704) { return true }
    if value == 0x2705 { return true }
    if (0x2706 <= value && value <= 0x2709) { return true }
    if (0x270A <= value && value <= 0x270B) { return true }
    if (0x270C <= value && value <= 0x2727) { return true }
    if value == 0x2728 { return true }
    if (0x2729 <= value && value <= 0x274B) { return true }
    if value == 0x274C { return true }
    if value == 0x274D { return true }
    if value == 0x274E { return true }
    if (0x274F <= value && value <= 0x2752) { return true }
    if (0x2753 <= value && value <= 0x2755) { return true }
    if value == 0x2756 { return true }
    if value == 0x2757 { return true }
    if (0x2758 <= value && value <= 0x275E) { return true }
    if (0x275F <= value && value <= 0x2760) { return true }
    if (0x2761 <= value && value <= 0x2767) { return true }
    if (0x2768 <= value && value <= 0x2775) { return true }
    if (0x2776 <= value && value <= 0x2794) { return true }
    if (0x2795 <= value && value <= 0x2797) { return true }
    if (0x2798 <= value && value <= 0x27AF) { return true }
    if value == 0x27B0 { return true }
    if (0x27B1 <= value && value <= 0x27BE) { return true }
    if value == 0x27BF { return true }
    if (0x27C0 <= value && value <= 0x27C6) { return true }
    if (0x27C7 <= value && value <= 0x27CA) { return true }
    if value == 0x27CB { return true }
    if value == 0x27CC { return true }
    if value == 0x27CD { return true }
    if (0x27CE <= value && value <= 0x27CF) { return true }
    if (0x27D0 <= value && value <= 0x27EB) { return true }
    if (0x27EC <= value && value <= 0x27EF) { return true }
    if (0x27F0 <= value && value <= 0x27FF) { return true }
    if (0x2800 <= value && value <= 0x28FF) { return true }
    if (0x2900 <= value && value <= 0x2A0B) { return true }
    if (0x2A0D <= value && value <= 0x2A73) { return true }
    if (0x2A77 <= value && value <= 0x2ADB) { return true }
    if (0x2ADD <= value && value <= 0x2AFF) { return true }
    if (0x2B00 <= value && value <= 0x2B0D) { return true }
    if (0x2B0E <= value && value <= 0x2B13) { return true }
    if (0x2B14 <= value && value <= 0x2B1A) { return true }
    if (0x2B1B <= value && value <= 0x2B1F) { return true }
    if (0x2B20 <= value && value <= 0x2B23) { return true }
    if (0x2B24 <= value && value <= 0x2B4C) { return true }
    if (0x2B4D <= value && value <= 0x2B4F) { return true }
    if (0x2B50 <= value && value <= 0x2B54) { return true }
    if (0x2B55 <= value && value <= 0x2B59) { return true }
    if (0x2B5A <= value && value <= 0x2B73) { return true }
    if (0x2B76 <= value && value <= 0x2B95) { return true }
    if (0x2B98 <= value && value <= 0x2BB9) { return true }
    if (0x2BBD <= value && value <= 0x2BC8) { return true }
    if (0x2BCA <= value && value <= 0x2BD1) { return true }
    if value == 0x2BD2 { return true }
    if (0x2BEC <= value && value <= 0x2BEF) { return true }
    if (0x2CE5 <= value && value <= 0x2CEA) { return true }
    if (0x2CF9 <= value && value <= 0x2CFF) { return true }
    if value == 0x2D70 { return true }
    if (0x2E00 <= value && value <= 0x2E17) { return true }
    if (0x2E18 <= value && value <= 0x2E1B) { return true }
    if (0x2E1C <= value && value <= 0x2E1D) { return true }
    if (0x2E1E <= value && value <= 0x2E2E) { return true }
    if value == 0x2E30 { return true }
    if value == 0x2E31 { return true }
    if (0x2E32 <= value && value <= 0x2E3B) { return true }
    if (0x2E3C <= value && value <= 0x2E42) { return true }
    if (0x2E43 <= value && value <= 0x2E44) { return true }
    if (0x2E45 <= value && value <= 0x2E49) { return true }
    if (0x2E80 <= value && value <= 0x2E99) { return true }
    if (0x2E9B <= value && value <= 0x2E9E) { return true }
    if (0x2EA0 <= value && value <= 0x2EF2) { return true }
    if value == 0x3001 { return true }
    if (0x3003 <= value && value <= 0x3004) { return true }
    if (0x3008 <= value && value <= 0x3029) { return true }
    if (0x302E <= value && value <= 0x3035) { return true }
    if value == 0x3037 { return true }
    if value == 0x303B { return true }
    if value == 0x303D { return true }
    if value == 0x303E { return true }
    if value == 0x303F { return true }
    if value == 0x30A0 { return true }
    if (0x3190 <= value && value <= 0x3191) { return true }
    if (0x31C0 <= value && value <= 0x31CF) { return true }
    if (0x31D0 <= value && value <= 0x31E3) { return true }
    if (0x3248 <= value && value <= 0x324F) { return true }
    if value == 0x327F { return true }
    if (0x4DC0 <= value && value <= 0x4DFF) { return true }
    if (0xA490 <= value && value <= 0xA4A1) { return true }
    if (0xA4A2 <= value && value <= 0xA4A3) { return true }
    if (0xA4A4 <= value && value <= 0xA4B3) { return true }
    if value == 0xA4B4 { return true }
    if (0xA4B5 <= value && value <= 0xA4C0) { return true }
    if value == 0xA4C1 { return true }
    if (0xA4C2 <= value && value <= 0xA4C4) { return true }
    if value == 0xA4C5 { return true }
    if value == 0xA4C6 { return true }
    if (0xA4FE <= value && value <= 0xA4FF) { return true }
    if (0xA60D <= value && value <= 0xA60F) { return true }
    if (0xA670 <= value && value <= 0xA673) { return true }
    if value == 0xA67E { return true }
    if (0xA6E6 <= value && value <= 0xA6EF) { return true }
    if (0xA6F2 <= value && value <= 0xA6F7) { return true }
    if (0xA700 <= value && value <= 0xA716) { return true }
    if (0xA720 <= value && value <= 0xA721) { return true }
    if (0xA789 <= value && value <= 0xA78A) { return true }
    if (0xA828 <= value && value <= 0xA82B) { return true }
    if (0xA830 <= value && value <= 0xA839) { return true }
    if (0xA874 <= value && value <= 0xA877) { return true }
    if (0xA8CE <= value && value <= 0xA8CF) { return true }
    if (0xA8F8 <= value && value <= 0xA8FA) { return true }
    if value == 0xA8FC { return true }
    if (0xA92E <= value && value <= 0xA92F) { return true }
    if value == 0xA95F { return true }
    if (0xA960 <= value && value <= 0xA97C) { return true }
    if (0xA9C1 <= value && value <= 0xA9CD) { return true }
    if (0xA9DE <= value && value <= 0xA9DF) { return true }
    if (0xAA5C <= value && value <= 0xAA5F) { return true }
    if (0xAA77 <= value && value <= 0xAA79) { return true }
    if (0xAADE <= value && value <= 0xAADF) { return true }
    if (0xAAF0 <= value && value <= 0xAAF1) { return true }
    if value == 0xAB5B { return true }
    if value == 0xABEB { return true }
    if (0xD7B0 <= value && value <= 0xD7C6) { return true }
    if (0xD7CB <= value && value <= 0xD7FB) { return true }
    if (0xFBB2 <= value && value <= 0xFBC1) { return true }
    if (0xFD3E <= value && value <= 0xFD3F) { return true }
    if value == 0xFDFD { return true }
    if (0xFE45 <= value && value <= 0xFE46) { return true }
    if (0x10100 <= value && value <= 0x10102) { return true }
    if (0x10107 <= value && value <= 0x10133) { return true }
    if (0x10137 <= value && value <= 0x1013F) { return true }
    if (0x10140 <= value && value <= 0x1018A) { return true }
    if (0x1018B <= value && value <= 0x1018C) { return true }
    if (0x1018D <= value && value <= 0x1018E) { return true }
    if (0x10190 <= value && value <= 0x1019B) { return true }
    if value == 0x101A0 { return true }
    if (0x101D0 <= value && value <= 0x101FC) { return true }
    if (0x102E1 <= value && value <= 0x102FB) { return true }
    if (0x10320 <= value && value <= 0x10323) { return true }
    if value == 0x10341 { return true }
    if value == 0x1034A { return true }
    if value == 0x1039F { return true }
    if (0x103D0 <= value && value <= 0x103D5) { return true }
    if value == 0x1056F { return true }
    if (0x10857 <= value && value <= 0x1085F) { return true }
    if (0x10877 <= value && value <= 0x1087F) { return true }
    if (0x108A7 <= value && value <= 0x108AF) { return true }
    if (0x108FB <= value && value <= 0x108FF) { return true }
    if (0x10916 <= value && value <= 0x10919) { return true }
    if (0x1091A <= value && value <= 0x1091B) { return true }
    if value == 0x1091F { return true }
    if value == 0x1093F { return true }
    if (0x109BC <= value && value <= 0x109BD) { return true }
    if (0x109C0 <= value && value <= 0x109CF) { return true }
    if (0x109D2 <= value && value <= 0x109FF) { return true }
    if (0x10A40 <= value && value <= 0x10A47) { return true }
    if (0x10A50 <= value && value <= 0x10A58) { return true }
    if (0x10A7D <= value && value <= 0x10A7F) { return true }
    if (0x10A9D <= value && value <= 0x10A9F) { return true }
    if value == 0x10AC8 { return true }
    if (0x10AEB <= value && value <= 0x10AF6) { return true }
    if (0x10B39 <= value && value <= 0x10B3F) { return true }
    if (0x10B58 <= value && value <= 0x10B5F) { return true }
    if (0x10B78 <= value && value <= 0x10B7F) { return true }
    if (0x10B99 <= value && value <= 0x10B9C) { return true }
    if (0x10BA9 <= value && value <= 0x10BAF) { return true }
    if (0x10CFA <= value && value <= 0x10CFF) { return true }
    if (0x10E60 <= value && value <= 0x10E7E) { return true }
    if (0x11047 <= value && value <= 0x1104D) { return true }
    if (0x11052 <= value && value <= 0x11065) { return true }
    if (0x110BB <= value && value <= 0x110BC) { return true }
    if (0x110BE <= value && value <= 0x110C1) { return true }
    if (0x11140 <= value && value <= 0x11143) { return true }
    if (0x11174 <= value && value <= 0x11175) { return true }
    if (0x111C5 <= value && value <= 0x111C8) { return true }
    if value == 0x111C9 { return true }
    if value == 0x111CD { return true }
    if value == 0x111DB { return true }
    if (0x111DD <= value && value <= 0x111DF) { return true }
    if (0x111E1 <= value && value <= 0x111F4) { return true }
    if (0x11238 <= value && value <= 0x1123D) { return true }
    if value == 0x112A9 { return true }
    if (0x1144B <= value && value <= 0x1144F) { return true }
    if value == 0x1145B { return true }
    if value == 0x1145D { return true }
    if value == 0x114C6 { return true }
    if (0x115C1 <= value && value <= 0x115C9) { return true }
    if (0x115CA <= value && value <= 0x115D7) { return true }
    if (0x11641 <= value && value <= 0x11643) { return true }
    if (0x11660 <= value && value <= 0x1166C) { return true }
    if (0x1173A <= value && value <= 0x1173F) { return true }
    if (0x118EA <= value && value <= 0x118F2) { return true }
    if (0x11A3F <= value && value <= 0x11A46) { return true }
    if (0x11A9A <= value && value <= 0x11A9C) { return true }
    if (0x11A9E <= value && value <= 0x11AA2) { return true }
    if (0x11C41 <= value && value <= 0x11C45) { return true }
    if (0x11C5A <= value && value <= 0x11C6C) { return true }
    if (0x11C70 <= value && value <= 0x11C71) { return true }
    if (0x12400 <= value && value <= 0x12462) { return true }
    if (0x12463 <= value && value <= 0x1246E) { return true }
    if (0x12470 <= value && value <= 0x12473) { return true }
    if value == 0x12474 { return true }
    if (0x16A6E <= value && value <= 0x16A6F) { return true }
    if value == 0x16AF5 { return true }
    if (0x16B37 <= value && value <= 0x16B3F) { return true }
    if (0x16B44 <= value && value <= 0x16B45) { return true }
    if (0x16B5B <= value && value <= 0x16B61) { return true }
    if value == 0x1BC9C { return true }
    if value == 0x1BC9F { return true }
    if (0x1D000 <= value && value <= 0x1D0F5) { return true }
    if (0x1D100 <= value && value <= 0x1D126) { return true }
    if value == 0x1D129 { return true }
    if (0x1D12A <= value && value <= 0x1D15D) { return true }
    if (0x1D165 <= value && value <= 0x1D172) { return true }
    if (0x1D17B <= value && value <= 0x1D1BA) { return true }
    if (0x1D1C1 <= value && value <= 0x1D1DD) { return true }
    if (0x1D1DE <= value && value <= 0x1D1E8) { return true }
    if (0x1D200 <= value && value <= 0x1D245) { return true }
    if (0x1D300 <= value && value <= 0x1D356) { return true }
    if (0x1D360 <= value && value <= 0x1D371) { return true }
    if (0x1D800 <= value && value <= 0x1D9FF) { return true }
    if (0x1DA37 <= value && value <= 0x1DA3A) { return true }
    if (0x1DA6D <= value && value <= 0x1DA74) { return true }
    if (0x1DA76 <= value && value <= 0x1DA83) { return true }
    if (0x1DA85 <= value && value <= 0x1DA8B) { return true }
    if (0x1E8C7 <= value && value <= 0x1E8CF) { return true }
    if (0x1E95E <= value && value <= 0x1E95F) { return true }
    if (0x1EEF0 <= value && value <= 0x1EEF1) { return true }
    if (0x1F000 <= value && value <= 0x1F02B) { return true }
    if (0x1F030 <= value && value <= 0x1F093) { return true }
    if (0x1F0A0 <= value && value <= 0x1F0AE) { return true }
    if (0x1F0B1 <= value && value <= 0x1F0BE) { return true }
    if value == 0x1F0BF { return true }
    if (0x1F0C1 <= value && value <= 0x1F0CF) { return true }
    if (0x1F0D1 <= value && value <= 0x1F0DF) { return true }
    if (0x1F0E0 <= value && value <= 0x1F0F5) { return true }
    if (0x1F10B <= value && value <= 0x1F10C) { return true }
    if (0x1F150 <= value && value <= 0x1F156) { return true }
    if value == 0x1F157 { return true }
    if (0x1F158 <= value && value <= 0x1F15E) { return true }
    if value == 0x1F15F { return true }
    if (0x1F160 <= value && value <= 0x1F169) { return true }
    if (0x1F170 <= value && value <= 0x1F178) { return true }
    if value == 0x1F179 { return true }
    if value == 0x1F17A { return true }
    if (0x1F17B <= value && value <= 0x1F17C) { return true }
    if (0x1F17D <= value && value <= 0x1F17E) { return true }
    if value == 0x1F17F { return true }
    if (0x1F180 <= value && value <= 0x1F189) { return true }
    if (0x1F18A <= value && value <= 0x1F18D) { return true }
    if (0x1F18E <= value && value <= 0x1F18F) { return true }
    if (0x1F191 <= value && value <= 0x1F19A) { return true }
    if (0x1F19B <= value && value <= 0x1F1AC) { return true }
    if (0x1F1E6 <= value && value <= 0x1F1FF) { return true }
    if (0x1F260 <= value && value <= 0x1F265) { return true }
    if (0x1F300 <= value && value <= 0x1F320) { return true }
    if (0x1F321 <= value && value <= 0x1F32C) { return true }
    if (0x1F32D <= value && value <= 0x1F32F) { return true }
    if (0x1F330 <= value && value <= 0x1F335) { return true }
    if value == 0x1F336 { return true }
    if (0x1F337 <= value && value <= 0x1F37C) { return true }
    if value == 0x1F37D { return true }
    if (0x1F37E <= value && value <= 0x1F37F) { return true }
    if (0x1F380 <= value && value <= 0x1F393) { return true }
    if (0x1F394 <= value && value <= 0x1F39F) { return true }
    if (0x1F3A0 <= value && value <= 0x1F3C4) { return true }
    if value == 0x1F3C5 { return true }
    if (0x1F3C6 <= value && value <= 0x1F3CA) { return true }
    if (0x1F3CB <= value && value <= 0x1F3CE) { return true }
    if (0x1F3CF <= value && value <= 0x1F3D3) { return true }
    if (0x1F3D4 <= value && value <= 0x1F3DF) { return true }
    if (0x1F3E0 <= value && value <= 0x1F3F0) { return true }
    if (0x1F3F1 <= value && value <= 0x1F3F7) { return true }
    if (0x1F3F8 <= value && value <= 0x1F3FF) { return true }
    if (0x1F400 <= value && value <= 0x1F43E) { return true }
    if value == 0x1F43F { return true }
    if value == 0x1F440 { return true }
    if value == 0x1F441 { return true }
    if (0x1F442 <= value && value <= 0x1F4F7) { return true }
    if value == 0x1F4F8 { return true }
    if (0x1F4F9 <= value && value <= 0x1F4FC) { return true }
    if (0x1F4FD <= value && value <= 0x1F4FE) { return true }
    if value == 0x1F4FF { return true }
    if (0x1F500 <= value && value <= 0x1F53D) { return true }
    if (0x1F53E <= value && value <= 0x1F53F) { return true }
    if (0x1F540 <= value && value <= 0x1F543) { return true }
    if (0x1F544 <= value && value <= 0x1F54A) { return true }
    if (0x1F54B <= value && value <= 0x1F54F) { return true }
    if (0x1F550 <= value && value <= 0x1F567) { return true }
    if (0x1F568 <= value && value <= 0x1F579) { return true }
    if value == 0x1F57A { return true }
    if (0x1F57B <= value && value <= 0x1F5A3) { return true }
    if value == 0x1F5A4 { return true }
    if (0x1F5A5 <= value && value <= 0x1F5FA) { return true }
    if (0x1F5FB <= value && value <= 0x1F5FF) { return true }
    if value == 0x1F600 { return true }
    if (0x1F601 <= value && value <= 0x1F610) { return true }
    if value == 0x1F611 { return true }
    if (0x1F612 <= value && value <= 0x1F614) { return true }
    if value == 0x1F615 { return true }
    if value == 0x1F616 { return true }
    if value == 0x1F617 { return true }
    if value == 0x1F618 { return true }
    if value == 0x1F619 { return true }
    if value == 0x1F61A { return true }
    if value == 0x1F61B { return true }
    if (0x1F61C <= value && value <= 0x1F61E) { return true }
    if value == 0x1F61F { return true }
    if (0x1F620 <= value && value <= 0x1F625) { return true }
    if (0x1F626 <= value && value <= 0x1F627) { return true }
    if (0x1F628 <= value && value <= 0x1F62B) { return true }
    if value == 0x1F62C { return true }
    if value == 0x1F62D { return true }
    if (0x1F62E <= value && value <= 0x1F62F) { return true }
    if (0x1F630 <= value && value <= 0x1F633) { return true }
    if value == 0x1F634 { return true }
    if (0x1F635 <= value && value <= 0x1F640) { return true }
    if (0x1F641 <= value && value <= 0x1F642) { return true }
    if (0x1F643 <= value && value <= 0x1F644) { return true }
    if (0x1F645 <= value && value <= 0x1F64F) { return true }
    if (0x1F650 <= value && value <= 0x1F67F) { return true }
    if (0x1F680 <= value && value <= 0x1F6C5) { return true }
    if (0x1F6C6 <= value && value <= 0x1F6CF) { return true }
    if value == 0x1F6D0 { return true }
    if (0x1F6D1 <= value && value <= 0x1F6D2) { return true }
    if (0x1F6D3 <= value && value <= 0x1F6D4) { return true }
    if (0x1F6E0 <= value && value <= 0x1F6EC) { return true }
    if (0x1F6F0 <= value && value <= 0x1F6F3) { return true }
    if (0x1F6F4 <= value && value <= 0x1F6F6) { return true }
    if (0x1F6F7 <= value && value <= 0x1F6F8) { return true }
    if (0x1F700 <= value && value <= 0x1F773) { return true }
    if (0x1F780 <= value && value <= 0x1F7D4) { return true }
    if (0x1F800 <= value && value <= 0x1F80B) { return true }
    if (0x1F810 <= value && value <= 0x1F847) { return true }
    if (0x1F850 <= value && value <= 0x1F859) { return true }
    if (0x1F860 <= value && value <= 0x1F887) { return true }
    if (0x1F890 <= value && value <= 0x1F8AD) { return true }
    if (0x1F900 <= value && value <= 0x1F90B) { return true }
    if (0x1F910 <= value && value <= 0x1F918) { return true }
    if (0x1F919 <= value && value <= 0x1F91E) { return true }
    if value == 0x1F91F { return true }
    if (0x1F920 <= value && value <= 0x1F927) { return true }
    if (0x1F928 <= value && value <= 0x1F92F) { return true }
    if value == 0x1F930 { return true }
    if (0x1F931 <= value && value <= 0x1F932) { return true }
    if (0x1F933 <= value && value <= 0x1F93E) { return true }
    if (0x1F940 <= value && value <= 0x1F94B) { return true }
    if value == 0x1F94C { return true }
    if (0x1F950 <= value && value <= 0x1F95E) { return true }
    if (0x1F95F <= value && value <= 0x1F96B) { return true }
    if (0x1F980 <= value && value <= 0x1F984) { return true }
    if (0x1F985 <= value && value <= 0x1F991) { return true }
    if (0x1F992 <= value && value <= 0x1F997) { return true }
    if value == 0x1F9C0 { return true }
    if (0x1F9D0 <= value && value <= 0x1F9E6) { return true }
    return false
  }
  fileprivate var isValid: Bool {
    let value: UInt32 = self.value
    if (0x002D <= value && value <= 0x002E) { return true }
    if (0x0030 <= value && value <= 0x0039) { return true }
    if (0x0061 <= value && value <= 0x007A) { return true }
    if value == 0x00B7 { return true }
    if (0x00E0 <= value && value <= 0x00F6) { return true }
    if (0x00F8 <= value && value <= 0x00FF) { return true }
    if value == 0x0101 { return true }
    if value == 0x0103 { return true }
    if value == 0x0105 { return true }
    if value == 0x0107 { return true }
    if value == 0x0109 { return true }
    if value == 0x010B { return true }
    if value == 0x010D { return true }
    if value == 0x010F { return true }
    if value == 0x0111 { return true }
    if value == 0x0113 { return true }
    if value == 0x0115 { return true }
    if value == 0x0117 { return true }
    if value == 0x0119 { return true }
    if value == 0x011B { return true }
    if value == 0x011D { return true }
    if value == 0x011F { return true }
    if value == 0x0121 { return true }
    if value == 0x0123 { return true }
    if value == 0x0125 { return true }
    if value == 0x0127 { return true }
    if value == 0x0129 { return true }
    if value == 0x012B { return true }
    if value == 0x012D { return true }
    if value == 0x012F { return true }
    if value == 0x0131 { return true }
    if value == 0x0135 { return true }
    if (0x0137 <= value && value <= 0x0138) { return true }
    if value == 0x013A { return true }
    if value == 0x013C { return true }
    if value == 0x013E { return true }
    if value == 0x0142 { return true }
    if value == 0x0144 { return true }
    if value == 0x0146 { return true }
    if value == 0x0148 { return true }
    if value == 0x014B { return true }
    if value == 0x014D { return true }
    if value == 0x014F { return true }
    if value == 0x0151 { return true }
    if value == 0x0153 { return true }
    if value == 0x0155 { return true }
    if value == 0x0157 { return true }
    if value == 0x0159 { return true }
    if value == 0x015B { return true }
    if value == 0x015D { return true }
    if value == 0x015F { return true }
    if value == 0x0161 { return true }
    if value == 0x0163 { return true }
    if value == 0x0165 { return true }
    if value == 0x0167 { return true }
    if value == 0x0169 { return true }
    if value == 0x016B { return true }
    if value == 0x016D { return true }
    if value == 0x016F { return true }
    if value == 0x0171 { return true }
    if value == 0x0173 { return true }
    if value == 0x0175 { return true }
    if value == 0x0177 { return true }
    if value == 0x017A { return true }
    if value == 0x017C { return true }
    if value == 0x017E { return true }
    if value == 0x0180 { return true }
    if value == 0x0183 { return true }
    if value == 0x0185 { return true }
    if value == 0x0188 { return true }
    if (0x018C <= value && value <= 0x018D) { return true }
    if value == 0x0192 { return true }
    if value == 0x0195 { return true }
    if (0x0199 <= value && value <= 0x019B) { return true }
    if value == 0x019E { return true }
    if value == 0x01A1 { return true }
    if value == 0x01A3 { return true }
    if value == 0x01A5 { return true }
    if value == 0x01A8 { return true }
    if (0x01AA <= value && value <= 0x01AB) { return true }
    if value == 0x01AD { return true }
    if value == 0x01B0 { return true }
    if value == 0x01B4 { return true }
    if value == 0x01B6 { return true }
    if (0x01B9 <= value && value <= 0x01BB) { return true }
    if (0x01BD <= value && value <= 0x01C3) { return true }
    if value == 0x01CE { return true }
    if value == 0x01D0 { return true }
    if value == 0x01D2 { return true }
    if value == 0x01D4 { return true }
    if value == 0x01D6 { return true }
    if value == 0x01D8 { return true }
    if value == 0x01DA { return true }
    if (0x01DC <= value && value <= 0x01DD) { return true }
    if value == 0x01DF { return true }
    if value == 0x01E1 { return true }
    if value == 0x01E3 { return true }
    if value == 0x01E5 { return true }
    if value == 0x01E7 { return true }
    if value == 0x01E9 { return true }
    if value == 0x01EB { return true }
    if value == 0x01ED { return true }
    if (0x01EF <= value && value <= 0x01F0) { return true }
    if value == 0x01F5 { return true }
    if value == 0x01F9 { return true }
    if value == 0x01FB { return true }
    if value == 0x01FD { return true }
    if value == 0x01FF { return true }
    if value == 0x0201 { return true }
    if value == 0x0203 { return true }
    if value == 0x0205 { return true }
    if value == 0x0207 { return true }
    if value == 0x0209 { return true }
    if value == 0x020B { return true }
    if value == 0x020D { return true }
    if value == 0x020F { return true }
    if value == 0x0211 { return true }
    if value == 0x0213 { return true }
    if value == 0x0215 { return true }
    if value == 0x0217 { return true }
    if value == 0x0219 { return true }
    if value == 0x021B { return true }
    if value == 0x021D { return true }
    if value == 0x021F { return true }
    if value == 0x0221 { return true }
    if value == 0x0223 { return true }
    if value == 0x0225 { return true }
    if value == 0x0227 { return true }
    if value == 0x0229 { return true }
    if value == 0x022B { return true }
    if value == 0x022D { return true }
    if value == 0x022F { return true }
    if value == 0x0231 { return true }
    if value == 0x0233 { return true }
    if (0x0234 <= value && value <= 0x0236) { return true }
    if (0x0237 <= value && value <= 0x0239) { return true }
    if value == 0x023C { return true }
    if (0x023F <= value && value <= 0x0240) { return true }
    if value == 0x0242 { return true }
    if value == 0x0247 { return true }
    if value == 0x0249 { return true }
    if value == 0x024B { return true }
    if value == 0x024D { return true }
    if value == 0x024F { return true }
    if (0x0250 <= value && value <= 0x02A8) { return true }
    if (0x02A9 <= value && value <= 0x02AD) { return true }
    if (0x02AE <= value && value <= 0x02AF) { return true }
    if (0x02B9 <= value && value <= 0x02C1) { return true }
    if (0x02C6 <= value && value <= 0x02D1) { return true }
    if value == 0x02EC { return true }
    if value == 0x02EE { return true }
    if (0x0300 <= value && value <= 0x033F) { return true }
    if value == 0x0342 { return true }
    if (0x0346 <= value && value <= 0x034E) { return true }
    if (0x0350 <= value && value <= 0x0357) { return true }
    if (0x0358 <= value && value <= 0x035C) { return true }
    if (0x035D <= value && value <= 0x035F) { return true }
    if (0x0360 <= value && value <= 0x0361) { return true }
    if value == 0x0362 { return true }
    if (0x0363 <= value && value <= 0x036F) { return true }
    if value == 0x0371 { return true }
    if value == 0x0373 { return true }
    if value == 0x0375 { return true }
    if value == 0x0377 { return true }
    if (0x037B <= value && value <= 0x037D) { return true }
    if value == 0x0390 { return true }
    if (0x03AC <= value && value <= 0x03C1) { return true }
    if (0x03C3 <= value && value <= 0x03CE) { return true }
    if value == 0x03D7 { return true }
    if value == 0x03D9 { return true }
    if value == 0x03DB { return true }
    if value == 0x03DD { return true }
    if value == 0x03DF { return true }
    if value == 0x03E1 { return true }
    if value == 0x03E3 { return true }
    if value == 0x03E5 { return true }
    if value == 0x03E7 { return true }
    if value == 0x03E9 { return true }
    if value == 0x03EB { return true }
    if value == 0x03ED { return true }
    if value == 0x03EF { return true }
    if value == 0x03F3 { return true }
    if value == 0x03F8 { return true }
    if value == 0x03FB { return true }
    if value == 0x03FC { return true }
    if (0x0430 <= value && value <= 0x044F) { return true }
    if value == 0x0450 { return true }
    if (0x0451 <= value && value <= 0x045C) { return true }
    if value == 0x045D { return true }
    if (0x045E <= value && value <= 0x045F) { return true }
    if value == 0x0461 { return true }
    if value == 0x0463 { return true }
    if value == 0x0465 { return true }
    if value == 0x0467 { return true }
    if value == 0x0469 { return true }
    if value == 0x046B { return true }
    if value == 0x046D { return true }
    if value == 0x046F { return true }
    if value == 0x0471 { return true }
    if value == 0x0473 { return true }
    if value == 0x0475 { return true }
    if value == 0x0477 { return true }
    if value == 0x0479 { return true }
    if value == 0x047B { return true }
    if value == 0x047D { return true }
    if value == 0x047F { return true }
    if value == 0x0481 { return true }
    if (0x0483 <= value && value <= 0x0486) { return true }
    if value == 0x0487 { return true }
    if value == 0x048B { return true }
    if value == 0x048D { return true }
    if value == 0x048F { return true }
    if value == 0x0491 { return true }
    if value == 0x0493 { return true }
    if value == 0x0495 { return true }
    if value == 0x0497 { return true }
    if value == 0x0499 { return true }
    if value == 0x049B { return true }
    if value == 0x049D { return true }
    if value == 0x049F { return true }
    if value == 0x04A1 { return true }
    if value == 0x04A3 { return true }
    if value == 0x04A5 { return true }
    if value == 0x04A7 { return true }
    if value == 0x04A9 { return true }
    if value == 0x04AB { return true }
    if value == 0x04AD { return true }
    if value == 0x04AF { return true }
    if value == 0x04B1 { return true }
    if value == 0x04B3 { return true }
    if value == 0x04B5 { return true }
    if value == 0x04B7 { return true }
    if value == 0x04B9 { return true }
    if value == 0x04BB { return true }
    if value == 0x04BD { return true }
    if value == 0x04BF { return true }
    if value == 0x04C2 { return true }
    if value == 0x04C4 { return true }
    if value == 0x04C6 { return true }
    if value == 0x04C8 { return true }
    if value == 0x04CA { return true }
    if value == 0x04CC { return true }
    if value == 0x04CE { return true }
    if value == 0x04CF { return true }
    if value == 0x04D1 { return true }
    if value == 0x04D3 { return true }
    if value == 0x04D5 { return true }
    if value == 0x04D7 { return true }
    if value == 0x04D9 { return true }
    if value == 0x04DB { return true }
    if value == 0x04DD { return true }
    if value == 0x04DF { return true }
    if value == 0x04E1 { return true }
    if value == 0x04E3 { return true }
    if value == 0x04E5 { return true }
    if value == 0x04E7 { return true }
    if value == 0x04E9 { return true }
    if value == 0x04EB { return true }
    if value == 0x04ED { return true }
    if value == 0x04EF { return true }
    if value == 0x04F1 { return true }
    if value == 0x04F3 { return true }
    if value == 0x04F5 { return true }
    if value == 0x04F7 { return true }
    if value == 0x04F9 { return true }
    if value == 0x04FB { return true }
    if value == 0x04FD { return true }
    if value == 0x04FF { return true }
    if value == 0x0501 { return true }
    if value == 0x0503 { return true }
    if value == 0x0505 { return true }
    if value == 0x0507 { return true }
    if value == 0x0509 { return true }
    if value == 0x050B { return true }
    if value == 0x050D { return true }
    if value == 0x050F { return true }
    if value == 0x0511 { return true }
    if value == 0x0513 { return true }
    if value == 0x0515 { return true }
    if value == 0x0517 { return true }
    if value == 0x0519 { return true }
    if value == 0x051B { return true }
    if value == 0x051D { return true }
    if value == 0x051F { return true }
    if value == 0x0521 { return true }
    if value == 0x0523 { return true }
    if value == 0x0525 { return true }
    if value == 0x0527 { return true }
    if value == 0x0529 { return true }
    if value == 0x052B { return true }
    if value == 0x052D { return true }
    if value == 0x052F { return true }
    if value == 0x0559 { return true }
    if (0x0561 <= value && value <= 0x0586) { return true }
    if (0x0591 <= value && value <= 0x05A1) { return true }
    if value == 0x05A2 { return true }
    if (0x05A3 <= value && value <= 0x05AF) { return true }
    if (0x05B0 <= value && value <= 0x05B9) { return true }
    if value == 0x05BA { return true }
    if (0x05BB <= value && value <= 0x05BD) { return true }
    if value == 0x05BF { return true }
    if (0x05C1 <= value && value <= 0x05C2) { return true }
    if value == 0x05C4 { return true }
    if value == 0x05C5 { return true }
    if value == 0x05C7 { return true }
    if (0x05D0 <= value && value <= 0x05EA) { return true }
    if (0x05F0 <= value && value <= 0x05F4) { return true }
    if (0x0610 <= value && value <= 0x0615) { return true }
    if (0x0616 <= value && value <= 0x061A) { return true }
    if value == 0x0620 { return true }
    if (0x0621 <= value && value <= 0x063A) { return true }
    if (0x063B <= value && value <= 0x063F) { return true }
    if (0x0641 <= value && value <= 0x0652) { return true }
    if (0x0653 <= value && value <= 0x0655) { return true }
    if (0x0656 <= value && value <= 0x0658) { return true }
    if (0x0659 <= value && value <= 0x065E) { return true }
    if value == 0x065F { return true }
    if (0x0660 <= value && value <= 0x0669) { return true }
    if (0x066E <= value && value <= 0x066F) { return true }
    if (0x0670 <= value && value <= 0x0674) { return true }
    if (0x0679 <= value && value <= 0x06B7) { return true }
    if (0x06B8 <= value && value <= 0x06B9) { return true }
    if (0x06BA <= value && value <= 0x06BE) { return true }
    if value == 0x06BF { return true }
    if (0x06C0 <= value && value <= 0x06CE) { return true }
    if value == 0x06CF { return true }
    if (0x06D0 <= value && value <= 0x06D3) { return true }
    if (0x06D5 <= value && value <= 0x06DC) { return true }
    if (0x06DF <= value && value <= 0x06E8) { return true }
    if (0x06EA <= value && value <= 0x06ED) { return true }
    if (0x06EE <= value && value <= 0x06EF) { return true }
    if (0x06F0 <= value && value <= 0x06F9) { return true }
    if (0x06FA <= value && value <= 0x06FE) { return true }
    if value == 0x06FF { return true }
    if (0x0710 <= value && value <= 0x072C) { return true }
    if (0x072D <= value && value <= 0x072F) { return true }
    if (0x0730 <= value && value <= 0x074A) { return true }
    if (0x074D <= value && value <= 0x074F) { return true }
    if (0x0750 <= value && value <= 0x076D) { return true }
    if (0x076E <= value && value <= 0x077F) { return true }
    if (0x0780 <= value && value <= 0x07B0) { return true }
    if value == 0x07B1 { return true }
    if (0x07C0 <= value && value <= 0x07F5) { return true }
    if (0x0800 <= value && value <= 0x082D) { return true }
    if (0x0840 <= value && value <= 0x085B) { return true }
    if (0x0860 <= value && value <= 0x086A) { return true }
    if value == 0x08A0 { return true }
    if value == 0x08A1 { return true }
    if (0x08A2 <= value && value <= 0x08AC) { return true }
    if (0x08AD <= value && value <= 0x08B2) { return true }
    if (0x08B3 <= value && value <= 0x08B4) { return true }
    if (0x08B6 <= value && value <= 0x08BD) { return true }
    if (0x08D4 <= value && value <= 0x08E1) { return true }
    if value == 0x08E3 { return true }
    if (0x08E4 <= value && value <= 0x08FE) { return true }
    if value == 0x08FF { return true }
    if value == 0x0900 { return true }
    if (0x0901 <= value && value <= 0x0903) { return true }
    if value == 0x0904 { return true }
    if (0x0905 <= value && value <= 0x0939) { return true }
    if (0x093A <= value && value <= 0x093B) { return true }
    if (0x093C <= value && value <= 0x094D) { return true }
    if value == 0x094E { return true }
    if value == 0x094F { return true }
    if (0x0950 <= value && value <= 0x0954) { return true }
    if value == 0x0955 { return true }
    if (0x0956 <= value && value <= 0x0957) { return true }
    if (0x0960 <= value && value <= 0x0963) { return true }
    if (0x0966 <= value && value <= 0x096F) { return true }
    if (0x0971 <= value && value <= 0x0972) { return true }
    if (0x0973 <= value && value <= 0x0977) { return true }
    if value == 0x0978 { return true }
    if (0x0979 <= value && value <= 0x097A) { return true }
    if (0x097B <= value && value <= 0x097C) { return true }
    if value == 0x097D { return true }
    if (0x097E <= value && value <= 0x097F) { return true }
    if value == 0x0980 { return true }
    if (0x0981 <= value && value <= 0x0983) { return true }
    if (0x0985 <= value && value <= 0x098C) { return true }
    if (0x098F <= value && value <= 0x0990) { return true }
    if (0x0993 <= value && value <= 0x09A8) { return true }
    if (0x09AA <= value && value <= 0x09B0) { return true }
    if value == 0x09B2 { return true }
    if (0x09B6 <= value && value <= 0x09B9) { return true }
    if value == 0x09BC { return true }
    if value == 0x09BD { return true }
    if (0x09BE <= value && value <= 0x09C4) { return true }
    if (0x09C7 <= value && value <= 0x09C8) { return true }
    if (0x09CB <= value && value <= 0x09CD) { return true }
    if value == 0x09CE { return true }
    if value == 0x09D7 { return true }
    if (0x09E0 <= value && value <= 0x09E3) { return true }
    if (0x09E6 <= value && value <= 0x09F1) { return true }
    if value == 0x09FC { return true }
    if value == 0x0A01 { return true }
    if value == 0x0A02 { return true }
    if value == 0x0A03 { return true }
    if (0x0A05 <= value && value <= 0x0A0A) { return true }
    if (0x0A0F <= value && value <= 0x0A10) { return true }
    if (0x0A13 <= value && value <= 0x0A28) { return true }
    if (0x0A2A <= value && value <= 0x0A30) { return true }
    if value == 0x0A32 { return true }
    if value == 0x0A35 { return true }
    if (0x0A38 <= value && value <= 0x0A39) { return true }
    if value == 0x0A3C { return true }
    if (0x0A3E <= value && value <= 0x0A42) { return true }
    if (0x0A47 <= value && value <= 0x0A48) { return true }
    if (0x0A4B <= value && value <= 0x0A4D) { return true }
    if value == 0x0A51 { return true }
    if value == 0x0A5C { return true }
    if (0x0A66 <= value && value <= 0x0A74) { return true }
    if value == 0x0A75 { return true }
    if (0x0A81 <= value && value <= 0x0A83) { return true }
    if (0x0A85 <= value && value <= 0x0A8B) { return true }
    if value == 0x0A8C { return true }
    if value == 0x0A8D { return true }
    if (0x0A8F <= value && value <= 0x0A91) { return true }
    if (0x0A93 <= value && value <= 0x0AA8) { return true }
    if (0x0AAA <= value && value <= 0x0AB0) { return true }
    if (0x0AB2 <= value && value <= 0x0AB3) { return true }
    if (0x0AB5 <= value && value <= 0x0AB9) { return true }
    if (0x0ABC <= value && value <= 0x0AC5) { return true }
    if (0x0AC7 <= value && value <= 0x0AC9) { return true }
    if (0x0ACB <= value && value <= 0x0ACD) { return true }
    if value == 0x0AD0 { return true }
    if value == 0x0AE0 { return true }
    if (0x0AE1 <= value && value <= 0x0AE3) { return true }
    if (0x0AE6 <= value && value <= 0x0AEF) { return true }
    if value == 0x0AF9 { return true }
    if (0x0AFA <= value && value <= 0x0AFF) { return true }
    if (0x0B01 <= value && value <= 0x0B03) { return true }
    if (0x0B05 <= value && value <= 0x0B0C) { return true }
    if (0x0B0F <= value && value <= 0x0B10) { return true }
    if (0x0B13 <= value && value <= 0x0B28) { return true }
    if (0x0B2A <= value && value <= 0x0B30) { return true }
    if (0x0B32 <= value && value <= 0x0B33) { return true }
    if value == 0x0B35 { return true }
    if (0x0B36 <= value && value <= 0x0B39) { return true }
    if (0x0B3C <= value && value <= 0x0B43) { return true }
    if value == 0x0B44 { return true }
    if (0x0B47 <= value && value <= 0x0B48) { return true }
    if (0x0B4B <= value && value <= 0x0B4D) { return true }
    if (0x0B56 <= value && value <= 0x0B57) { return true }
    if (0x0B5F <= value && value <= 0x0B61) { return true }
    if (0x0B62 <= value && value <= 0x0B63) { return true }
    if (0x0B66 <= value && value <= 0x0B6F) { return true }
    if value == 0x0B71 { return true }
    if (0x0B82 <= value && value <= 0x0B83) { return true }
    if (0x0B85 <= value && value <= 0x0B8A) { return true }
    if (0x0B8E <= value && value <= 0x0B90) { return true }
    if (0x0B92 <= value && value <= 0x0B95) { return true }
    if (0x0B99 <= value && value <= 0x0B9A) { return true }
    if value == 0x0B9C { return true }
    if (0x0B9E <= value && value <= 0x0B9F) { return true }
    if (0x0BA3 <= value && value <= 0x0BA4) { return true }
    if (0x0BA8 <= value && value <= 0x0BAA) { return true }
    if (0x0BAE <= value && value <= 0x0BB5) { return true }
    if value == 0x0BB6 { return true }
    if (0x0BB7 <= value && value <= 0x0BB9) { return true }
    if (0x0BBE <= value && value <= 0x0BC2) { return true }
    if (0x0BC6 <= value && value <= 0x0BC8) { return true }
    if (0x0BCA <= value && value <= 0x0BCD) { return true }
    if value == 0x0BD0 { return true }
    if value == 0x0BD7 { return true }
    if value == 0x0BE6 { return true }
    if (0x0BE7 <= value && value <= 0x0BEF) { return true }
    if value == 0x0C00 { return true }
    if (0x0C01 <= value && value <= 0x0C03) { return true }
    if (0x0C05 <= value && value <= 0x0C0C) { return true }
    if (0x0C0E <= value && value <= 0x0C10) { return true }
    if (0x0C12 <= value && value <= 0x0C28) { return true }
    if (0x0C2A <= value && value <= 0x0C33) { return true }
    if value == 0x0C34 { return true }
    if (0x0C35 <= value && value <= 0x0C39) { return true }
    if value == 0x0C3D { return true }
    if (0x0C3E <= value && value <= 0x0C44) { return true }
    if (0x0C46 <= value && value <= 0x0C48) { return true }
    if (0x0C4A <= value && value <= 0x0C4D) { return true }
    if (0x0C55 <= value && value <= 0x0C56) { return true }
    if (0x0C58 <= value && value <= 0x0C59) { return true }
    if value == 0x0C5A { return true }
    if (0x0C60 <= value && value <= 0x0C61) { return true }
    if (0x0C62 <= value && value <= 0x0C63) { return true }
    if (0x0C66 <= value && value <= 0x0C6F) { return true }
    if value == 0x0C80 { return true }
    if value == 0x0C81 { return true }
    if (0x0C82 <= value && value <= 0x0C83) { return true }
    if (0x0C85 <= value && value <= 0x0C8C) { return true }
    if (0x0C8E <= value && value <= 0x0C90) { return true }
    if (0x0C92 <= value && value <= 0x0CA8) { return true }
    if (0x0CAA <= value && value <= 0x0CB3) { return true }
    if (0x0CB5 <= value && value <= 0x0CB9) { return true }
    if (0x0CBC <= value && value <= 0x0CBD) { return true }
    if (0x0CBE <= value && value <= 0x0CC4) { return true }
    if (0x0CC6 <= value && value <= 0x0CC8) { return true }
    if (0x0CCA <= value && value <= 0x0CCD) { return true }
    if (0x0CD5 <= value && value <= 0x0CD6) { return true }
    if value == 0x0CDE { return true }
    if (0x0CE0 <= value && value <= 0x0CE1) { return true }
    if (0x0CE2 <= value && value <= 0x0CE3) { return true }
    if (0x0CE6 <= value && value <= 0x0CEF) { return true }
    if (0x0CF1 <= value && value <= 0x0CF2) { return true }
    if value == 0x0D00 { return true }
    if value == 0x0D01 { return true }
    if (0x0D02 <= value && value <= 0x0D03) { return true }
    if (0x0D05 <= value && value <= 0x0D0C) { return true }
    if (0x0D0E <= value && value <= 0x0D10) { return true }
    if (0x0D12 <= value && value <= 0x0D28) { return true }
    if value == 0x0D29 { return true }
    if (0x0D2A <= value && value <= 0x0D39) { return true }
    if value == 0x0D3A { return true }
    if (0x0D3B <= value && value <= 0x0D3C) { return true }
    if value == 0x0D3D { return true }
    if (0x0D3E <= value && value <= 0x0D43) { return true }
    if value == 0x0D44 { return true }
    if (0x0D46 <= value && value <= 0x0D48) { return true }
    if (0x0D4A <= value && value <= 0x0D4D) { return true }
    if value == 0x0D4E { return true }
    if (0x0D54 <= value && value <= 0x0D56) { return true }
    if value == 0x0D57 { return true }
    if value == 0x0D5F { return true }
    if (0x0D60 <= value && value <= 0x0D61) { return true }
    if (0x0D62 <= value && value <= 0x0D63) { return true }
    if (0x0D66 <= value && value <= 0x0D6F) { return true }
    if (0x0D7A <= value && value <= 0x0D7F) { return true }
    if (0x0D82 <= value && value <= 0x0D83) { return true }
    if (0x0D85 <= value && value <= 0x0D96) { return true }
    if (0x0D9A <= value && value <= 0x0DB1) { return true }
    if (0x0DB3 <= value && value <= 0x0DBB) { return true }
    if value == 0x0DBD { return true }
    if (0x0DC0 <= value && value <= 0x0DC6) { return true }
    if value == 0x0DCA { return true }
    if (0x0DCF <= value && value <= 0x0DD4) { return true }
    if value == 0x0DD6 { return true }
    if (0x0DD8 <= value && value <= 0x0DDF) { return true }
    if (0x0DE6 <= value && value <= 0x0DEF) { return true }
    if (0x0DF2 <= value && value <= 0x0DF3) { return true }
    if (0x0E01 <= value && value <= 0x0E32) { return true }
    if (0x0E34 <= value && value <= 0x0E3A) { return true }
    if (0x0E40 <= value && value <= 0x0E4E) { return true }
    if (0x0E50 <= value && value <= 0x0E59) { return true }
    if (0x0E81 <= value && value <= 0x0E82) { return true }
    if value == 0x0E84 { return true }
    if (0x0E87 <= value && value <= 0x0E88) { return true }
    if value == 0x0E8A { return true }
    if value == 0x0E8D { return true }
    if (0x0E94 <= value && value <= 0x0E97) { return true }
    if (0x0E99 <= value && value <= 0x0E9F) { return true }
    if (0x0EA1 <= value && value <= 0x0EA3) { return true }
    if value == 0x0EA5 { return true }
    if value == 0x0EA7 { return true }
    if (0x0EAA <= value && value <= 0x0EAB) { return true }
    if (0x0EAD <= value && value <= 0x0EB2) { return true }
    if (0x0EB4 <= value && value <= 0x0EB9) { return true }
    if (0x0EBB <= value && value <= 0x0EBD) { return true }
    if (0x0EC0 <= value && value <= 0x0EC4) { return true }
    if value == 0x0EC6 { return true }
    if (0x0EC8 <= value && value <= 0x0ECD) { return true }
    if (0x0ED0 <= value && value <= 0x0ED9) { return true }
    if (0x0EDE <= value && value <= 0x0EDF) { return true }
    if value == 0x0F00 { return true }
    if value == 0x0F0B { return true }
    if (0x0F18 <= value && value <= 0x0F19) { return true }
    if (0x0F20 <= value && value <= 0x0F29) { return true }
    if value == 0x0F35 { return true }
    if value == 0x0F37 { return true }
    if value == 0x0F39 { return true }
    if (0x0F3E <= value && value <= 0x0F42) { return true }
    if (0x0F44 <= value && value <= 0x0F47) { return true }
    if (0x0F49 <= value && value <= 0x0F4C) { return true }
    if (0x0F4E <= value && value <= 0x0F51) { return true }
    if (0x0F53 <= value && value <= 0x0F56) { return true }
    if (0x0F58 <= value && value <= 0x0F5B) { return true }
    if (0x0F5D <= value && value <= 0x0F68) { return true }
    if value == 0x0F6A { return true }
    if (0x0F6B <= value && value <= 0x0F6C) { return true }
    if (0x0F71 <= value && value <= 0x0F72) { return true }
    if value == 0x0F74 { return true }
    if (0x0F7A <= value && value <= 0x0F80) { return true }
    if (0x0F82 <= value && value <= 0x0F84) { return true }
    if (0x0F86 <= value && value <= 0x0F8B) { return true }
    if (0x0F8C <= value && value <= 0x0F8F) { return true }
    if (0x0F90 <= value && value <= 0x0F92) { return true }
    if (0x0F94 <= value && value <= 0x0F95) { return true }
    if value == 0x0F96 { return true }
    if value == 0x0F97 { return true }
    if (0x0F99 <= value && value <= 0x0F9C) { return true }
    if (0x0F9E <= value && value <= 0x0FA1) { return true }
    if (0x0FA3 <= value && value <= 0x0FA6) { return true }
    if (0x0FA8 <= value && value <= 0x0FAB) { return true }
    if value == 0x0FAD { return true }
    if (0x0FAE <= value && value <= 0x0FB0) { return true }
    if (0x0FB1 <= value && value <= 0x0FB7) { return true }
    if value == 0x0FB8 { return true }
    if (0x0FBA <= value && value <= 0x0FBC) { return true }
    if value == 0x0FC6 { return true }
    if (0x1000 <= value && value <= 0x1021) { return true }
    if value == 0x1022 { return true }
    if (0x1023 <= value && value <= 0x1027) { return true }
    if value == 0x1028 { return true }
    if (0x1029 <= value && value <= 0x102A) { return true }
    if value == 0x102B { return true }
    if (0x102C <= value && value <= 0x1032) { return true }
    if (0x1033 <= value && value <= 0x1035) { return true }
    if (0x1036 <= value && value <= 0x1039) { return true }
    if (0x103A <= value && value <= 0x103F) { return true }
    if (0x1040 <= value && value <= 0x1049) { return true }
    if (0x1050 <= value && value <= 0x1059) { return true }
    if (0x105A <= value && value <= 0x1099) { return true }
    if (0x109A <= value && value <= 0x109D) { return true }
    if (0x10D0 <= value && value <= 0x10F6) { return true }
    if (0x10F7 <= value && value <= 0x10F8) { return true }
    if (0x10F9 <= value && value <= 0x10FA) { return true }
    if (0x10FD <= value && value <= 0x10FF) { return true }
    if (0x1200 <= value && value <= 0x1206) { return true }
    if value == 0x1207 { return true }
    if (0x1208 <= value && value <= 0x1246) { return true }
    if value == 0x1247 { return true }
    if value == 0x1248 { return true }
    if (0x124A <= value && value <= 0x124D) { return true }
    if (0x1250 <= value && value <= 0x1256) { return true }
    if value == 0x1258 { return true }
    if (0x125A <= value && value <= 0x125D) { return true }
    if (0x1260 <= value && value <= 0x1286) { return true }
    if value == 0x1287 { return true }
    if value == 0x1288 { return true }
    if (0x128A <= value && value <= 0x128D) { return true }
    if (0x1290 <= value && value <= 0x12AE) { return true }
    if value == 0x12AF { return true }
    if value == 0x12B0 { return true }
    if (0x12B2 <= value && value <= 0x12B5) { return true }
    if (0x12B8 <= value && value <= 0x12BE) { return true }
    if value == 0x12C0 { return true }
    if (0x12C2 <= value && value <= 0x12C5) { return true }
    if (0x12C8 <= value && value <= 0x12CE) { return true }
    if value == 0x12CF { return true }
    if (0x12D0 <= value && value <= 0x12D6) { return true }
    if (0x12D8 <= value && value <= 0x12EE) { return true }
    if value == 0x12EF { return true }
    if (0x12F0 <= value && value <= 0x130E) { return true }
    if value == 0x130F { return true }
    if value == 0x1310 { return true }
    if (0x1312 <= value && value <= 0x1315) { return true }
    if (0x1318 <= value && value <= 0x131E) { return true }
    if value == 0x131F { return true }
    if (0x1320 <= value && value <= 0x1346) { return true }
    if value == 0x1347 { return true }
    if (0x1348 <= value && value <= 0x135A) { return true }
    if (0x135D <= value && value <= 0x135E) { return true }
    if value == 0x135F { return true }
    if (0x1380 <= value && value <= 0x138F) { return true }
    if (0x13A0 <= value && value <= 0x13F4) { return true }
    if value == 0x13F5 { return true }
    if (0x1401 <= value && value <= 0x166C) { return true }
    if (0x166F <= value && value <= 0x1676) { return true }
    if (0x1677 <= value && value <= 0x167F) { return true }
    if (0x1681 <= value && value <= 0x169A) { return true }
    if (0x16A0 <= value && value <= 0x16EA) { return true }
    if (0x16F1 <= value && value <= 0x16F8) { return true }
    if (0x1700 <= value && value <= 0x170C) { return true }
    if (0x170E <= value && value <= 0x1714) { return true }
    if (0x1720 <= value && value <= 0x1734) { return true }
    if (0x1740 <= value && value <= 0x1753) { return true }
    if (0x1760 <= value && value <= 0x176C) { return true }
    if (0x176E <= value && value <= 0x1770) { return true }
    if (0x1772 <= value && value <= 0x1773) { return true }
    if (0x1780 <= value && value <= 0x17B3) { return true }
    if (0x17B6 <= value && value <= 0x17D3) { return true }
    if value == 0x17D7 { return true }
    if value == 0x17DC { return true }
    if value == 0x17DD { return true }
    if (0x17E0 <= value && value <= 0x17E9) { return true }
    if (0x1810 <= value && value <= 0x1819) { return true }
    if (0x1820 <= value && value <= 0x1877) { return true }
    if (0x1880 <= value && value <= 0x18A9) { return true }
    if value == 0x18AA { return true }
    if (0x18B0 <= value && value <= 0x18F5) { return true }
    if (0x1900 <= value && value <= 0x191C) { return true }
    if (0x191D <= value && value <= 0x191E) { return true }
    if (0x1920 <= value && value <= 0x192B) { return true }
    if (0x1930 <= value && value <= 0x193B) { return true }
    if (0x1946 <= value && value <= 0x196D) { return true }
    if (0x1970 <= value && value <= 0x1974) { return true }
    if (0x1980 <= value && value <= 0x19A9) { return true }
    if (0x19AA <= value && value <= 0x19AB) { return true }
    if (0x19B0 <= value && value <= 0x19C9) { return true }
    if (0x19D0 <= value && value <= 0x19D9) { return true }
    if (0x1A00 <= value && value <= 0x1A1B) { return true }
    if (0x1A20 <= value && value <= 0x1A5E) { return true }
    if (0x1A60 <= value && value <= 0x1A7C) { return true }
    if (0x1A7F <= value && value <= 0x1A89) { return true }
    if (0x1A90 <= value && value <= 0x1A99) { return true }
    if value == 0x1AA7 { return true }
    if (0x1AB0 <= value && value <= 0x1ABD) { return true }
    if (0x1B00 <= value && value <= 0x1B4B) { return true }
    if (0x1B50 <= value && value <= 0x1B59) { return true }
    if (0x1B6B <= value && value <= 0x1B73) { return true }
    if (0x1B80 <= value && value <= 0x1BAA) { return true }
    if (0x1BAB <= value && value <= 0x1BAD) { return true }
    if (0x1BAE <= value && value <= 0x1BB9) { return true }
    if (0x1BBA <= value && value <= 0x1BBF) { return true }
    if (0x1BC0 <= value && value <= 0x1BF3) { return true }
    if (0x1C00 <= value && value <= 0x1C37) { return true }
    if (0x1C40 <= value && value <= 0x1C49) { return true }
    if (0x1C4D <= value && value <= 0x1C7D) { return true }
    if (0x1CD0 <= value && value <= 0x1CD2) { return true }
    if (0x1CD4 <= value && value <= 0x1CF2) { return true }
    if (0x1CF3 <= value && value <= 0x1CF6) { return true }
    if value == 0x1CF7 { return true }
    if (0x1CF8 <= value && value <= 0x1CF9) { return true }
    if (0x1D00 <= value && value <= 0x1D2B) { return true }
    if value == 0x1D2F { return true }
    if value == 0x1D3B { return true }
    if value == 0x1D4E { return true }
    if value == 0x1D6B { return true }
    if (0x1D6C <= value && value <= 0x1D77) { return true }
    if (0x1D79 <= value && value <= 0x1D9A) { return true }
    if (0x1DC0 <= value && value <= 0x1DC3) { return true }
    if (0x1DC4 <= value && value <= 0x1DCA) { return true }
    if (0x1DCB <= value && value <= 0x1DE6) { return true }
    if (0x1DE7 <= value && value <= 0x1DF5) { return true }
    if (0x1DF6 <= value && value <= 0x1DF9) { return true }
    if value == 0x1DFB { return true }
    if value == 0x1DFC { return true }
    if value == 0x1DFD { return true }
    if (0x1DFE <= value && value <= 0x1DFF) { return true }
    if value == 0x1E01 { return true }
    if value == 0x1E03 { return true }
    if value == 0x1E05 { return true }
    if value == 0x1E07 { return true }
    if value == 0x1E09 { return true }
    if value == 0x1E0B { return true }
    if value == 0x1E0D { return true }
    if value == 0x1E0F { return true }
    if value == 0x1E11 { return true }
    if value == 0x1E13 { return true }
    if value == 0x1E15 { return true }
    if value == 0x1E17 { return true }
    if value == 0x1E19 { return true }
    if value == 0x1E1B { return true }
    if value == 0x1E1D { return true }
    if value == 0x1E1F { return true }
    if value == 0x1E21 { return true }
    if value == 0x1E23 { return true }
    if value == 0x1E25 { return true }
    if value == 0x1E27 { return true }
    if value == 0x1E29 { return true }
    if value == 0x1E2B { return true }
    if value == 0x1E2D { return true }
    if value == 0x1E2F { return true }
    if value == 0x1E31 { return true }
    if value == 0x1E33 { return true }
    if value == 0x1E35 { return true }
    if value == 0x1E37 { return true }
    if value == 0x1E39 { return true }
    if value == 0x1E3B { return true }
    if value == 0x1E3D { return true }
    if value == 0x1E3F { return true }
    if value == 0x1E41 { return true }
    if value == 0x1E43 { return true }
    if value == 0x1E45 { return true }
    if value == 0x1E47 { return true }
    if value == 0x1E49 { return true }
    if value == 0x1E4B { return true }
    if value == 0x1E4D { return true }
    if value == 0x1E4F { return true }
    if value == 0x1E51 { return true }
    if value == 0x1E53 { return true }
    if value == 0x1E55 { return true }
    if value == 0x1E57 { return true }
    if value == 0x1E59 { return true }
    if value == 0x1E5B { return true }
    if value == 0x1E5D { return true }
    if value == 0x1E5F { return true }
    if value == 0x1E61 { return true }
    if value == 0x1E63 { return true }
    if value == 0x1E65 { return true }
    if value == 0x1E67 { return true }
    if value == 0x1E69 { return true }
    if value == 0x1E6B { return true }
    if value == 0x1E6D { return true }
    if value == 0x1E6F { return true }
    if value == 0x1E71 { return true }
    if value == 0x1E73 { return true }
    if value == 0x1E75 { return true }
    if value == 0x1E77 { return true }
    if value == 0x1E79 { return true }
    if value == 0x1E7B { return true }
    if value == 0x1E7D { return true }
    if value == 0x1E7F { return true }
    if value == 0x1E81 { return true }
    if value == 0x1E83 { return true }
    if value == 0x1E85 { return true }
    if value == 0x1E87 { return true }
    if value == 0x1E89 { return true }
    if value == 0x1E8B { return true }
    if value == 0x1E8D { return true }
    if value == 0x1E8F { return true }
    if value == 0x1E91 { return true }
    if value == 0x1E93 { return true }
    if (0x1E95 <= value && value <= 0x1E99) { return true }
    if (0x1E9C <= value && value <= 0x1E9D) { return true }
    if value == 0x1E9F { return true }
    if value == 0x1EA1 { return true }
    if value == 0x1EA3 { return true }
    if value == 0x1EA5 { return true }
    if value == 0x1EA7 { return true }
    if value == 0x1EA9 { return true }
    if value == 0x1EAB { return true }
    if value == 0x1EAD { return true }
    if value == 0x1EAF { return true }
    if value == 0x1EB1 { return true }
    if value == 0x1EB3 { return true }
    if value == 0x1EB5 { return true }
    if value == 0x1EB7 { return true }
    if value == 0x1EB9 { return true }
    if value == 0x1EBB { return true }
    if value == 0x1EBD { return true }
    if value == 0x1EBF { return true }
    if value == 0x1EC1 { return true }
    if value == 0x1EC3 { return true }
    if value == 0x1EC5 { return true }
    if value == 0x1EC7 { return true }
    if value == 0x1EC9 { return true }
    if value == 0x1ECB { return true }
    if value == 0x1ECD { return true }
    if value == 0x1ECF { return true }
    if value == 0x1ED1 { return true }
    if value == 0x1ED3 { return true }
    if value == 0x1ED5 { return true }
    if value == 0x1ED7 { return true }
    if value == 0x1ED9 { return true }
    if value == 0x1EDB { return true }
    if value == 0x1EDD { return true }
    if value == 0x1EDF { return true }
    if value == 0x1EE1 { return true }
    if value == 0x1EE3 { return true }
    if value == 0x1EE5 { return true }
    if value == 0x1EE7 { return true }
    if value == 0x1EE9 { return true }
    if value == 0x1EEB { return true }
    if value == 0x1EED { return true }
    if value == 0x1EEF { return true }
    if value == 0x1EF1 { return true }
    if value == 0x1EF3 { return true }
    if value == 0x1EF5 { return true }
    if value == 0x1EF7 { return true }
    if value == 0x1EF9 { return true }
    if value == 0x1EFB { return true }
    if value == 0x1EFD { return true }
    if value == 0x1EFF { return true }
    if (0x1F00 <= value && value <= 0x1F07) { return true }
    if (0x1F10 <= value && value <= 0x1F15) { return true }
    if (0x1F20 <= value && value <= 0x1F27) { return true }
    if (0x1F30 <= value && value <= 0x1F37) { return true }
    if (0x1F40 <= value && value <= 0x1F45) { return true }
    if (0x1F50 <= value && value <= 0x1F57) { return true }
    if (0x1F60 <= value && value <= 0x1F67) { return true }
    if value == 0x1F70 { return true }
    if value == 0x1F72 { return true }
    if value == 0x1F74 { return true }
    if value == 0x1F76 { return true }
    if value == 0x1F78 { return true }
    if value == 0x1F7A { return true }
    if value == 0x1F7C { return true }
    if (0x1FB0 <= value && value <= 0x1FB1) { return true }
    if value == 0x1FB6 { return true }
    if value == 0x1FC6 { return true }
    if (0x1FD0 <= value && value <= 0x1FD2) { return true }
    if (0x1FD6 <= value && value <= 0x1FD7) { return true }
    if (0x1FE0 <= value && value <= 0x1FE2) { return true }
    if (0x1FE4 <= value && value <= 0x1FE7) { return true }
    if value == 0x1FF6 { return true }
    if value == 0x214E { return true }
    if value == 0x2184 { return true }
    if (0x2C30 <= value && value <= 0x2C5E) { return true }
    if value == 0x2C61 { return true }
    if (0x2C65 <= value && value <= 0x2C66) { return true }
    if value == 0x2C68 { return true }
    if value == 0x2C6A { return true }
    if value == 0x2C6C { return true }
    if value == 0x2C71 { return true }
    if value == 0x2C73 { return true }
    if value == 0x2C74 { return true }
    if (0x2C76 <= value && value <= 0x2C77) { return true }
    if (0x2C78 <= value && value <= 0x2C7B) { return true }
    if value == 0x2C81 { return true }
    if value == 0x2C83 { return true }
    if value == 0x2C85 { return true }
    if value == 0x2C87 { return true }
    if value == 0x2C89 { return true }
    if value == 0x2C8B { return true }
    if value == 0x2C8D { return true }
    if value == 0x2C8F { return true }
    if value == 0x2C91 { return true }
    if value == 0x2C93 { return true }
    if value == 0x2C95 { return true }
    if value == 0x2C97 { return true }
    if value == 0x2C99 { return true }
    if value == 0x2C9B { return true }
    if value == 0x2C9D { return true }
    if value == 0x2C9F { return true }
    if value == 0x2CA1 { return true }
    if value == 0x2CA3 { return true }
    if value == 0x2CA5 { return true }
    if value == 0x2CA7 { return true }
    if value == 0x2CA9 { return true }
    if value == 0x2CAB { return true }
    if value == 0x2CAD { return true }
    if value == 0x2CAF { return true }
    if value == 0x2CB1 { return true }
    if value == 0x2CB3 { return true }
    if value == 0x2CB5 { return true }
    if value == 0x2CB7 { return true }
    if value == 0x2CB9 { return true }
    if value == 0x2CBB { return true }
    if value == 0x2CBD { return true }
    if value == 0x2CBF { return true }
    if value == 0x2CC1 { return true }
    if value == 0x2CC3 { return true }
    if value == 0x2CC5 { return true }
    if value == 0x2CC7 { return true }
    if value == 0x2CC9 { return true }
    if value == 0x2CCB { return true }
    if value == 0x2CCD { return true }
    if value == 0x2CCF { return true }
    if value == 0x2CD1 { return true }
    if value == 0x2CD3 { return true }
    if value == 0x2CD5 { return true }
    if value == 0x2CD7 { return true }
    if value == 0x2CD9 { return true }
    if value == 0x2CDB { return true }
    if value == 0x2CDD { return true }
    if value == 0x2CDF { return true }
    if value == 0x2CE1 { return true }
    if (0x2CE3 <= value && value <= 0x2CE4) { return true }
    if value == 0x2CEC { return true }
    if (0x2CEE <= value && value <= 0x2CF1) { return true }
    if value == 0x2CF3 { return true }
    if (0x2D00 <= value && value <= 0x2D25) { return true }
    if value == 0x2D27 { return true }
    if value == 0x2D2D { return true }
    if (0x2D30 <= value && value <= 0x2D65) { return true }
    if (0x2D66 <= value && value <= 0x2D67) { return true }
    if value == 0x2D7F { return true }
    if (0x2D80 <= value && value <= 0x2D96) { return true }
    if (0x2DA0 <= value && value <= 0x2DA6) { return true }
    if (0x2DA8 <= value && value <= 0x2DAE) { return true }
    if (0x2DB0 <= value && value <= 0x2DB6) { return true }
    if (0x2DB8 <= value && value <= 0x2DBE) { return true }
    if (0x2DC0 <= value && value <= 0x2DC6) { return true }
    if (0x2DC8 <= value && value <= 0x2DCE) { return true }
    if (0x2DD0 <= value && value <= 0x2DD6) { return true }
    if (0x2DD8 <= value && value <= 0x2DDE) { return true }
    if (0x2DE0 <= value && value <= 0x2DFF) { return true }
    if value == 0x2E2F { return true }
    if (0x3005 <= value && value <= 0x3007) { return true }
    if (0x302A <= value && value <= 0x302D) { return true }
    if value == 0x303C { return true }
    if (0x3041 <= value && value <= 0x3094) { return true }
    if (0x3095 <= value && value <= 0x3096) { return true }
    if (0x3099 <= value && value <= 0x309A) { return true }
    if (0x309D <= value && value <= 0x309E) { return true }
    if (0x30A1 <= value && value <= 0x30FE) { return true }
    if (0x3105 <= value && value <= 0x312C) { return true }
    if value == 0x312D { return true }
    if value == 0x312E { return true }
    if (0x31A0 <= value && value <= 0x31B7) { return true }
    if (0x31B8 <= value && value <= 0x31BA) { return true }
    if (0x31F0 <= value && value <= 0x31FF) { return true }
    if (0x3400 <= value && value <= 0x4DB5) { return true }
    if (0x4E00 <= value && value <= 0x9FA5) { return true }
    if (0x9FA6 <= value && value <= 0x9FBB) { return true }
    if (0x9FBC <= value && value <= 0x9FC3) { return true }
    if (0x9FC4 <= value && value <= 0x9FCB) { return true }
    if value == 0x9FCC { return true }
    if (0x9FCD <= value && value <= 0x9FD5) { return true }
    if (0x9FD6 <= value && value <= 0x9FEA) { return true }
    if (0xA000 <= value && value <= 0xA48C) { return true }
    if (0xA4D0 <= value && value <= 0xA4FD) { return true }
    if (0xA500 <= value && value <= 0xA60C) { return true }
    if (0xA610 <= value && value <= 0xA62B) { return true }
    if value == 0xA641 { return true }
    if value == 0xA643 { return true }
    if value == 0xA645 { return true }
    if value == 0xA647 { return true }
    if value == 0xA649 { return true }
    if value == 0xA64B { return true }
    if value == 0xA64D { return true }
    if value == 0xA64F { return true }
    if value == 0xA651 { return true }
    if value == 0xA653 { return true }
    if value == 0xA655 { return true }
    if value == 0xA657 { return true }
    if value == 0xA659 { return true }
    if value == 0xA65B { return true }
    if value == 0xA65D { return true }
    if value == 0xA65F { return true }
    if value == 0xA661 { return true }
    if value == 0xA663 { return true }
    if value == 0xA665 { return true }
    if value == 0xA667 { return true }
    if value == 0xA669 { return true }
    if value == 0xA66B { return true }
    if (0xA66D <= value && value <= 0xA66F) { return true }
    if (0xA674 <= value && value <= 0xA67B) { return true }
    if (0xA67C <= value && value <= 0xA67D) { return true }
    if value == 0xA67F { return true }
    if value == 0xA681 { return true }
    if value == 0xA683 { return true }
    if value == 0xA685 { return true }
    if value == 0xA687 { return true }
    if value == 0xA689 { return true }
    if value == 0xA68B { return true }
    if value == 0xA68D { return true }
    if value == 0xA68F { return true }
    if value == 0xA691 { return true }
    if value == 0xA693 { return true }
    if value == 0xA695 { return true }
    if value == 0xA697 { return true }
    if value == 0xA699 { return true }
    if value == 0xA69B { return true }
    if value == 0xA69E { return true }
    if value == 0xA69F { return true }
    if (0xA6A0 <= value && value <= 0xA6E5) { return true }
    if (0xA6F0 <= value && value <= 0xA6F1) { return true }
    if (0xA717 <= value && value <= 0xA71A) { return true }
    if (0xA71B <= value && value <= 0xA71F) { return true }
    if value == 0xA723 { return true }
    if value == 0xA725 { return true }
    if value == 0xA727 { return true }
    if value == 0xA729 { return true }
    if value == 0xA72B { return true }
    if value == 0xA72D { return true }
    if (0xA72F <= value && value <= 0xA731) { return true }
    if value == 0xA733 { return true }
    if value == 0xA735 { return true }
    if value == 0xA737 { return true }
    if value == 0xA739 { return true }
    if value == 0xA73B { return true }
    if value == 0xA73D { return true }
    if value == 0xA73F { return true }
    if value == 0xA741 { return true }
    if value == 0xA743 { return true }
    if value == 0xA745 { return true }
    if value == 0xA747 { return true }
    if value == 0xA749 { return true }
    if value == 0xA74B { return true }
    if value == 0xA74D { return true }
    if value == 0xA74F { return true }
    if value == 0xA751 { return true }
    if value == 0xA753 { return true }
    if value == 0xA755 { return true }
    if value == 0xA757 { return true }
    if value == 0xA759 { return true }
    if value == 0xA75B { return true }
    if value == 0xA75D { return true }
    if value == 0xA75F { return true }
    if value == 0xA761 { return true }
    if value == 0xA763 { return true }
    if value == 0xA765 { return true }
    if value == 0xA767 { return true }
    if value == 0xA769 { return true }
    if value == 0xA76B { return true }
    if value == 0xA76D { return true }
    if value == 0xA76F { return true }
    if (0xA771 <= value && value <= 0xA778) { return true }
    if value == 0xA77A { return true }
    if value == 0xA77C { return true }
    if value == 0xA77F { return true }
    if value == 0xA781 { return true }
    if value == 0xA783 { return true }
    if value == 0xA785 { return true }
    if (0xA787 <= value && value <= 0xA788) { return true }
    if value == 0xA78C { return true }
    if value == 0xA78E { return true }
    if value == 0xA78F { return true }
    if value == 0xA791 { return true }
    if value == 0xA793 { return true }
    if (0xA794 <= value && value <= 0xA795) { return true }
    if value == 0xA797 { return true }
    if value == 0xA799 { return true }
    if value == 0xA79B { return true }
    if value == 0xA79D { return true }
    if value == 0xA79F { return true }
    if value == 0xA7A1 { return true }
    if value == 0xA7A3 { return true }
    if value == 0xA7A5 { return true }
    if value == 0xA7A7 { return true }
    if value == 0xA7A9 { return true }
    if value == 0xA7B5 { return true }
    if value == 0xA7B7 { return true }
    if value == 0xA7F7 { return true }
    if value == 0xA7FA { return true }
    if (0xA7FB <= value && value <= 0xA7FF) { return true }
    if (0xA800 <= value && value <= 0xA827) { return true }
    if (0xA840 <= value && value <= 0xA873) { return true }
    if (0xA880 <= value && value <= 0xA8C4) { return true }
    if value == 0xA8C5 { return true }
    if (0xA8D0 <= value && value <= 0xA8D9) { return true }
    if (0xA8E0 <= value && value <= 0xA8F7) { return true }
    if value == 0xA8FB { return true }
    if value == 0xA8FD { return true }
    if (0xA900 <= value && value <= 0xA92D) { return true }
    if (0xA930 <= value && value <= 0xA953) { return true }
    if (0xA980 <= value && value <= 0xA9C0) { return true }
    if (0xA9CF <= value && value <= 0xA9D9) { return true }
    if (0xA9E0 <= value && value <= 0xA9FE) { return true }
    if (0xAA00 <= value && value <= 0xAA36) { return true }
    if (0xAA40 <= value && value <= 0xAA4D) { return true }
    if (0xAA50 <= value && value <= 0xAA59) { return true }
    if (0xAA60 <= value && value <= 0xAA76) { return true }
    if (0xAA7A <= value && value <= 0xAA7B) { return true }
    if (0xAA7C <= value && value <= 0xAA7F) { return true }
    if (0xAA80 <= value && value <= 0xAAC2) { return true }
    if (0xAADB <= value && value <= 0xAADD) { return true }
    if (0xAAE0 <= value && value <= 0xAAEF) { return true }
    if (0xAAF2 <= value && value <= 0xAAF6) { return true }
    if (0xAB01 <= value && value <= 0xAB06) { return true }
    if (0xAB09 <= value && value <= 0xAB0E) { return true }
    if (0xAB11 <= value && value <= 0xAB16) { return true }
    if (0xAB20 <= value && value <= 0xAB26) { return true }
    if (0xAB28 <= value && value <= 0xAB2E) { return true }
    if (0xAB30 <= value && value <= 0xAB5A) { return true }
    if (0xAB60 <= value && value <= 0xAB63) { return true }
    if (0xAB64 <= value && value <= 0xAB65) { return true }
    if (0xABC0 <= value && value <= 0xABEA) { return true }
    if (0xABEC <= value && value <= 0xABED) { return true }
    if (0xABF0 <= value && value <= 0xABF9) { return true }
    if (0xAC00 <= value && value <= 0xD7A3) { return true }
    if (0xFA0E <= value && value <= 0xFA0F) { return true }
    if value == 0xFA11 { return true }
    if (0xFA13 <= value && value <= 0xFA14) { return true }
    if value == 0xFA1F { return true }
    if value == 0xFA21 { return true }
    if (0xFA23 <= value && value <= 0xFA24) { return true }
    if (0xFA27 <= value && value <= 0xFA29) { return true }
    if value == 0xFB1E { return true }
    if (0xFE20 <= value && value <= 0xFE23) { return true }
    if (0xFE24 <= value && value <= 0xFE26) { return true }
    if (0xFE27 <= value && value <= 0xFE2D) { return true }
    if (0xFE2E <= value && value <= 0xFE2F) { return true }
    if value == 0xFE73 { return true }
    if (0x10000 <= value && value <= 0x1000B) { return true }
    if (0x1000D <= value && value <= 0x10026) { return true }
    if (0x10028 <= value && value <= 0x1003A) { return true }
    if (0x1003C <= value && value <= 0x1003D) { return true }
    if (0x1003F <= value && value <= 0x1004D) { return true }
    if (0x10050 <= value && value <= 0x1005D) { return true }
    if (0x10080 <= value && value <= 0x100FA) { return true }
    if value == 0x101FD { return true }
    if (0x10280 <= value && value <= 0x1029C) { return true }
    if (0x102A0 <= value && value <= 0x102D0) { return true }
    if value == 0x102E0 { return true }
    if (0x10300 <= value && value <= 0x1031E) { return true }
    if value == 0x1031F { return true }
    if (0x1032D <= value && value <= 0x1032F) { return true }
    if (0x10330 <= value && value <= 0x10340) { return true }
    if (0x10342 <= value && value <= 0x10349) { return true }
    if (0x10350 <= value && value <= 0x1037A) { return true }
    if (0x10380 <= value && value <= 0x1039D) { return true }
    if (0x103A0 <= value && value <= 0x103C3) { return true }
    if (0x103C8 <= value && value <= 0x103CF) { return true }
    if (0x10428 <= value && value <= 0x1044D) { return true }
    if (0x1044E <= value && value <= 0x1049D) { return true }
    if (0x104A0 <= value && value <= 0x104A9) { return true }
    if (0x104D8 <= value && value <= 0x104FB) { return true }
    if (0x10500 <= value && value <= 0x10527) { return true }
    if (0x10530 <= value && value <= 0x10563) { return true }
    if (0x10600 <= value && value <= 0x10736) { return true }
    if (0x10740 <= value && value <= 0x10755) { return true }
    if (0x10760 <= value && value <= 0x10767) { return true }
    if (0x10800 <= value && value <= 0x10805) { return true }
    if value == 0x10808 { return true }
    if (0x1080A <= value && value <= 0x10835) { return true }
    if (0x10837 <= value && value <= 0x10838) { return true }
    if value == 0x1083C { return true }
    if value == 0x1083F { return true }
    if (0x10840 <= value && value <= 0x10855) { return true }
    if (0x10860 <= value && value <= 0x10876) { return true }
    if (0x10880 <= value && value <= 0x1089E) { return true }
    if (0x108E0 <= value && value <= 0x108F2) { return true }
    if (0x108F4 <= value && value <= 0x108F5) { return true }
    if (0x10900 <= value && value <= 0x10915) { return true }
    if (0x10920 <= value && value <= 0x10939) { return true }
    if (0x10980 <= value && value <= 0x109B7) { return true }
    if (0x109BE <= value && value <= 0x109BF) { return true }
    if (0x10A00 <= value && value <= 0x10A03) { return true }
    if (0x10A05 <= value && value <= 0x10A06) { return true }
    if (0x10A0C <= value && value <= 0x10A13) { return true }
    if (0x10A15 <= value && value <= 0x10A17) { return true }
    if (0x10A19 <= value && value <= 0x10A33) { return true }
    if (0x10A38 <= value && value <= 0x10A3A) { return true }
    if value == 0x10A3F { return true }
    if (0x10A60 <= value && value <= 0x10A7C) { return true }
    if (0x10A80 <= value && value <= 0x10A9C) { return true }
    if (0x10AC0 <= value && value <= 0x10AC7) { return true }
    if (0x10AC9 <= value && value <= 0x10AE6) { return true }
    if (0x10B00 <= value && value <= 0x10B35) { return true }
    if (0x10B40 <= value && value <= 0x10B55) { return true }
    if (0x10B60 <= value && value <= 0x10B72) { return true }
    if (0x10B80 <= value && value <= 0x10B91) { return true }
    if (0x10C00 <= value && value <= 0x10C48) { return true }
    if (0x10CC0 <= value && value <= 0x10CF2) { return true }
    if (0x11000 <= value && value <= 0x11046) { return true }
    if (0x11066 <= value && value <= 0x1106F) { return true }
    if value == 0x1107F { return true }
    if (0x11080 <= value && value <= 0x110BA) { return true }
    if (0x110D0 <= value && value <= 0x110E8) { return true }
    if (0x110F0 <= value && value <= 0x110F9) { return true }
    if (0x11100 <= value && value <= 0x11134) { return true }
    if (0x11136 <= value && value <= 0x1113F) { return true }
    if (0x11150 <= value && value <= 0x11173) { return true }
    if value == 0x11176 { return true }
    if (0x11180 <= value && value <= 0x111C4) { return true }
    if (0x111CA <= value && value <= 0x111CC) { return true }
    if (0x111D0 <= value && value <= 0x111D9) { return true }
    if value == 0x111DA { return true }
    if value == 0x111DC { return true }
    if (0x11200 <= value && value <= 0x11211) { return true }
    if (0x11213 <= value && value <= 0x11237) { return true }
    if value == 0x1123E { return true }
    if (0x11280 <= value && value <= 0x11286) { return true }
    if value == 0x11288 { return true }
    if (0x1128A <= value && value <= 0x1128D) { return true }
    if (0x1128F <= value && value <= 0x1129D) { return true }
    if (0x1129F <= value && value <= 0x112A8) { return true }
    if (0x112B0 <= value && value <= 0x112EA) { return true }
    if (0x112F0 <= value && value <= 0x112F9) { return true }
    if value == 0x11300 { return true }
    if (0x11301 <= value && value <= 0x11303) { return true }
    if (0x11305 <= value && value <= 0x1130C) { return true }
    if (0x1130F <= value && value <= 0x11310) { return true }
    if (0x11313 <= value && value <= 0x11328) { return true }
    if (0x1132A <= value && value <= 0x11330) { return true }
    if (0x11332 <= value && value <= 0x11333) { return true }
    if (0x11335 <= value && value <= 0x11339) { return true }
    if (0x1133C <= value && value <= 0x11344) { return true }
    if (0x11347 <= value && value <= 0x11348) { return true }
    if (0x1134B <= value && value <= 0x1134D) { return true }
    if value == 0x11350 { return true }
    if value == 0x11357 { return true }
    if (0x1135D <= value && value <= 0x11363) { return true }
    if (0x11366 <= value && value <= 0x1136C) { return true }
    if (0x11370 <= value && value <= 0x11374) { return true }
    if (0x11400 <= value && value <= 0x1144A) { return true }
    if (0x11450 <= value && value <= 0x11459) { return true }
    if (0x11480 <= value && value <= 0x114C5) { return true }
    if value == 0x114C7 { return true }
    if (0x114D0 <= value && value <= 0x114D9) { return true }
    if (0x11580 <= value && value <= 0x115B5) { return true }
    if (0x115B8 <= value && value <= 0x115C0) { return true }
    if (0x115D8 <= value && value <= 0x115DD) { return true }
    if (0x11600 <= value && value <= 0x11640) { return true }
    if value == 0x11644 { return true }
    if (0x11650 <= value && value <= 0x11659) { return true }
    if (0x11680 <= value && value <= 0x116B7) { return true }
    if (0x116C0 <= value && value <= 0x116C9) { return true }
    if (0x11700 <= value && value <= 0x11719) { return true }
    if (0x1171D <= value && value <= 0x1172B) { return true }
    if (0x11730 <= value && value <= 0x11739) { return true }
    if (0x118C0 <= value && value <= 0x118E9) { return true }
    if value == 0x118FF { return true }
    if (0x11A00 <= value && value <= 0x11A3E) { return true }
    if value == 0x11A47 { return true }
    if (0x11A50 <= value && value <= 0x11A83) { return true }
    if (0x11A86 <= value && value <= 0x11A99) { return true }
    if (0x11AC0 <= value && value <= 0x11AF8) { return true }
    if (0x11C00 <= value && value <= 0x11C08) { return true }
    if (0x11C0A <= value && value <= 0x11C36) { return true }
    if (0x11C38 <= value && value <= 0x11C40) { return true }
    if (0x11C50 <= value && value <= 0x11C59) { return true }
    if (0x11C72 <= value && value <= 0x11C8F) { return true }
    if (0x11C92 <= value && value <= 0x11CA7) { return true }
    if (0x11CA9 <= value && value <= 0x11CB6) { return true }
    if (0x11D00 <= value && value <= 0x11D06) { return true }
    if (0x11D08 <= value && value <= 0x11D09) { return true }
    if (0x11D0B <= value && value <= 0x11D36) { return true }
    if value == 0x11D3A { return true }
    if (0x11D3C <= value && value <= 0x11D3D) { return true }
    if (0x11D3F <= value && value <= 0x11D47) { return true }
    if (0x11D50 <= value && value <= 0x11D59) { return true }
    if (0x12000 <= value && value <= 0x1236E) { return true }
    if (0x1236F <= value && value <= 0x12398) { return true }
    if value == 0x12399 { return true }
    if (0x12480 <= value && value <= 0x12543) { return true }
    if (0x13000 <= value && value <= 0x1342E) { return true }
    if (0x14400 <= value && value <= 0x14646) { return true }
    if (0x16800 <= value && value <= 0x16A38) { return true }
    if (0x16A40 <= value && value <= 0x16A5E) { return true }
    if (0x16A60 <= value && value <= 0x16A69) { return true }
    if (0x16AD0 <= value && value <= 0x16AED) { return true }
    if (0x16AF0 <= value && value <= 0x16AF4) { return true }
    if (0x16B00 <= value && value <= 0x16B36) { return true }
    if (0x16B40 <= value && value <= 0x16B43) { return true }
    if (0x16B50 <= value && value <= 0x16B59) { return true }
    if (0x16B63 <= value && value <= 0x16B77) { return true }
    if (0x16B7D <= value && value <= 0x16B8F) { return true }
    if (0x16F00 <= value && value <= 0x16F44) { return true }
    if (0x16F50 <= value && value <= 0x16F7E) { return true }
    if (0x16F8F <= value && value <= 0x16F9F) { return true }
    if value == 0x16FE0 { return true }
    if value == 0x16FE1 { return true }
    if (0x17000 <= value && value <= 0x187EC) { return true }
    if (0x18800 <= value && value <= 0x18AF2) { return true }
    if (0x1B000 <= value && value <= 0x1B001) { return true }
    if (0x1B002 <= value && value <= 0x1B11E) { return true }
    if (0x1B170 <= value && value <= 0x1B2FB) { return true }
    if (0x1BC00 <= value && value <= 0x1BC6A) { return true }
    if (0x1BC70 <= value && value <= 0x1BC7C) { return true }
    if (0x1BC80 <= value && value <= 0x1BC88) { return true }
    if (0x1BC90 <= value && value <= 0x1BC99) { return true }
    if (0x1BC9D <= value && value <= 0x1BC9E) { return true }
    if (0x1DA00 <= value && value <= 0x1DA36) { return true }
    if (0x1DA3B <= value && value <= 0x1DA6C) { return true }
    if value == 0x1DA75 { return true }
    if value == 0x1DA84 { return true }
    if (0x1DA9B <= value && value <= 0x1DA9F) { return true }
    if (0x1DAA1 <= value && value <= 0x1DAAF) { return true }
    if (0x1E000 <= value && value <= 0x1E006) { return true }
    if (0x1E008 <= value && value <= 0x1E018) { return true }
    if (0x1E01B <= value && value <= 0x1E021) { return true }
    if (0x1E023 <= value && value <= 0x1E024) { return true }
    if (0x1E026 <= value && value <= 0x1E02A) { return true }
    if (0x1E800 <= value && value <= 0x1E8C4) { return true }
    if (0x1E8D0 <= value && value <= 0x1E8D6) { return true }
    if (0x1E922 <= value && value <= 0x1E94A) { return true }
    if (0x1E950 <= value && value <= 0x1E959) { return true }
    if (0x20000 <= value && value <= 0x2A6D6) { return true }
    if (0x2A700 <= value && value <= 0x2B734) { return true }
    if (0x2B740 <= value && value <= 0x2B81D) { return true }
    if (0x2B820 <= value && value <= 0x2CEA1) { return true }
    if (0x2CEB0 <= value && value <= 0x2EBE0) { return true }
    return false
  }
  fileprivate var isIgnored: Bool {
    let value: UInt32 = self.value
    if value == 0x00AD { return true }
    if value == 0x034F { return true }
    if (0x180B <= value && value <= 0x180D) { return true }
    if value == 0x200B { return true }
    if value == 0x2060 { return true }
    if value == 0x2064 { return true }
    if (0xFE00 <= value && value <= 0xFE0F) { return true }
    if value == 0xFEFF { return true }
    if (0x1BCA0 <= value && value <= 0x1BCA3) { return true }
    if (0xE0100 <= value && value <= 0xE01EF) { return true }
    return false
  }
  fileprivate var isDisallowed: Bool {
    let value: UInt32 = self.value
    if (0x0080 <= value && value <= 0x009F) { return true }
    if (0x0378 <= value && value <= 0x0379) { return true }
    if (0x0380 <= value && value <= 0x0383) { return true }
    if value == 0x038B { return true }
    if value == 0x038D { return true }
    if value == 0x03A2 { return true }
    if value == 0x04C0 { return true }
    if value == 0x0530 { return true }
    if (0x0557 <= value && value <= 0x0558) { return true }
    if value == 0x0560 { return true }
    if value == 0x0588 { return true }
    if (0x058B <= value && value <= 0x058C) { return true }
    if value == 0x0590 { return true }
    if (0x05C8 <= value && value <= 0x05CF) { return true }
    if (0x05EB <= value && value <= 0x05EF) { return true }
    if (0x05F5 <= value && value <= 0x05FF) { return true }
    if (0x0600 <= value && value <= 0x0603) { return true }
    if value == 0x0604 { return true }
    if value == 0x0605 { return true }
    if value == 0x061C { return true }
    if value == 0x061D { return true }
    if value == 0x06DD { return true }
    if value == 0x070E { return true }
    if value == 0x070F { return true }
    if (0x074B <= value && value <= 0x074C) { return true }
    if (0x07B2 <= value && value <= 0x07BF) { return true }
    if (0x07FB <= value && value <= 0x07FF) { return true }
    if (0x082E <= value && value <= 0x082F) { return true }
    if value == 0x083F { return true }
    if (0x085C <= value && value <= 0x085D) { return true }
    if value == 0x085F { return true }
    if (0x086B <= value && value <= 0x089F) { return true }
    if value == 0x08B5 { return true }
    if (0x08BE <= value && value <= 0x08D3) { return true }
    if value == 0x08E2 { return true }
    if value == 0x0984 { return true }
    if (0x098D <= value && value <= 0x098E) { return true }
    if (0x0991 <= value && value <= 0x0992) { return true }
    if value == 0x09A9 { return true }
    if value == 0x09B1 { return true }
    if (0x09B3 <= value && value <= 0x09B5) { return true }
    if (0x09BA <= value && value <= 0x09BB) { return true }
    if (0x09C5 <= value && value <= 0x09C6) { return true }
    if (0x09C9 <= value && value <= 0x09CA) { return true }
    if (0x09CF <= value && value <= 0x09D6) { return true }
    if (0x09D8 <= value && value <= 0x09DB) { return true }
    if value == 0x09DE { return true }
    if (0x09E4 <= value && value <= 0x09E5) { return true }
    if (0x09FE <= value && value <= 0x0A00) { return true }
    if value == 0x0A04 { return true }
    if (0x0A0B <= value && value <= 0x0A0E) { return true }
    if (0x0A11 <= value && value <= 0x0A12) { return true }
    if value == 0x0A29 { return true }
    if value == 0x0A31 { return true }
    if value == 0x0A34 { return true }
    if value == 0x0A37 { return true }
    if (0x0A3A <= value && value <= 0x0A3B) { return true }
    if value == 0x0A3D { return true }
    if (0x0A43 <= value && value <= 0x0A46) { return true }
    if (0x0A49 <= value && value <= 0x0A4A) { return true }
    if (0x0A4E <= value && value <= 0x0A50) { return true }
    if (0x0A52 <= value && value <= 0x0A58) { return true }
    if value == 0x0A5D { return true }
    if (0x0A5F <= value && value <= 0x0A65) { return true }
    if (0x0A76 <= value && value <= 0x0A80) { return true }
    if value == 0x0A84 { return true }
    if value == 0x0A8E { return true }
    if value == 0x0A92 { return true }
    if value == 0x0AA9 { return true }
    if value == 0x0AB1 { return true }
    if value == 0x0AB4 { return true }
    if (0x0ABA <= value && value <= 0x0ABB) { return true }
    if value == 0x0AC6 { return true }
    if value == 0x0ACA { return true }
    if (0x0ACE <= value && value <= 0x0ACF) { return true }
    if (0x0AD1 <= value && value <= 0x0ADF) { return true }
    if (0x0AE4 <= value && value <= 0x0AE5) { return true }
    if (0x0AF2 <= value && value <= 0x0AF8) { return true }
    if value == 0x0B00 { return true }
    if value == 0x0B04 { return true }
    if (0x0B0D <= value && value <= 0x0B0E) { return true }
    if (0x0B11 <= value && value <= 0x0B12) { return true }
    if value == 0x0B29 { return true }
    if value == 0x0B31 { return true }
    if value == 0x0B34 { return true }
    if (0x0B3A <= value && value <= 0x0B3B) { return true }
    if (0x0B45 <= value && value <= 0x0B46) { return true }
    if (0x0B49 <= value && value <= 0x0B4A) { return true }
    if (0x0B4E <= value && value <= 0x0B55) { return true }
    if (0x0B58 <= value && value <= 0x0B5B) { return true }
    if value == 0x0B5E { return true }
    if (0x0B64 <= value && value <= 0x0B65) { return true }
    if (0x0B78 <= value && value <= 0x0B81) { return true }
    if value == 0x0B84 { return true }
    if (0x0B8B <= value && value <= 0x0B8D) { return true }
    if value == 0x0B91 { return true }
    if (0x0B96 <= value && value <= 0x0B98) { return true }
    if value == 0x0B9B { return true }
    if value == 0x0B9D { return true }
    if (0x0BA0 <= value && value <= 0x0BA2) { return true }
    if (0x0BA5 <= value && value <= 0x0BA7) { return true }
    if (0x0BAB <= value && value <= 0x0BAD) { return true }
    if (0x0BBA <= value && value <= 0x0BBD) { return true }
    if (0x0BC3 <= value && value <= 0x0BC5) { return true }
    if value == 0x0BC9 { return true }
    if (0x0BCE <= value && value <= 0x0BCF) { return true }
    if (0x0BD1 <= value && value <= 0x0BD6) { return true }
    if (0x0BD8 <= value && value <= 0x0BE5) { return true }
    if (0x0BFB <= value && value <= 0x0BFF) { return true }
    if value == 0x0C04 { return true }
    if value == 0x0C0D { return true }
    if value == 0x0C11 { return true }
    if value == 0x0C29 { return true }
    if (0x0C3A <= value && value <= 0x0C3C) { return true }
    if value == 0x0C45 { return true }
    if value == 0x0C49 { return true }
    if (0x0C4E <= value && value <= 0x0C54) { return true }
    if value == 0x0C57 { return true }
    if (0x0C5B <= value && value <= 0x0C5F) { return true }
    if (0x0C64 <= value && value <= 0x0C65) { return true }
    if (0x0C70 <= value && value <= 0x0C77) { return true }
    if value == 0x0C84 { return true }
    if value == 0x0C8D { return true }
    if value == 0x0C91 { return true }
    if value == 0x0CA9 { return true }
    if value == 0x0CB4 { return true }
    if (0x0CBA <= value && value <= 0x0CBB) { return true }
    if value == 0x0CC5 { return true }
    if value == 0x0CC9 { return true }
    if (0x0CCE <= value && value <= 0x0CD4) { return true }
    if (0x0CD7 <= value && value <= 0x0CDD) { return true }
    if value == 0x0CDF { return true }
    if (0x0CE4 <= value && value <= 0x0CE5) { return true }
    if value == 0x0CF0 { return true }
    if (0x0CF3 <= value && value <= 0x0CFF) { return true }
    if value == 0x0D04 { return true }
    if value == 0x0D0D { return true }
    if value == 0x0D11 { return true }
    if value == 0x0D45 { return true }
    if value == 0x0D49 { return true }
    if (0x0D50 <= value && value <= 0x0D53) { return true }
    if (0x0D64 <= value && value <= 0x0D65) { return true }
    if (0x0D80 <= value && value <= 0x0D81) { return true }
    if value == 0x0D84 { return true }
    if (0x0D97 <= value && value <= 0x0D99) { return true }
    if value == 0x0DB2 { return true }
    if value == 0x0DBC { return true }
    if (0x0DBE <= value && value <= 0x0DBF) { return true }
    if (0x0DC7 <= value && value <= 0x0DC9) { return true }
    if (0x0DCB <= value && value <= 0x0DCE) { return true }
    if value == 0x0DD5 { return true }
    if value == 0x0DD7 { return true }
    if (0x0DE0 <= value && value <= 0x0DE5) { return true }
    if (0x0DF0 <= value && value <= 0x0DF1) { return true }
    if (0x0DF5 <= value && value <= 0x0E00) { return true }
    if (0x0E3B <= value && value <= 0x0E3E) { return true }
    if (0x0E5C <= value && value <= 0x0E80) { return true }
    if value == 0x0E83 { return true }
    if (0x0E85 <= value && value <= 0x0E86) { return true }
    if value == 0x0E89 { return true }
    if (0x0E8B <= value && value <= 0x0E8C) { return true }
    if (0x0E8E <= value && value <= 0x0E93) { return true }
    if value == 0x0E98 { return true }
    if value == 0x0EA0 { return true }
    if value == 0x0EA4 { return true }
    if value == 0x0EA6 { return true }
    if (0x0EA8 <= value && value <= 0x0EA9) { return true }
    if value == 0x0EAC { return true }
    if value == 0x0EBA { return true }
    if (0x0EBE <= value && value <= 0x0EBF) { return true }
    if value == 0x0EC5 { return true }
    if value == 0x0EC7 { return true }
    if (0x0ECE <= value && value <= 0x0ECF) { return true }
    if (0x0EDA <= value && value <= 0x0EDB) { return true }
    if (0x0EE0 <= value && value <= 0x0EFF) { return true }
    if value == 0x0F48 { return true }
    if (0x0F6D <= value && value <= 0x0F70) { return true }
    if value == 0x0F98 { return true }
    if value == 0x0FBD { return true }
    if value == 0x0FCD { return true }
    if (0x0FDB <= value && value <= 0x0FFF) { return true }
    if (0x10A0 <= value && value <= 0x10C5) { return true }
    if value == 0x10C6 { return true }
    if (0x10C8 <= value && value <= 0x10CC) { return true }
    if (0x10CE <= value && value <= 0x10CF) { return true }
    if (0x115F <= value && value <= 0x1160) { return true }
    if value == 0x1249 { return true }
    if (0x124E <= value && value <= 0x124F) { return true }
    if value == 0x1257 { return true }
    if value == 0x1259 { return true }
    if (0x125E <= value && value <= 0x125F) { return true }
    if value == 0x1289 { return true }
    if (0x128E <= value && value <= 0x128F) { return true }
    if value == 0x12B1 { return true }
    if (0x12B6 <= value && value <= 0x12B7) { return true }
    if value == 0x12BF { return true }
    if value == 0x12C1 { return true }
    if (0x12C6 <= value && value <= 0x12C7) { return true }
    if value == 0x12D7 { return true }
    if value == 0x1311 { return true }
    if (0x1316 <= value && value <= 0x1317) { return true }
    if (0x135B <= value && value <= 0x135C) { return true }
    if (0x137D <= value && value <= 0x137F) { return true }
    if (0x139A <= value && value <= 0x139F) { return true }
    if (0x13F6 <= value && value <= 0x13F7) { return true }
    if (0x13FE <= value && value <= 0x13FF) { return true }
    if value == 0x1680 { return true }
    if (0x169D <= value && value <= 0x169F) { return true }
    if (0x16F9 <= value && value <= 0x16FF) { return true }
    if value == 0x170D { return true }
    if (0x1715 <= value && value <= 0x171F) { return true }
    if (0x1737 <= value && value <= 0x173F) { return true }
    if (0x1754 <= value && value <= 0x175F) { return true }
    if value == 0x176D { return true }
    if value == 0x1771 { return true }
    if (0x1774 <= value && value <= 0x177F) { return true }
    if (0x17B4 <= value && value <= 0x17B5) { return true }
    if (0x17DE <= value && value <= 0x17DF) { return true }
    if (0x17EA <= value && value <= 0x17EF) { return true }
    if (0x17FA <= value && value <= 0x17FF) { return true }
    if value == 0x1806 { return true }
    if value == 0x180E { return true }
    if value == 0x180F { return true }
    if (0x181A <= value && value <= 0x181F) { return true }
    if (0x1878 <= value && value <= 0x187F) { return true }
    if (0x18AB <= value && value <= 0x18AF) { return true }
    if (0x18F6 <= value && value <= 0x18FF) { return true }
    if value == 0x191F { return true }
    if (0x192C <= value && value <= 0x192F) { return true }
    if (0x193C <= value && value <= 0x193F) { return true }
    if (0x1941 <= value && value <= 0x1943) { return true }
    if (0x196E <= value && value <= 0x196F) { return true }
    if (0x1975 <= value && value <= 0x197F) { return true }
    if (0x19AC <= value && value <= 0x19AF) { return true }
    if (0x19CA <= value && value <= 0x19CF) { return true }
    if (0x19DB <= value && value <= 0x19DD) { return true }
    if (0x1A1C <= value && value <= 0x1A1D) { return true }
    if value == 0x1A5F { return true }
    if (0x1A7D <= value && value <= 0x1A7E) { return true }
    if (0x1A8A <= value && value <= 0x1A8F) { return true }
    if (0x1A9A <= value && value <= 0x1A9F) { return true }
    if (0x1AAE <= value && value <= 0x1AAF) { return true }
    if (0x1ABF <= value && value <= 0x1AFF) { return true }
    if (0x1B4C <= value && value <= 0x1B4F) { return true }
    if (0x1B7D <= value && value <= 0x1B7F) { return true }
    if (0x1BF4 <= value && value <= 0x1BFB) { return true }
    if (0x1C38 <= value && value <= 0x1C3A) { return true }
    if (0x1C4A <= value && value <= 0x1C4C) { return true }
    if (0x1C89 <= value && value <= 0x1CBF) { return true }
    if (0x1CC8 <= value && value <= 0x1CCF) { return true }
    if (0x1CFA <= value && value <= 0x1CFF) { return true }
    if value == 0x1DFA { return true }
    if (0x1F16 <= value && value <= 0x1F17) { return true }
    if (0x1F1E <= value && value <= 0x1F1F) { return true }
    if (0x1F46 <= value && value <= 0x1F47) { return true }
    if (0x1F4E <= value && value <= 0x1F4F) { return true }
    if value == 0x1F58 { return true }
    if value == 0x1F5A { return true }
    if value == 0x1F5C { return true }
    if value == 0x1F5E { return true }
    if (0x1F7E <= value && value <= 0x1F7F) { return true }
    if value == 0x1FB5 { return true }
    if value == 0x1FC5 { return true }
    if (0x1FD4 <= value && value <= 0x1FD5) { return true }
    if value == 0x1FDC { return true }
    if (0x1FF0 <= value && value <= 0x1FF1) { return true }
    if value == 0x1FF5 { return true }
    if value == 0x1FFF { return true }
    if (0x200E <= value && value <= 0x200F) { return true }
    if (0x2024 <= value && value <= 0x2026) { return true }
    if (0x2028 <= value && value <= 0x202E) { return true }
    if (0x2061 <= value && value <= 0x2063) { return true }
    if value == 0x2065 { return true }
    if (0x2066 <= value && value <= 0x2069) { return true }
    if (0x206A <= value && value <= 0x206F) { return true }
    if (0x2072 <= value && value <= 0x2073) { return true }
    if value == 0x208F { return true }
    if (0x209D <= value && value <= 0x209F) { return true }
    if (0x20C0 <= value && value <= 0x20CF) { return true }
    if (0x20F1 <= value && value <= 0x20FF) { return true }
    if value == 0x2132 { return true }
    if value == 0x2183 { return true }
    if (0x218C <= value && value <= 0x218F) { return true }
    if (0x2427 <= value && value <= 0x243F) { return true }
    if (0x244B <= value && value <= 0x245F) { return true }
    if (0x2488 <= value && value <= 0x249B) { return true }
    if (0x2B74 <= value && value <= 0x2B75) { return true }
    if (0x2B96 <= value && value <= 0x2B97) { return true }
    if (0x2BBA <= value && value <= 0x2BBC) { return true }
    if value == 0x2BC9 { return true }
    if (0x2BD3 <= value && value <= 0x2BEB) { return true }
    if (0x2BF0 <= value && value <= 0x2BFF) { return true }
    if value == 0x2C2F { return true }
    if value == 0x2C5F { return true }
    if (0x2CF4 <= value && value <= 0x2CF8) { return true }
    if value == 0x2D26 { return true }
    if (0x2D28 <= value && value <= 0x2D2C) { return true }
    if (0x2D2E <= value && value <= 0x2D2F) { return true }
    if (0x2D68 <= value && value <= 0x2D6E) { return true }
    if (0x2D71 <= value && value <= 0x2D7E) { return true }
    if (0x2D97 <= value && value <= 0x2D9F) { return true }
    if value == 0x2DA7 { return true }
    if value == 0x2DAF { return true }
    if value == 0x2DB7 { return true }
    if value == 0x2DBF { return true }
    if value == 0x2DC7 { return true }
    if value == 0x2DCF { return true }
    if value == 0x2DD7 { return true }
    if value == 0x2DDF { return true }
    if (0x2E4A <= value && value <= 0x2E7F) { return true }
    if value == 0x2E9A { return true }
    if (0x2EF4 <= value && value <= 0x2EFF) { return true }
    if (0x2FD6 <= value && value <= 0x2FEF) { return true }
    if (0x2FF0 <= value && value <= 0x2FFB) { return true }
    if (0x2FFC <= value && value <= 0x2FFF) { return true }
    if value == 0x3040 { return true }
    if (0x3097 <= value && value <= 0x3098) { return true }
    if (0x3100 <= value && value <= 0x3104) { return true }
    if (0x312F <= value && value <= 0x3130) { return true }
    if value == 0x3164 { return true }
    if value == 0x318F { return true }
    if (0x31BB <= value && value <= 0x31BF) { return true }
    if (0x31E4 <= value && value <= 0x31EF) { return true }
    if value == 0x321F { return true }
    if value == 0x32FF { return true }
    if value == 0x33C2 { return true }
    if value == 0x33C7 { return true }
    if value == 0x33D8 { return true }
    if (0x4DB6 <= value && value <= 0x4DBF) { return true }
    if (0x9FEB <= value && value <= 0x9FFF) { return true }
    if (0xA48D <= value && value <= 0xA48F) { return true }
    if (0xA4C7 <= value && value <= 0xA4CF) { return true }
    if (0xA62C <= value && value <= 0xA63F) { return true }
    if (0xA6F8 <= value && value <= 0xA6FF) { return true }
    if value == 0xA7AF { return true }
    if (0xA7B8 <= value && value <= 0xA7F6) { return true }
    if (0xA82C <= value && value <= 0xA82F) { return true }
    if (0xA83A <= value && value <= 0xA83F) { return true }
    if (0xA878 <= value && value <= 0xA87F) { return true }
    if (0xA8C6 <= value && value <= 0xA8CD) { return true }
    if (0xA8DA <= value && value <= 0xA8DF) { return true }
    if (0xA8FE <= value && value <= 0xA8FF) { return true }
    if (0xA954 <= value && value <= 0xA95E) { return true }
    if (0xA97D <= value && value <= 0xA97F) { return true }
    if value == 0xA9CE { return true }
    if (0xA9DA <= value && value <= 0xA9DD) { return true }
    if value == 0xA9FF { return true }
    if (0xAA37 <= value && value <= 0xAA3F) { return true }
    if (0xAA4E <= value && value <= 0xAA4F) { return true }
    if (0xAA5A <= value && value <= 0xAA5B) { return true }
    if (0xAAC3 <= value && value <= 0xAADA) { return true }
    if (0xAAF7 <= value && value <= 0xAB00) { return true }
    if (0xAB07 <= value && value <= 0xAB08) { return true }
    if (0xAB0F <= value && value <= 0xAB10) { return true }
    if (0xAB17 <= value && value <= 0xAB1F) { return true }
    if value == 0xAB27 { return true }
    if value == 0xAB2F { return true }
    if (0xAB66 <= value && value <= 0xAB6F) { return true }
    if (0xABEE <= value && value <= 0xABEF) { return true }
    if (0xABFA <= value && value <= 0xABFF) { return true }
    if (0xD7A4 <= value && value <= 0xD7AF) { return true }
    if (0xD7C7 <= value && value <= 0xD7CA) { return true }
    if (0xD7FC <= value && value <= 0xD7FF) { return true }
    if (0xD800 <= value && value <= 0xDFFF) { return true }
    if (0xE000 <= value && value <= 0xF8FF) { return true }
    if (0xFA6E <= value && value <= 0xFA6F) { return true }
    if (0xFADA <= value && value <= 0xFAFF) { return true }
    if (0xFB07 <= value && value <= 0xFB12) { return true }
    if (0xFB18 <= value && value <= 0xFB1C) { return true }
    if value == 0xFB37 { return true }
    if value == 0xFB3D { return true }
    if value == 0xFB3F { return true }
    if value == 0xFB42 { return true }
    if value == 0xFB45 { return true }
    if (0xFBC2 <= value && value <= 0xFBD2) { return true }
    if (0xFD40 <= value && value <= 0xFD4F) { return true }
    if (0xFD90 <= value && value <= 0xFD91) { return true }
    if (0xFDC8 <= value && value <= 0xFDCF) { return true }
    if (0xFDD0 <= value && value <= 0xFDEF) { return true }
    if (0xFDFE <= value && value <= 0xFDFF) { return true }
    if value == 0xFE12 { return true }
    if value == 0xFE19 { return true }
    if (0xFE1A <= value && value <= 0xFE1F) { return true }
    if value == 0xFE30 { return true }
    if value == 0xFE52 { return true }
    if value == 0xFE53 { return true }
    if value == 0xFE67 { return true }
    if (0xFE6C <= value && value <= 0xFE6F) { return true }
    if value == 0xFE75 { return true }
    if (0xFEFD <= value && value <= 0xFEFE) { return true }
    if value == 0xFF00 { return true }
    if value == 0xFFA0 { return true }
    if (0xFFBF <= value && value <= 0xFFC1) { return true }
    if (0xFFC8 <= value && value <= 0xFFC9) { return true }
    if (0xFFD0 <= value && value <= 0xFFD1) { return true }
    if (0xFFD8 <= value && value <= 0xFFD9) { return true }
    if (0xFFDD <= value && value <= 0xFFDF) { return true }
    if value == 0xFFE7 { return true }
    if (0xFFEF <= value && value <= 0xFFF8) { return true }
    if (0xFFF9 <= value && value <= 0xFFFB) { return true }
    if value == 0xFFFC { return true }
    if value == 0xFFFD { return true }
    if (0xFFFE <= value && value <= 0xFFFF) { return true }
    if value == 0x1000C { return true }
    if value == 0x10027 { return true }
    if value == 0x1003B { return true }
    if value == 0x1003E { return true }
    if (0x1004E <= value && value <= 0x1004F) { return true }
    if (0x1005E <= value && value <= 0x1007F) { return true }
    if (0x100FB <= value && value <= 0x100FF) { return true }
    if (0x10103 <= value && value <= 0x10106) { return true }
    if (0x10134 <= value && value <= 0x10136) { return true }
    if value == 0x1018F { return true }
    if (0x1019C <= value && value <= 0x1019F) { return true }
    if (0x101A1 <= value && value <= 0x101CF) { return true }
    if (0x101FE <= value && value <= 0x1027F) { return true }
    if (0x1029D <= value && value <= 0x1029F) { return true }
    if (0x102D1 <= value && value <= 0x102DF) { return true }
    if (0x102FC <= value && value <= 0x102FF) { return true }
    if (0x10324 <= value && value <= 0x1032C) { return true }
    if (0x1034B <= value && value <= 0x1034F) { return true }
    if (0x1037B <= value && value <= 0x1037F) { return true }
    if value == 0x1039E { return true }
    if (0x103C4 <= value && value <= 0x103C7) { return true }
    if (0x103D6 <= value && value <= 0x103FF) { return true }
    if (0x1049E <= value && value <= 0x1049F) { return true }
    if (0x104AA <= value && value <= 0x104AF) { return true }
    if (0x104D4 <= value && value <= 0x104D7) { return true }
    if (0x104FC <= value && value <= 0x104FF) { return true }
    if (0x10528 <= value && value <= 0x1052F) { return true }
    if (0x10564 <= value && value <= 0x1056E) { return true }
    if (0x10570 <= value && value <= 0x105FF) { return true }
    if (0x10737 <= value && value <= 0x1073F) { return true }
    if (0x10756 <= value && value <= 0x1075F) { return true }
    if (0x10768 <= value && value <= 0x107FF) { return true }
    if (0x10806 <= value && value <= 0x10807) { return true }
    if value == 0x10809 { return true }
    if value == 0x10836 { return true }
    if (0x10839 <= value && value <= 0x1083B) { return true }
    if (0x1083D <= value && value <= 0x1083E) { return true }
    if value == 0x10856 { return true }
    if (0x1089F <= value && value <= 0x108A6) { return true }
    if (0x108B0 <= value && value <= 0x108DF) { return true }
    if value == 0x108F3 { return true }
    if (0x108F6 <= value && value <= 0x108FA) { return true }
    if (0x1091C <= value && value <= 0x1091E) { return true }
    if (0x1093A <= value && value <= 0x1093E) { return true }
    if (0x10940 <= value && value <= 0x1097F) { return true }
    if (0x109B8 <= value && value <= 0x109BB) { return true }
    if (0x109D0 <= value && value <= 0x109D1) { return true }
    if value == 0x10A04 { return true }
    if (0x10A07 <= value && value <= 0x10A0B) { return true }
    if value == 0x10A14 { return true }
    if value == 0x10A18 { return true }
    if (0x10A34 <= value && value <= 0x10A37) { return true }
    if (0x10A3B <= value && value <= 0x10A3E) { return true }
    if (0x10A48 <= value && value <= 0x10A4F) { return true }
    if (0x10A59 <= value && value <= 0x10A5F) { return true }
    if (0x10AA0 <= value && value <= 0x10ABF) { return true }
    if (0x10AE7 <= value && value <= 0x10AEA) { return true }
    if (0x10AF7 <= value && value <= 0x10AFF) { return true }
    if (0x10B36 <= value && value <= 0x10B38) { return true }
    if (0x10B56 <= value && value <= 0x10B57) { return true }
    if (0x10B73 <= value && value <= 0x10B77) { return true }
    if (0x10B92 <= value && value <= 0x10B98) { return true }
    if (0x10B9D <= value && value <= 0x10BA8) { return true }
    if (0x10BB0 <= value && value <= 0x10BFF) { return true }
    if (0x10C49 <= value && value <= 0x10C7F) { return true }
    if (0x10CB3 <= value && value <= 0x10CBF) { return true }
    if (0x10CF3 <= value && value <= 0x10CF9) { return true }
    if (0x10D00 <= value && value <= 0x10E5F) { return true }
    if (0x10E7F <= value && value <= 0x10FFF) { return true }
    if (0x1104E <= value && value <= 0x11051) { return true }
    if (0x11070 <= value && value <= 0x1107E) { return true }
    if value == 0x110BD { return true }
    if (0x110C2 <= value && value <= 0x110CF) { return true }
    if (0x110E9 <= value && value <= 0x110EF) { return true }
    if (0x110FA <= value && value <= 0x110FF) { return true }
    if value == 0x11135 { return true }
    if (0x11144 <= value && value <= 0x1114F) { return true }
    if (0x11177 <= value && value <= 0x1117F) { return true }
    if (0x111CE <= value && value <= 0x111CF) { return true }
    if value == 0x111E0 { return true }
    if (0x111F5 <= value && value <= 0x111FF) { return true }
    if value == 0x11212 { return true }
    if (0x1123F <= value && value <= 0x1127F) { return true }
    if value == 0x11287 { return true }
    if value == 0x11289 { return true }
    if value == 0x1128E { return true }
    if value == 0x1129E { return true }
    if (0x112AA <= value && value <= 0x112AF) { return true }
    if (0x112EB <= value && value <= 0x112EF) { return true }
    if (0x112FA <= value && value <= 0x112FF) { return true }
    if value == 0x11304 { return true }
    if (0x1130D <= value && value <= 0x1130E) { return true }
    if (0x11311 <= value && value <= 0x11312) { return true }
    if value == 0x11329 { return true }
    if value == 0x11331 { return true }
    if value == 0x11334 { return true }
    if (0x1133A <= value && value <= 0x1133B) { return true }
    if (0x11345 <= value && value <= 0x11346) { return true }
    if (0x11349 <= value && value <= 0x1134A) { return true }
    if (0x1134E <= value && value <= 0x1134F) { return true }
    if (0x11351 <= value && value <= 0x11356) { return true }
    if (0x11358 <= value && value <= 0x1135C) { return true }
    if (0x11364 <= value && value <= 0x11365) { return true }
    if (0x1136D <= value && value <= 0x1136F) { return true }
    if (0x11375 <= value && value <= 0x113FF) { return true }
    if value == 0x1145A { return true }
    if value == 0x1145C { return true }
    if (0x1145E <= value && value <= 0x1147F) { return true }
    if (0x114C8 <= value && value <= 0x114CF) { return true }
    if (0x114DA <= value && value <= 0x1157F) { return true }
    if (0x115B6 <= value && value <= 0x115B7) { return true }
    if (0x115DE <= value && value <= 0x115FF) { return true }
    if (0x11645 <= value && value <= 0x1164F) { return true }
    if (0x1165A <= value && value <= 0x1165F) { return true }
    if (0x1166D <= value && value <= 0x1167F) { return true }
    if (0x116B8 <= value && value <= 0x116BF) { return true }
    if (0x116CA <= value && value <= 0x116FF) { return true }
    if (0x1171A <= value && value <= 0x1171C) { return true }
    if (0x1172C <= value && value <= 0x1172F) { return true }
    if (0x11740 <= value && value <= 0x1189F) { return true }
    if (0x118F3 <= value && value <= 0x118FE) { return true }
    if (0x11900 <= value && value <= 0x119FF) { return true }
    if (0x11A48 <= value && value <= 0x11A4F) { return true }
    if (0x11A84 <= value && value <= 0x11A85) { return true }
    if value == 0x11A9D { return true }
    if (0x11AA3 <= value && value <= 0x11ABF) { return true }
    if (0x11AF9 <= value && value <= 0x11BFF) { return true }
    if value == 0x11C09 { return true }
    if value == 0x11C37 { return true }
    if (0x11C46 <= value && value <= 0x11C4F) { return true }
    if (0x11C6D <= value && value <= 0x11C6F) { return true }
    if (0x11C90 <= value && value <= 0x11C91) { return true }
    if value == 0x11CA8 { return true }
    if (0x11CB7 <= value && value <= 0x11CFF) { return true }
    if value == 0x11D07 { return true }
    if value == 0x11D0A { return true }
    if (0x11D37 <= value && value <= 0x11D39) { return true }
    if value == 0x11D3B { return true }
    if value == 0x11D3E { return true }
    if (0x11D48 <= value && value <= 0x11D4F) { return true }
    if (0x11D5A <= value && value <= 0x11FFF) { return true }
    if (0x1239A <= value && value <= 0x123FF) { return true }
    if value == 0x1246F { return true }
    if (0x12475 <= value && value <= 0x1247F) { return true }
    if (0x12544 <= value && value <= 0x12FFF) { return true }
    if (0x1342F <= value && value <= 0x143FF) { return true }
    if (0x14647 <= value && value <= 0x167FF) { return true }
    if (0x16A39 <= value && value <= 0x16A3F) { return true }
    if value == 0x16A5F { return true }
    if (0x16A6A <= value && value <= 0x16A6D) { return true }
    if (0x16A70 <= value && value <= 0x16ACF) { return true }
    if (0x16AEE <= value && value <= 0x16AEF) { return true }
    if (0x16AF6 <= value && value <= 0x16AFF) { return true }
    if (0x16B46 <= value && value <= 0x16B4F) { return true }
    if value == 0x16B5A { return true }
    if value == 0x16B62 { return true }
    if (0x16B78 <= value && value <= 0x16B7C) { return true }
    if (0x16B90 <= value && value <= 0x16EFF) { return true }
    if (0x16F45 <= value && value <= 0x16F4F) { return true }
    if (0x16F7F <= value && value <= 0x16F8E) { return true }
    if (0x16FA0 <= value && value <= 0x16FDF) { return true }
    if (0x16FE2 <= value && value <= 0x16FFF) { return true }
    if (0x187ED <= value && value <= 0x187FF) { return true }
    if (0x18AF3 <= value && value <= 0x1AFFF) { return true }
    if (0x1B11F <= value && value <= 0x1B16F) { return true }
    if (0x1B2FC <= value && value <= 0x1BBFF) { return true }
    if (0x1BC6B <= value && value <= 0x1BC6F) { return true }
    if (0x1BC7D <= value && value <= 0x1BC7F) { return true }
    if (0x1BC89 <= value && value <= 0x1BC8F) { return true }
    if (0x1BC9A <= value && value <= 0x1BC9B) { return true }
    if (0x1BCA4 <= value && value <= 0x1CFFF) { return true }
    if (0x1D0F6 <= value && value <= 0x1D0FF) { return true }
    if (0x1D127 <= value && value <= 0x1D128) { return true }
    if (0x1D173 <= value && value <= 0x1D17A) { return true }
    if (0x1D1E9 <= value && value <= 0x1D1FF) { return true }
    if (0x1D246 <= value && value <= 0x1D2FF) { return true }
    if (0x1D357 <= value && value <= 0x1D35F) { return true }
    if (0x1D372 <= value && value <= 0x1D3FF) { return true }
    if value == 0x1D455 { return true }
    if value == 0x1D49D { return true }
    if (0x1D4A0 <= value && value <= 0x1D4A1) { return true }
    if (0x1D4A3 <= value && value <= 0x1D4A4) { return true }
    if (0x1D4A7 <= value && value <= 0x1D4A8) { return true }
    if value == 0x1D4AD { return true }
    if value == 0x1D4BA { return true }
    if value == 0x1D4BC { return true }
    if value == 0x1D4C4 { return true }
    if value == 0x1D506 { return true }
    if (0x1D50B <= value && value <= 0x1D50C) { return true }
    if value == 0x1D515 { return true }
    if value == 0x1D51D { return true }
    if value == 0x1D53A { return true }
    if value == 0x1D53F { return true }
    if value == 0x1D545 { return true }
    if (0x1D547 <= value && value <= 0x1D549) { return true }
    if value == 0x1D551 { return true }
    if (0x1D6A6 <= value && value <= 0x1D6A7) { return true }
    if (0x1D7CC <= value && value <= 0x1D7CD) { return true }
    if (0x1DA8C <= value && value <= 0x1DA9A) { return true }
    if value == 0x1DAA0 { return true }
    if (0x1DAB0 <= value && value <= 0x1DFFF) { return true }
    if value == 0x1E007 { return true }
    if (0x1E019 <= value && value <= 0x1E01A) { return true }
    if value == 0x1E022 { return true }
    if value == 0x1E025 { return true }
    if (0x1E02B <= value && value <= 0x1E7FF) { return true }
    if (0x1E8C5 <= value && value <= 0x1E8C6) { return true }
    if (0x1E8D7 <= value && value <= 0x1E8FF) { return true }
    if (0x1E94B <= value && value <= 0x1E94F) { return true }
    if (0x1E95A <= value && value <= 0x1E95D) { return true }
    if (0x1E960 <= value && value <= 0x1EDFF) { return true }
    if value == 0x1EE04 { return true }
    if value == 0x1EE20 { return true }
    if value == 0x1EE23 { return true }
    if (0x1EE25 <= value && value <= 0x1EE26) { return true }
    if value == 0x1EE28 { return true }
    if value == 0x1EE33 { return true }
    if value == 0x1EE38 { return true }
    if value == 0x1EE3A { return true }
    if (0x1EE3C <= value && value <= 0x1EE41) { return true }
    if (0x1EE43 <= value && value <= 0x1EE46) { return true }
    if value == 0x1EE48 { return true }
    if value == 0x1EE4A { return true }
    if value == 0x1EE4C { return true }
    if value == 0x1EE50 { return true }
    if value == 0x1EE53 { return true }
    if (0x1EE55 <= value && value <= 0x1EE56) { return true }
    if value == 0x1EE58 { return true }
    if value == 0x1EE5A { return true }
    if value == 0x1EE5C { return true }
    if value == 0x1EE5E { return true }
    if value == 0x1EE60 { return true }
    if value == 0x1EE63 { return true }
    if (0x1EE65 <= value && value <= 0x1EE66) { return true }
    if value == 0x1EE6B { return true }
    if value == 0x1EE73 { return true }
    if value == 0x1EE78 { return true }
    if value == 0x1EE7D { return true }
    if value == 0x1EE7F { return true }
    if value == 0x1EE8A { return true }
    if (0x1EE9C <= value && value <= 0x1EEA0) { return true }
    if value == 0x1EEA4 { return true }
    if value == 0x1EEAA { return true }
    if (0x1EEBC <= value && value <= 0x1EEEF) { return true }
    if (0x1EEF2 <= value && value <= 0x1EFFF) { return true }
    if (0x1F02C <= value && value <= 0x1F02F) { return true }
    if (0x1F094 <= value && value <= 0x1F09F) { return true }
    if (0x1F0AF <= value && value <= 0x1F0B0) { return true }
    if value == 0x1F0C0 { return true }
    if value == 0x1F0D0 { return true }
    if (0x1F0F6 <= value && value <= 0x1F0FF) { return true }
    if value == 0x1F100 { return true }
    if (0x1F10D <= value && value <= 0x1F10F) { return true }
    if value == 0x1F12F { return true }
    if (0x1F16C <= value && value <= 0x1F16F) { return true }
    if (0x1F1AD <= value && value <= 0x1F1E5) { return true }
    if (0x1F203 <= value && value <= 0x1F20F) { return true }
    if (0x1F23C <= value && value <= 0x1F23F) { return true }
    if (0x1F249 <= value && value <= 0x1F24F) { return true }
    if (0x1F252 <= value && value <= 0x1F25F) { return true }
    if (0x1F266 <= value && value <= 0x1F2FF) { return true }
    if (0x1F6D5 <= value && value <= 0x1F6DF) { return true }
    if (0x1F6ED <= value && value <= 0x1F6EF) { return true }
    if (0x1F6F9 <= value && value <= 0x1F6FF) { return true }
    if (0x1F774 <= value && value <= 0x1F77F) { return true }
    if (0x1F7D5 <= value && value <= 0x1F7FF) { return true }
    if (0x1F80C <= value && value <= 0x1F80F) { return true }
    if (0x1F848 <= value && value <= 0x1F84F) { return true }
    if (0x1F85A <= value && value <= 0x1F85F) { return true }
    if (0x1F888 <= value && value <= 0x1F88F) { return true }
    if (0x1F8AE <= value && value <= 0x1F8FF) { return true }
    if (0x1F90C <= value && value <= 0x1F90F) { return true }
    if value == 0x1F93F { return true }
    if (0x1F94D <= value && value <= 0x1F94F) { return true }
    if (0x1F96C <= value && value <= 0x1F97F) { return true }
    if (0x1F998 <= value && value <= 0x1F9BF) { return true }
    if (0x1F9C1 <= value && value <= 0x1F9CF) { return true }
    if (0x1F9E7 <= value && value <= 0x1FFFD) { return true }
    if (0x1FFFE <= value && value <= 0x1FFFF) { return true }
    if (0x2A6D7 <= value && value <= 0x2A6FF) { return true }
    if (0x2B735 <= value && value <= 0x2B73F) { return true }
    if (0x2B81E <= value && value <= 0x2B81F) { return true }
    if (0x2CEA2 <= value && value <= 0x2CEAF) { return true }
    if (0x2EBE1 <= value && value <= 0x2F7FF) { return true }
    if value == 0x2F868 { return true }
    if value == 0x2F874 { return true }
    if value == 0x2F91F { return true }
    if value == 0x2F95F { return true }
    if value == 0x2F9BF { return true }
    if (0x2FA1E <= value && value <= 0x2FFFD) { return true }
    if (0x2FFFE <= value && value <= 0x2FFFF) { return true }
    if (0x30000 <= value && value <= 0x3FFFD) { return true }
    if (0x3FFFE <= value && value <= 0x3FFFF) { return true }
    if (0x40000 <= value && value <= 0x4FFFD) { return true }
    if (0x4FFFE <= value && value <= 0x4FFFF) { return true }
    if (0x50000 <= value && value <= 0x5FFFD) { return true }
    if (0x5FFFE <= value && value <= 0x5FFFF) { return true }
    if (0x60000 <= value && value <= 0x6FFFD) { return true }
    if (0x6FFFE <= value && value <= 0x6FFFF) { return true }
    if (0x70000 <= value && value <= 0x7FFFD) { return true }
    if (0x7FFFE <= value && value <= 0x7FFFF) { return true }
    if (0x80000 <= value && value <= 0x8FFFD) { return true }
    if (0x8FFFE <= value && value <= 0x8FFFF) { return true }
    if (0x90000 <= value && value <= 0x9FFFD) { return true }
    if (0x9FFFE <= value && value <= 0x9FFFF) { return true }
    if (0xA0000 <= value && value <= 0xAFFFD) { return true }
    if (0xAFFFE <= value && value <= 0xAFFFF) { return true }
    if (0xB0000 <= value && value <= 0xBFFFD) { return true }
    if (0xBFFFE <= value && value <= 0xBFFFF) { return true }
    if (0xC0000 <= value && value <= 0xCFFFD) { return true }
    if (0xCFFFE <= value && value <= 0xCFFFF) { return true }
    if (0xD0000 <= value && value <= 0xDFFFD) { return true }
    if (0xDFFFE <= value && value <= 0xDFFFF) { return true }
    if value == 0xE0000 { return true }
    if value == 0xE0001 { return true }
    if (0xE0002 <= value && value <= 0xE001F) { return true }
    if (0xE0020 <= value && value <= 0xE007F) { return true }
    if (0xE0080 <= value && value <= 0xE00FF) { return true }
    if (0xE01F0 <= value && value <= 0xEFFFD) { return true }
    if (0xEFFFE <= value && value <= 0xEFFFF) { return true }
    if (0xF0000 <= value && value <= 0xFFFFD) { return true }
    if (0xFFFFE <= value && value <= 0xFFFFF) { return true }
    if (0x100000 <= value && value <= 0x10FFFD) { return true }
    if (0x10FFFE <= value && value <= 0x10FFFF) { return true }
    return false
  }
  fileprivate var isDisallowedButValidUsingSTD3ASCIIRules: Bool {
    let value: UInt32 = self.value
    if (0x0000 <= value && value <= 0x002C) { return true }
    if value == 0x002F { return true }
    if (0x003A <= value && value <= 0x0040) { return true }
    if (0x005B <= value && value <= 0x0060) { return true }
    if (0x007B <= value && value <= 0x007F) { return true }
    if value == 0x2260 { return true }
    if (0x226E <= value && value <= 0x226F) { return true }
    return false
  }
  fileprivate var isMapped: (Bool, to:[UnicodeScalar]?) {
    let value: UInt32 = self.value
    if value == 0x0041 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x0042 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x0043 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x0044 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x0045 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x0046 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x0047 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x0048 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x0049 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x004A { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x004B { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x004C { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x004D { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x004E { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x004F { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x0050 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x0051 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x0052 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x0053 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x0054 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x0055 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x0056 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x0057 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x0058 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x0059 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x005A { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x00AA { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x00B2 { return (true, to:[UnicodeScalar(0x0032)!]) }
    if value == 0x00B3 { return (true, to:[UnicodeScalar(0x0033)!]) }
    if value == 0x00B5 { return (true, to:[UnicodeScalar(0x03BC)!]) }
    if value == 0x00B9 { return (true, to:[UnicodeScalar(0x0031)!]) }
    if value == 0x00BA { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x00BC { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0034)!]) }
    if value == 0x00BD { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0032)!]) }
    if value == 0x00BE { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0034)!]) }
    if value == 0x00C0 { return (true, to:[UnicodeScalar(0x00E0)!]) }
    if value == 0x00C1 { return (true, to:[UnicodeScalar(0x00E1)!]) }
    if value == 0x00C2 { return (true, to:[UnicodeScalar(0x00E2)!]) }
    if value == 0x00C3 { return (true, to:[UnicodeScalar(0x00E3)!]) }
    if value == 0x00C4 { return (true, to:[UnicodeScalar(0x00E4)!]) }
    if value == 0x00C5 { return (true, to:[UnicodeScalar(0x00E5)!]) }
    if value == 0x00C6 { return (true, to:[UnicodeScalar(0x00E6)!]) }
    if value == 0x00C7 { return (true, to:[UnicodeScalar(0x00E7)!]) }
    if value == 0x00C8 { return (true, to:[UnicodeScalar(0x00E8)!]) }
    if value == 0x00C9 { return (true, to:[UnicodeScalar(0x00E9)!]) }
    if value == 0x00CA { return (true, to:[UnicodeScalar(0x00EA)!]) }
    if value == 0x00CB { return (true, to:[UnicodeScalar(0x00EB)!]) }
    if value == 0x00CC { return (true, to:[UnicodeScalar(0x00EC)!]) }
    if value == 0x00CD { return (true, to:[UnicodeScalar(0x00ED)!]) }
    if value == 0x00CE { return (true, to:[UnicodeScalar(0x00EE)!]) }
    if value == 0x00CF { return (true, to:[UnicodeScalar(0x00EF)!]) }
    if value == 0x00D0 { return (true, to:[UnicodeScalar(0x00F0)!]) }
    if value == 0x00D1 { return (true, to:[UnicodeScalar(0x00F1)!]) }
    if value == 0x00D2 { return (true, to:[UnicodeScalar(0x00F2)!]) }
    if value == 0x00D3 { return (true, to:[UnicodeScalar(0x00F3)!]) }
    if value == 0x00D4 { return (true, to:[UnicodeScalar(0x00F4)!]) }
    if value == 0x00D5 { return (true, to:[UnicodeScalar(0x00F5)!]) }
    if value == 0x00D6 { return (true, to:[UnicodeScalar(0x00F6)!]) }
    if value == 0x00D8 { return (true, to:[UnicodeScalar(0x00F8)!]) }
    if value == 0x00D9 { return (true, to:[UnicodeScalar(0x00F9)!]) }
    if value == 0x00DA { return (true, to:[UnicodeScalar(0x00FA)!]) }
    if value == 0x00DB { return (true, to:[UnicodeScalar(0x00FB)!]) }
    if value == 0x00DC { return (true, to:[UnicodeScalar(0x00FC)!]) }
    if value == 0x00DD { return (true, to:[UnicodeScalar(0x00FD)!]) }
    if value == 0x00DE { return (true, to:[UnicodeScalar(0x00FE)!]) }
    if value == 0x0100 { return (true, to:[UnicodeScalar(0x0101)!]) }
    if value == 0x0102 { return (true, to:[UnicodeScalar(0x0103)!]) }
    if value == 0x0104 { return (true, to:[UnicodeScalar(0x0105)!]) }
    if value == 0x0106 { return (true, to:[UnicodeScalar(0x0107)!]) }
    if value == 0x0108 { return (true, to:[UnicodeScalar(0x0109)!]) }
    if value == 0x010A { return (true, to:[UnicodeScalar(0x010B)!]) }
    if value == 0x010C { return (true, to:[UnicodeScalar(0x010D)!]) }
    if value == 0x010E { return (true, to:[UnicodeScalar(0x010F)!]) }
    if value == 0x0110 { return (true, to:[UnicodeScalar(0x0111)!]) }
    if value == 0x0112 { return (true, to:[UnicodeScalar(0x0113)!]) }
    if value == 0x0114 { return (true, to:[UnicodeScalar(0x0115)!]) }
    if value == 0x0116 { return (true, to:[UnicodeScalar(0x0117)!]) }
    if value == 0x0118 { return (true, to:[UnicodeScalar(0x0119)!]) }
    if value == 0x011A { return (true, to:[UnicodeScalar(0x011B)!]) }
    if value == 0x011C { return (true, to:[UnicodeScalar(0x011D)!]) }
    if value == 0x011E { return (true, to:[UnicodeScalar(0x011F)!]) }
    if value == 0x0120 { return (true, to:[UnicodeScalar(0x0121)!]) }
    if value == 0x0122 { return (true, to:[UnicodeScalar(0x0123)!]) }
    if value == 0x0124 { return (true, to:[UnicodeScalar(0x0125)!]) }
    if value == 0x0126 { return (true, to:[UnicodeScalar(0x0127)!]) }
    if value == 0x0128 { return (true, to:[UnicodeScalar(0x0129)!]) }
    if value == 0x012A { return (true, to:[UnicodeScalar(0x012B)!]) }
    if value == 0x012C { return (true, to:[UnicodeScalar(0x012D)!]) }
    if value == 0x012E { return (true, to:[UnicodeScalar(0x012F)!]) }
    if value == 0x0130 { return (true, to:[UnicodeScalar(0x0069)!, UnicodeScalar(0x0307)!]) }
    if (0x0132 <= value && value <= 0x0133) { return (true, to:[UnicodeScalar(0x0069)!, UnicodeScalar(0x006A)!]) }
    if value == 0x0134 { return (true, to:[UnicodeScalar(0x0135)!]) }
    if value == 0x0136 { return (true, to:[UnicodeScalar(0x0137)!]) }
    if value == 0x0139 { return (true, to:[UnicodeScalar(0x013A)!]) }
    if value == 0x013B { return (true, to:[UnicodeScalar(0x013C)!]) }
    if value == 0x013D { return (true, to:[UnicodeScalar(0x013E)!]) }
    if (0x013F <= value && value <= 0x0140) { return (true, to:[UnicodeScalar(0x006C)!, UnicodeScalar(0x00B7)!]) }
    if value == 0x0141 { return (true, to:[UnicodeScalar(0x0142)!]) }
    if value == 0x0143 { return (true, to:[UnicodeScalar(0x0144)!]) }
    if value == 0x0145 { return (true, to:[UnicodeScalar(0x0146)!]) }
    if value == 0x0147 { return (true, to:[UnicodeScalar(0x0148)!]) }
    if value == 0x0149 { return (true, to:[UnicodeScalar(0x02BC)!, UnicodeScalar(0x006E)!]) }
    if value == 0x014A { return (true, to:[UnicodeScalar(0x014B)!]) }
    if value == 0x014C { return (true, to:[UnicodeScalar(0x014D)!]) }
    if value == 0x014E { return (true, to:[UnicodeScalar(0x014F)!]) }
    if value == 0x0150 { return (true, to:[UnicodeScalar(0x0151)!]) }
    if value == 0x0152 { return (true, to:[UnicodeScalar(0x0153)!]) }
    if value == 0x0154 { return (true, to:[UnicodeScalar(0x0155)!]) }
    if value == 0x0156 { return (true, to:[UnicodeScalar(0x0157)!]) }
    if value == 0x0158 { return (true, to:[UnicodeScalar(0x0159)!]) }
    if value == 0x015A { return (true, to:[UnicodeScalar(0x015B)!]) }
    if value == 0x015C { return (true, to:[UnicodeScalar(0x015D)!]) }
    if value == 0x015E { return (true, to:[UnicodeScalar(0x015F)!]) }
    if value == 0x0160 { return (true, to:[UnicodeScalar(0x0161)!]) }
    if value == 0x0162 { return (true, to:[UnicodeScalar(0x0163)!]) }
    if value == 0x0164 { return (true, to:[UnicodeScalar(0x0165)!]) }
    if value == 0x0166 { return (true, to:[UnicodeScalar(0x0167)!]) }
    if value == 0x0168 { return (true, to:[UnicodeScalar(0x0169)!]) }
    if value == 0x016A { return (true, to:[UnicodeScalar(0x016B)!]) }
    if value == 0x016C { return (true, to:[UnicodeScalar(0x016D)!]) }
    if value == 0x016E { return (true, to:[UnicodeScalar(0x016F)!]) }
    if value == 0x0170 { return (true, to:[UnicodeScalar(0x0171)!]) }
    if value == 0x0172 { return (true, to:[UnicodeScalar(0x0173)!]) }
    if value == 0x0174 { return (true, to:[UnicodeScalar(0x0175)!]) }
    if value == 0x0176 { return (true, to:[UnicodeScalar(0x0177)!]) }
    if value == 0x0178 { return (true, to:[UnicodeScalar(0x00FF)!]) }
    if value == 0x0179 { return (true, to:[UnicodeScalar(0x017A)!]) }
    if value == 0x017B { return (true, to:[UnicodeScalar(0x017C)!]) }
    if value == 0x017D { return (true, to:[UnicodeScalar(0x017E)!]) }
    if value == 0x017F { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x0181 { return (true, to:[UnicodeScalar(0x0253)!]) }
    if value == 0x0182 { return (true, to:[UnicodeScalar(0x0183)!]) }
    if value == 0x0184 { return (true, to:[UnicodeScalar(0x0185)!]) }
    if value == 0x0186 { return (true, to:[UnicodeScalar(0x0254)!]) }
    if value == 0x0187 { return (true, to:[UnicodeScalar(0x0188)!]) }
    if value == 0x0189 { return (true, to:[UnicodeScalar(0x0256)!]) }
    if value == 0x018A { return (true, to:[UnicodeScalar(0x0257)!]) }
    if value == 0x018B { return (true, to:[UnicodeScalar(0x018C)!]) }
    if value == 0x018E { return (true, to:[UnicodeScalar(0x01DD)!]) }
    if value == 0x018F { return (true, to:[UnicodeScalar(0x0259)!]) }
    if value == 0x0190 { return (true, to:[UnicodeScalar(0x025B)!]) }
    if value == 0x0191 { return (true, to:[UnicodeScalar(0x0192)!]) }
    if value == 0x0193 { return (true, to:[UnicodeScalar(0x0260)!]) }
    if value == 0x0194 { return (true, to:[UnicodeScalar(0x0263)!]) }
    if value == 0x0196 { return (true, to:[UnicodeScalar(0x0269)!]) }
    if value == 0x0197 { return (true, to:[UnicodeScalar(0x0268)!]) }
    if value == 0x0198 { return (true, to:[UnicodeScalar(0x0199)!]) }
    if value == 0x019C { return (true, to:[UnicodeScalar(0x026F)!]) }
    if value == 0x019D { return (true, to:[UnicodeScalar(0x0272)!]) }
    if value == 0x019F { return (true, to:[UnicodeScalar(0x0275)!]) }
    if value == 0x01A0 { return (true, to:[UnicodeScalar(0x01A1)!]) }
    if value == 0x01A2 { return (true, to:[UnicodeScalar(0x01A3)!]) }
    if value == 0x01A4 { return (true, to:[UnicodeScalar(0x01A5)!]) }
    if value == 0x01A6 { return (true, to:[UnicodeScalar(0x0280)!]) }
    if value == 0x01A7 { return (true, to:[UnicodeScalar(0x01A8)!]) }
    if value == 0x01A9 { return (true, to:[UnicodeScalar(0x0283)!]) }
    if value == 0x01AC { return (true, to:[UnicodeScalar(0x01AD)!]) }
    if value == 0x01AE { return (true, to:[UnicodeScalar(0x0288)!]) }
    if value == 0x01AF { return (true, to:[UnicodeScalar(0x01B0)!]) }
    if value == 0x01B1 { return (true, to:[UnicodeScalar(0x028A)!]) }
    if value == 0x01B2 { return (true, to:[UnicodeScalar(0x028B)!]) }
    if value == 0x01B3 { return (true, to:[UnicodeScalar(0x01B4)!]) }
    if value == 0x01B5 { return (true, to:[UnicodeScalar(0x01B6)!]) }
    if value == 0x01B7 { return (true, to:[UnicodeScalar(0x0292)!]) }
    if value == 0x01B8 { return (true, to:[UnicodeScalar(0x01B9)!]) }
    if value == 0x01BC { return (true, to:[UnicodeScalar(0x01BD)!]) }
    if (0x01C4 <= value && value <= 0x01C6) { return (true, to:[UnicodeScalar(0x0064)!, UnicodeScalar(0x017E)!]) }
    if (0x01C7 <= value && value <= 0x01C9) { return (true, to:[UnicodeScalar(0x006C)!, UnicodeScalar(0x006A)!]) }
    if (0x01CA <= value && value <= 0x01CC) { return (true, to:[UnicodeScalar(0x006E)!, UnicodeScalar(0x006A)!]) }
    if value == 0x01CD { return (true, to:[UnicodeScalar(0x01CE)!]) }
    if value == 0x01CF { return (true, to:[UnicodeScalar(0x01D0)!]) }
    if value == 0x01D1 { return (true, to:[UnicodeScalar(0x01D2)!]) }
    if value == 0x01D3 { return (true, to:[UnicodeScalar(0x01D4)!]) }
    if value == 0x01D5 { return (true, to:[UnicodeScalar(0x01D6)!]) }
    if value == 0x01D7 { return (true, to:[UnicodeScalar(0x01D8)!]) }
    if value == 0x01D9 { return (true, to:[UnicodeScalar(0x01DA)!]) }
    if value == 0x01DB { return (true, to:[UnicodeScalar(0x01DC)!]) }
    if value == 0x01DE { return (true, to:[UnicodeScalar(0x01DF)!]) }
    if value == 0x01E0 { return (true, to:[UnicodeScalar(0x01E1)!]) }
    if value == 0x01E2 { return (true, to:[UnicodeScalar(0x01E3)!]) }
    if value == 0x01E4 { return (true, to:[UnicodeScalar(0x01E5)!]) }
    if value == 0x01E6 { return (true, to:[UnicodeScalar(0x01E7)!]) }
    if value == 0x01E8 { return (true, to:[UnicodeScalar(0x01E9)!]) }
    if value == 0x01EA { return (true, to:[UnicodeScalar(0x01EB)!]) }
    if value == 0x01EC { return (true, to:[UnicodeScalar(0x01ED)!]) }
    if value == 0x01EE { return (true, to:[UnicodeScalar(0x01EF)!]) }
    if (0x01F1 <= value && value <= 0x01F3) { return (true, to:[UnicodeScalar(0x0064)!, UnicodeScalar(0x007A)!]) }
    if value == 0x01F4 { return (true, to:[UnicodeScalar(0x01F5)!]) }
    if value == 0x01F6 { return (true, to:[UnicodeScalar(0x0195)!]) }
    if value == 0x01F7 { return (true, to:[UnicodeScalar(0x01BF)!]) }
    if value == 0x01F8 { return (true, to:[UnicodeScalar(0x01F9)!]) }
    if value == 0x01FA { return (true, to:[UnicodeScalar(0x01FB)!]) }
    if value == 0x01FC { return (true, to:[UnicodeScalar(0x01FD)!]) }
    if value == 0x01FE { return (true, to:[UnicodeScalar(0x01FF)!]) }
    if value == 0x0200 { return (true, to:[UnicodeScalar(0x0201)!]) }
    if value == 0x0202 { return (true, to:[UnicodeScalar(0x0203)!]) }
    if value == 0x0204 { return (true, to:[UnicodeScalar(0x0205)!]) }
    if value == 0x0206 { return (true, to:[UnicodeScalar(0x0207)!]) }
    if value == 0x0208 { return (true, to:[UnicodeScalar(0x0209)!]) }
    if value == 0x020A { return (true, to:[UnicodeScalar(0x020B)!]) }
    if value == 0x020C { return (true, to:[UnicodeScalar(0x020D)!]) }
    if value == 0x020E { return (true, to:[UnicodeScalar(0x020F)!]) }
    if value == 0x0210 { return (true, to:[UnicodeScalar(0x0211)!]) }
    if value == 0x0212 { return (true, to:[UnicodeScalar(0x0213)!]) }
    if value == 0x0214 { return (true, to:[UnicodeScalar(0x0215)!]) }
    if value == 0x0216 { return (true, to:[UnicodeScalar(0x0217)!]) }
    if value == 0x0218 { return (true, to:[UnicodeScalar(0x0219)!]) }
    if value == 0x021A { return (true, to:[UnicodeScalar(0x021B)!]) }
    if value == 0x021C { return (true, to:[UnicodeScalar(0x021D)!]) }
    if value == 0x021E { return (true, to:[UnicodeScalar(0x021F)!]) }
    if value == 0x0220 { return (true, to:[UnicodeScalar(0x019E)!]) }
    if value == 0x0222 { return (true, to:[UnicodeScalar(0x0223)!]) }
    if value == 0x0224 { return (true, to:[UnicodeScalar(0x0225)!]) }
    if value == 0x0226 { return (true, to:[UnicodeScalar(0x0227)!]) }
    if value == 0x0228 { return (true, to:[UnicodeScalar(0x0229)!]) }
    if value == 0x022A { return (true, to:[UnicodeScalar(0x022B)!]) }
    if value == 0x022C { return (true, to:[UnicodeScalar(0x022D)!]) }
    if value == 0x022E { return (true, to:[UnicodeScalar(0x022F)!]) }
    if value == 0x0230 { return (true, to:[UnicodeScalar(0x0231)!]) }
    if value == 0x0232 { return (true, to:[UnicodeScalar(0x0233)!]) }
    if value == 0x023A { return (true, to:[UnicodeScalar(0x2C65)!]) }
    if value == 0x023B { return (true, to:[UnicodeScalar(0x023C)!]) }
    if value == 0x023D { return (true, to:[UnicodeScalar(0x019A)!]) }
    if value == 0x023E { return (true, to:[UnicodeScalar(0x2C66)!]) }
    if value == 0x0241 { return (true, to:[UnicodeScalar(0x0242)!]) }
    if value == 0x0243 { return (true, to:[UnicodeScalar(0x0180)!]) }
    if value == 0x0244 { return (true, to:[UnicodeScalar(0x0289)!]) }
    if value == 0x0245 { return (true, to:[UnicodeScalar(0x028C)!]) }
    if value == 0x0246 { return (true, to:[UnicodeScalar(0x0247)!]) }
    if value == 0x0248 { return (true, to:[UnicodeScalar(0x0249)!]) }
    if value == 0x024A { return (true, to:[UnicodeScalar(0x024B)!]) }
    if value == 0x024C { return (true, to:[UnicodeScalar(0x024D)!]) }
    if value == 0x024E { return (true, to:[UnicodeScalar(0x024F)!]) }
    if value == 0x02B0 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x02B1 { return (true, to:[UnicodeScalar(0x0266)!]) }
    if value == 0x02B2 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x02B3 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x02B4 { return (true, to:[UnicodeScalar(0x0279)!]) }
    if value == 0x02B5 { return (true, to:[UnicodeScalar(0x027B)!]) }
    if value == 0x02B6 { return (true, to:[UnicodeScalar(0x0281)!]) }
    if value == 0x02B7 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x02B8 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x02E0 { return (true, to:[UnicodeScalar(0x0263)!]) }
    if value == 0x02E1 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x02E2 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x02E3 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x02E4 { return (true, to:[UnicodeScalar(0x0295)!]) }
    if value == 0x0340 { return (true, to:[UnicodeScalar(0x0300)!]) }
    if value == 0x0341 { return (true, to:[UnicodeScalar(0x0301)!]) }
    if value == 0x0343 { return (true, to:[UnicodeScalar(0x0313)!]) }
    if value == 0x0344 { return (true, to:[UnicodeScalar(0x0308)!, UnicodeScalar(0x0301)!]) }
    if value == 0x0345 { return (true, to:[UnicodeScalar(0x03B9)!]) }
    if value == 0x0370 { return (true, to:[UnicodeScalar(0x0371)!]) }
    if value == 0x0372 { return (true, to:[UnicodeScalar(0x0373)!]) }
    if value == 0x0374 { return (true, to:[UnicodeScalar(0x02B9)!]) }
    if value == 0x0376 { return (true, to:[UnicodeScalar(0x0377)!]) }
    if value == 0x037F { return (true, to:[UnicodeScalar(0x03F3)!]) }
    if value == 0x0386 { return (true, to:[UnicodeScalar(0x03AC)!]) }
    if value == 0x0387 { return (true, to:[UnicodeScalar(0x00B7)!]) }
    if value == 0x0388 { return (true, to:[UnicodeScalar(0x03AD)!]) }
    if value == 0x0389 { return (true, to:[UnicodeScalar(0x03AE)!]) }
    if value == 0x038A { return (true, to:[UnicodeScalar(0x03AF)!]) }
    if value == 0x038C { return (true, to:[UnicodeScalar(0x03CC)!]) }
    if value == 0x038E { return (true, to:[UnicodeScalar(0x03CD)!]) }
    if value == 0x038F { return (true, to:[UnicodeScalar(0x03CE)!]) }
    if value == 0x0391 { return (true, to:[UnicodeScalar(0x03B1)!]) }
    if value == 0x0392 { return (true, to:[UnicodeScalar(0x03B2)!]) }
    if value == 0x0393 { return (true, to:[UnicodeScalar(0x03B3)!]) }
    if value == 0x0394 { return (true, to:[UnicodeScalar(0x03B4)!]) }
    if value == 0x0395 { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x0396 { return (true, to:[UnicodeScalar(0x03B6)!]) }
    if value == 0x0397 { return (true, to:[UnicodeScalar(0x03B7)!]) }
    if value == 0x0398 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x0399 { return (true, to:[UnicodeScalar(0x03B9)!]) }
    if value == 0x039A { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x039B { return (true, to:[UnicodeScalar(0x03BB)!]) }
    if value == 0x039C { return (true, to:[UnicodeScalar(0x03BC)!]) }
    if value == 0x039D { return (true, to:[UnicodeScalar(0x03BD)!]) }
    if value == 0x039E { return (true, to:[UnicodeScalar(0x03BE)!]) }
    if value == 0x039F { return (true, to:[UnicodeScalar(0x03BF)!]) }
    if value == 0x03A0 { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x03A1 { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if value == 0x03A3 { return (true, to:[UnicodeScalar(0x03C3)!]) }
    if value == 0x03A4 { return (true, to:[UnicodeScalar(0x03C4)!]) }
    if value == 0x03A5 { return (true, to:[UnicodeScalar(0x03C5)!]) }
    if value == 0x03A6 { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x03A7 { return (true, to:[UnicodeScalar(0x03C7)!]) }
    if value == 0x03A8 { return (true, to:[UnicodeScalar(0x03C8)!]) }
    if value == 0x03A9 { return (true, to:[UnicodeScalar(0x03C9)!]) }
    if value == 0x03AA { return (true, to:[UnicodeScalar(0x03CA)!]) }
    if value == 0x03AB { return (true, to:[UnicodeScalar(0x03CB)!]) }
    if value == 0x03CF { return (true, to:[UnicodeScalar(0x03D7)!]) }
    if value == 0x03D0 { return (true, to:[UnicodeScalar(0x03B2)!]) }
    if value == 0x03D1 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x03D2 { return (true, to:[UnicodeScalar(0x03C5)!]) }
    if value == 0x03D3 { return (true, to:[UnicodeScalar(0x03CD)!]) }
    if value == 0x03D4 { return (true, to:[UnicodeScalar(0x03CB)!]) }
    if value == 0x03D5 { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x03D6 { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x03D8 { return (true, to:[UnicodeScalar(0x03D9)!]) }
    if value == 0x03DA { return (true, to:[UnicodeScalar(0x03DB)!]) }
    if value == 0x03DC { return (true, to:[UnicodeScalar(0x03DD)!]) }
    if value == 0x03DE { return (true, to:[UnicodeScalar(0x03DF)!]) }
    if value == 0x03E0 { return (true, to:[UnicodeScalar(0x03E1)!]) }
    if value == 0x03E2 { return (true, to:[UnicodeScalar(0x03E3)!]) }
    if value == 0x03E4 { return (true, to:[UnicodeScalar(0x03E5)!]) }
    if value == 0x03E6 { return (true, to:[UnicodeScalar(0x03E7)!]) }
    if value == 0x03E8 { return (true, to:[UnicodeScalar(0x03E9)!]) }
    if value == 0x03EA { return (true, to:[UnicodeScalar(0x03EB)!]) }
    if value == 0x03EC { return (true, to:[UnicodeScalar(0x03ED)!]) }
    if value == 0x03EE { return (true, to:[UnicodeScalar(0x03EF)!]) }
    if value == 0x03F0 { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x03F1 { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if value == 0x03F2 { return (true, to:[UnicodeScalar(0x03C3)!]) }
    if value == 0x03F4 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x03F5 { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x03F7 { return (true, to:[UnicodeScalar(0x03F8)!]) }
    if value == 0x03F9 { return (true, to:[UnicodeScalar(0x03C3)!]) }
    if value == 0x03FA { return (true, to:[UnicodeScalar(0x03FB)!]) }
    if value == 0x03FD { return (true, to:[UnicodeScalar(0x037B)!]) }
    if value == 0x03FE { return (true, to:[UnicodeScalar(0x037C)!]) }
    if value == 0x03FF { return (true, to:[UnicodeScalar(0x037D)!]) }
    if value == 0x0400 { return (true, to:[UnicodeScalar(0x0450)!]) }
    if value == 0x0401 { return (true, to:[UnicodeScalar(0x0451)!]) }
    if value == 0x0402 { return (true, to:[UnicodeScalar(0x0452)!]) }
    if value == 0x0403 { return (true, to:[UnicodeScalar(0x0453)!]) }
    if value == 0x0404 { return (true, to:[UnicodeScalar(0x0454)!]) }
    if value == 0x0405 { return (true, to:[UnicodeScalar(0x0455)!]) }
    if value == 0x0406 { return (true, to:[UnicodeScalar(0x0456)!]) }
    if value == 0x0407 { return (true, to:[UnicodeScalar(0x0457)!]) }
    if value == 0x0408 { return (true, to:[UnicodeScalar(0x0458)!]) }
    if value == 0x0409 { return (true, to:[UnicodeScalar(0x0459)!]) }
    if value == 0x040A { return (true, to:[UnicodeScalar(0x045A)!]) }
    if value == 0x040B { return (true, to:[UnicodeScalar(0x045B)!]) }
    if value == 0x040C { return (true, to:[UnicodeScalar(0x045C)!]) }
    if value == 0x040D { return (true, to:[UnicodeScalar(0x045D)!]) }
    if value == 0x040E { return (true, to:[UnicodeScalar(0x045E)!]) }
    if value == 0x040F { return (true, to:[UnicodeScalar(0x045F)!]) }
    if value == 0x0410 { return (true, to:[UnicodeScalar(0x0430)!]) }
    if value == 0x0411 { return (true, to:[UnicodeScalar(0x0431)!]) }
    if value == 0x0412 { return (true, to:[UnicodeScalar(0x0432)!]) }
    if value == 0x0413 { return (true, to:[UnicodeScalar(0x0433)!]) }
    if value == 0x0414 { return (true, to:[UnicodeScalar(0x0434)!]) }
    if value == 0x0415 { return (true, to:[UnicodeScalar(0x0435)!]) }
    if value == 0x0416 { return (true, to:[UnicodeScalar(0x0436)!]) }
    if value == 0x0417 { return (true, to:[UnicodeScalar(0x0437)!]) }
    if value == 0x0418 { return (true, to:[UnicodeScalar(0x0438)!]) }
    if value == 0x0419 { return (true, to:[UnicodeScalar(0x0439)!]) }
    if value == 0x041A { return (true, to:[UnicodeScalar(0x043A)!]) }
    if value == 0x041B { return (true, to:[UnicodeScalar(0x043B)!]) }
    if value == 0x041C { return (true, to:[UnicodeScalar(0x043C)!]) }
    if value == 0x041D { return (true, to:[UnicodeScalar(0x043D)!]) }
    if value == 0x041E { return (true, to:[UnicodeScalar(0x043E)!]) }
    if value == 0x041F { return (true, to:[UnicodeScalar(0x043F)!]) }
    if value == 0x0420 { return (true, to:[UnicodeScalar(0x0440)!]) }
    if value == 0x0421 { return (true, to:[UnicodeScalar(0x0441)!]) }
    if value == 0x0422 { return (true, to:[UnicodeScalar(0x0442)!]) }
    if value == 0x0423 { return (true, to:[UnicodeScalar(0x0443)!]) }
    if value == 0x0424 { return (true, to:[UnicodeScalar(0x0444)!]) }
    if value == 0x0425 { return (true, to:[UnicodeScalar(0x0445)!]) }
    if value == 0x0426 { return (true, to:[UnicodeScalar(0x0446)!]) }
    if value == 0x0427 { return (true, to:[UnicodeScalar(0x0447)!]) }
    if value == 0x0428 { return (true, to:[UnicodeScalar(0x0448)!]) }
    if value == 0x0429 { return (true, to:[UnicodeScalar(0x0449)!]) }
    if value == 0x042A { return (true, to:[UnicodeScalar(0x044A)!]) }
    if value == 0x042B { return (true, to:[UnicodeScalar(0x044B)!]) }
    if value == 0x042C { return (true, to:[UnicodeScalar(0x044C)!]) }
    if value == 0x042D { return (true, to:[UnicodeScalar(0x044D)!]) }
    if value == 0x042E { return (true, to:[UnicodeScalar(0x044E)!]) }
    if value == 0x042F { return (true, to:[UnicodeScalar(0x044F)!]) }
    if value == 0x0460 { return (true, to:[UnicodeScalar(0x0461)!]) }
    if value == 0x0462 { return (true, to:[UnicodeScalar(0x0463)!]) }
    if value == 0x0464 { return (true, to:[UnicodeScalar(0x0465)!]) }
    if value == 0x0466 { return (true, to:[UnicodeScalar(0x0467)!]) }
    if value == 0x0468 { return (true, to:[UnicodeScalar(0x0469)!]) }
    if value == 0x046A { return (true, to:[UnicodeScalar(0x046B)!]) }
    if value == 0x046C { return (true, to:[UnicodeScalar(0x046D)!]) }
    if value == 0x046E { return (true, to:[UnicodeScalar(0x046F)!]) }
    if value == 0x0470 { return (true, to:[UnicodeScalar(0x0471)!]) }
    if value == 0x0472 { return (true, to:[UnicodeScalar(0x0473)!]) }
    if value == 0x0474 { return (true, to:[UnicodeScalar(0x0475)!]) }
    if value == 0x0476 { return (true, to:[UnicodeScalar(0x0477)!]) }
    if value == 0x0478 { return (true, to:[UnicodeScalar(0x0479)!]) }
    if value == 0x047A { return (true, to:[UnicodeScalar(0x047B)!]) }
    if value == 0x047C { return (true, to:[UnicodeScalar(0x047D)!]) }
    if value == 0x047E { return (true, to:[UnicodeScalar(0x047F)!]) }
    if value == 0x0480 { return (true, to:[UnicodeScalar(0x0481)!]) }
    if value == 0x048A { return (true, to:[UnicodeScalar(0x048B)!]) }
    if value == 0x048C { return (true, to:[UnicodeScalar(0x048D)!]) }
    if value == 0x048E { return (true, to:[UnicodeScalar(0x048F)!]) }
    if value == 0x0490 { return (true, to:[UnicodeScalar(0x0491)!]) }
    if value == 0x0492 { return (true, to:[UnicodeScalar(0x0493)!]) }
    if value == 0x0494 { return (true, to:[UnicodeScalar(0x0495)!]) }
    if value == 0x0496 { return (true, to:[UnicodeScalar(0x0497)!]) }
    if value == 0x0498 { return (true, to:[UnicodeScalar(0x0499)!]) }
    if value == 0x049A { return (true, to:[UnicodeScalar(0x049B)!]) }
    if value == 0x049C { return (true, to:[UnicodeScalar(0x049D)!]) }
    if value == 0x049E { return (true, to:[UnicodeScalar(0x049F)!]) }
    if value == 0x04A0 { return (true, to:[UnicodeScalar(0x04A1)!]) }
    if value == 0x04A2 { return (true, to:[UnicodeScalar(0x04A3)!]) }
    if value == 0x04A4 { return (true, to:[UnicodeScalar(0x04A5)!]) }
    if value == 0x04A6 { return (true, to:[UnicodeScalar(0x04A7)!]) }
    if value == 0x04A8 { return (true, to:[UnicodeScalar(0x04A9)!]) }
    if value == 0x04AA { return (true, to:[UnicodeScalar(0x04AB)!]) }
    if value == 0x04AC { return (true, to:[UnicodeScalar(0x04AD)!]) }
    if value == 0x04AE { return (true, to:[UnicodeScalar(0x04AF)!]) }
    if value == 0x04B0 { return (true, to:[UnicodeScalar(0x04B1)!]) }
    if value == 0x04B2 { return (true, to:[UnicodeScalar(0x04B3)!]) }
    if value == 0x04B4 { return (true, to:[UnicodeScalar(0x04B5)!]) }
    if value == 0x04B6 { return (true, to:[UnicodeScalar(0x04B7)!]) }
    if value == 0x04B8 { return (true, to:[UnicodeScalar(0x04B9)!]) }
    if value == 0x04BA { return (true, to:[UnicodeScalar(0x04BB)!]) }
    if value == 0x04BC { return (true, to:[UnicodeScalar(0x04BD)!]) }
    if value == 0x04BE { return (true, to:[UnicodeScalar(0x04BF)!]) }
    if value == 0x04C1 { return (true, to:[UnicodeScalar(0x04C2)!]) }
    if value == 0x04C3 { return (true, to:[UnicodeScalar(0x04C4)!]) }
    if value == 0x04C5 { return (true, to:[UnicodeScalar(0x04C6)!]) }
    if value == 0x04C7 { return (true, to:[UnicodeScalar(0x04C8)!]) }
    if value == 0x04C9 { return (true, to:[UnicodeScalar(0x04CA)!]) }
    if value == 0x04CB { return (true, to:[UnicodeScalar(0x04CC)!]) }
    if value == 0x04CD { return (true, to:[UnicodeScalar(0x04CE)!]) }
    if value == 0x04D0 { return (true, to:[UnicodeScalar(0x04D1)!]) }
    if value == 0x04D2 { return (true, to:[UnicodeScalar(0x04D3)!]) }
    if value == 0x04D4 { return (true, to:[UnicodeScalar(0x04D5)!]) }
    if value == 0x04D6 { return (true, to:[UnicodeScalar(0x04D7)!]) }
    if value == 0x04D8 { return (true, to:[UnicodeScalar(0x04D9)!]) }
    if value == 0x04DA { return (true, to:[UnicodeScalar(0x04DB)!]) }
    if value == 0x04DC { return (true, to:[UnicodeScalar(0x04DD)!]) }
    if value == 0x04DE { return (true, to:[UnicodeScalar(0x04DF)!]) }
    if value == 0x04E0 { return (true, to:[UnicodeScalar(0x04E1)!]) }
    if value == 0x04E2 { return (true, to:[UnicodeScalar(0x04E3)!]) }
    if value == 0x04E4 { return (true, to:[UnicodeScalar(0x04E5)!]) }
    if value == 0x04E6 { return (true, to:[UnicodeScalar(0x04E7)!]) }
    if value == 0x04E8 { return (true, to:[UnicodeScalar(0x04E9)!]) }
    if value == 0x04EA { return (true, to:[UnicodeScalar(0x04EB)!]) }
    if value == 0x04EC { return (true, to:[UnicodeScalar(0x04ED)!]) }
    if value == 0x04EE { return (true, to:[UnicodeScalar(0x04EF)!]) }
    if value == 0x04F0 { return (true, to:[UnicodeScalar(0x04F1)!]) }
    if value == 0x04F2 { return (true, to:[UnicodeScalar(0x04F3)!]) }
    if value == 0x04F4 { return (true, to:[UnicodeScalar(0x04F5)!]) }
    if value == 0x04F6 { return (true, to:[UnicodeScalar(0x04F7)!]) }
    if value == 0x04F8 { return (true, to:[UnicodeScalar(0x04F9)!]) }
    if value == 0x04FA { return (true, to:[UnicodeScalar(0x04FB)!]) }
    if value == 0x04FC { return (true, to:[UnicodeScalar(0x04FD)!]) }
    if value == 0x04FE { return (true, to:[UnicodeScalar(0x04FF)!]) }
    if value == 0x0500 { return (true, to:[UnicodeScalar(0x0501)!]) }
    if value == 0x0502 { return (true, to:[UnicodeScalar(0x0503)!]) }
    if value == 0x0504 { return (true, to:[UnicodeScalar(0x0505)!]) }
    if value == 0x0506 { return (true, to:[UnicodeScalar(0x0507)!]) }
    if value == 0x0508 { return (true, to:[UnicodeScalar(0x0509)!]) }
    if value == 0x050A { return (true, to:[UnicodeScalar(0x050B)!]) }
    if value == 0x050C { return (true, to:[UnicodeScalar(0x050D)!]) }
    if value == 0x050E { return (true, to:[UnicodeScalar(0x050F)!]) }
    if value == 0x0510 { return (true, to:[UnicodeScalar(0x0511)!]) }
    if value == 0x0512 { return (true, to:[UnicodeScalar(0x0513)!]) }
    if value == 0x0514 { return (true, to:[UnicodeScalar(0x0515)!]) }
    if value == 0x0516 { return (true, to:[UnicodeScalar(0x0517)!]) }
    if value == 0x0518 { return (true, to:[UnicodeScalar(0x0519)!]) }
    if value == 0x051A { return (true, to:[UnicodeScalar(0x051B)!]) }
    if value == 0x051C { return (true, to:[UnicodeScalar(0x051D)!]) }
    if value == 0x051E { return (true, to:[UnicodeScalar(0x051F)!]) }
    if value == 0x0520 { return (true, to:[UnicodeScalar(0x0521)!]) }
    if value == 0x0522 { return (true, to:[UnicodeScalar(0x0523)!]) }
    if value == 0x0524 { return (true, to:[UnicodeScalar(0x0525)!]) }
    if value == 0x0526 { return (true, to:[UnicodeScalar(0x0527)!]) }
    if value == 0x0528 { return (true, to:[UnicodeScalar(0x0529)!]) }
    if value == 0x052A { return (true, to:[UnicodeScalar(0x052B)!]) }
    if value == 0x052C { return (true, to:[UnicodeScalar(0x052D)!]) }
    if value == 0x052E { return (true, to:[UnicodeScalar(0x052F)!]) }
    if value == 0x0531 { return (true, to:[UnicodeScalar(0x0561)!]) }
    if value == 0x0532 { return (true, to:[UnicodeScalar(0x0562)!]) }
    if value == 0x0533 { return (true, to:[UnicodeScalar(0x0563)!]) }
    if value == 0x0534 { return (true, to:[UnicodeScalar(0x0564)!]) }
    if value == 0x0535 { return (true, to:[UnicodeScalar(0x0565)!]) }
    if value == 0x0536 { return (true, to:[UnicodeScalar(0x0566)!]) }
    if value == 0x0537 { return (true, to:[UnicodeScalar(0x0567)!]) }
    if value == 0x0538 { return (true, to:[UnicodeScalar(0x0568)!]) }
    if value == 0x0539 { return (true, to:[UnicodeScalar(0x0569)!]) }
    if value == 0x053A { return (true, to:[UnicodeScalar(0x056A)!]) }
    if value == 0x053B { return (true, to:[UnicodeScalar(0x056B)!]) }
    if value == 0x053C { return (true, to:[UnicodeScalar(0x056C)!]) }
    if value == 0x053D { return (true, to:[UnicodeScalar(0x056D)!]) }
    if value == 0x053E { return (true, to:[UnicodeScalar(0x056E)!]) }
    if value == 0x053F { return (true, to:[UnicodeScalar(0x056F)!]) }
    if value == 0x0540 { return (true, to:[UnicodeScalar(0x0570)!]) }
    if value == 0x0541 { return (true, to:[UnicodeScalar(0x0571)!]) }
    if value == 0x0542 { return (true, to:[UnicodeScalar(0x0572)!]) }
    if value == 0x0543 { return (true, to:[UnicodeScalar(0x0573)!]) }
    if value == 0x0544 { return (true, to:[UnicodeScalar(0x0574)!]) }
    if value == 0x0545 { return (true, to:[UnicodeScalar(0x0575)!]) }
    if value == 0x0546 { return (true, to:[UnicodeScalar(0x0576)!]) }
    if value == 0x0547 { return (true, to:[UnicodeScalar(0x0577)!]) }
    if value == 0x0548 { return (true, to:[UnicodeScalar(0x0578)!]) }
    if value == 0x0549 { return (true, to:[UnicodeScalar(0x0579)!]) }
    if value == 0x054A { return (true, to:[UnicodeScalar(0x057A)!]) }
    if value == 0x054B { return (true, to:[UnicodeScalar(0x057B)!]) }
    if value == 0x054C { return (true, to:[UnicodeScalar(0x057C)!]) }
    if value == 0x054D { return (true, to:[UnicodeScalar(0x057D)!]) }
    if value == 0x054E { return (true, to:[UnicodeScalar(0x057E)!]) }
    if value == 0x054F { return (true, to:[UnicodeScalar(0x057F)!]) }
    if value == 0x0550 { return (true, to:[UnicodeScalar(0x0580)!]) }
    if value == 0x0551 { return (true, to:[UnicodeScalar(0x0581)!]) }
    if value == 0x0552 { return (true, to:[UnicodeScalar(0x0582)!]) }
    if value == 0x0553 { return (true, to:[UnicodeScalar(0x0583)!]) }
    if value == 0x0554 { return (true, to:[UnicodeScalar(0x0584)!]) }
    if value == 0x0555 { return (true, to:[UnicodeScalar(0x0585)!]) }
    if value == 0x0556 { return (true, to:[UnicodeScalar(0x0586)!]) }
    if value == 0x0587 { return (true, to:[UnicodeScalar(0x0565)!, UnicodeScalar(0x0582)!]) }
    if value == 0x0675 { return (true, to:[UnicodeScalar(0x0627)!, UnicodeScalar(0x0674)!]) }
    if value == 0x0676 { return (true, to:[UnicodeScalar(0x0648)!, UnicodeScalar(0x0674)!]) }
    if value == 0x0677 { return (true, to:[UnicodeScalar(0x06C7)!, UnicodeScalar(0x0674)!]) }
    if value == 0x0678 { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x0674)!]) }
    if value == 0x0958 { return (true, to:[UnicodeScalar(0x0915)!, UnicodeScalar(0x093C)!]) }
    if value == 0x0959 { return (true, to:[UnicodeScalar(0x0916)!, UnicodeScalar(0x093C)!]) }
    if value == 0x095A { return (true, to:[UnicodeScalar(0x0917)!, UnicodeScalar(0x093C)!]) }
    if value == 0x095B { return (true, to:[UnicodeScalar(0x091C)!, UnicodeScalar(0x093C)!]) }
    if value == 0x095C { return (true, to:[UnicodeScalar(0x0921)!, UnicodeScalar(0x093C)!]) }
    if value == 0x095D { return (true, to:[UnicodeScalar(0x0922)!, UnicodeScalar(0x093C)!]) }
    if value == 0x095E { return (true, to:[UnicodeScalar(0x092B)!, UnicodeScalar(0x093C)!]) }
    if value == 0x095F { return (true, to:[UnicodeScalar(0x092F)!, UnicodeScalar(0x093C)!]) }
    if value == 0x09DC { return (true, to:[UnicodeScalar(0x09A1)!, UnicodeScalar(0x09BC)!]) }
    if value == 0x09DD { return (true, to:[UnicodeScalar(0x09A2)!, UnicodeScalar(0x09BC)!]) }
    if value == 0x09DF { return (true, to:[UnicodeScalar(0x09AF)!, UnicodeScalar(0x09BC)!]) }
    if value == 0x0A33 { return (true, to:[UnicodeScalar(0x0A32)!, UnicodeScalar(0x0A3C)!]) }
    if value == 0x0A36 { return (true, to:[UnicodeScalar(0x0A38)!, UnicodeScalar(0x0A3C)!]) }
    if value == 0x0A59 { return (true, to:[UnicodeScalar(0x0A16)!, UnicodeScalar(0x0A3C)!]) }
    if value == 0x0A5A { return (true, to:[UnicodeScalar(0x0A17)!, UnicodeScalar(0x0A3C)!]) }
    if value == 0x0A5B { return (true, to:[UnicodeScalar(0x0A1C)!, UnicodeScalar(0x0A3C)!]) }
    if value == 0x0A5E { return (true, to:[UnicodeScalar(0x0A2B)!, UnicodeScalar(0x0A3C)!]) }
    if value == 0x0B5C { return (true, to:[UnicodeScalar(0x0B21)!, UnicodeScalar(0x0B3C)!]) }
    if value == 0x0B5D { return (true, to:[UnicodeScalar(0x0B22)!, UnicodeScalar(0x0B3C)!]) }
    if value == 0x0E33 { return (true, to:[UnicodeScalar(0x0E4D)!, UnicodeScalar(0x0E32)!]) }
    if value == 0x0EB3 { return (true, to:[UnicodeScalar(0x0ECD)!, UnicodeScalar(0x0EB2)!]) }
    if value == 0x0EDC { return (true, to:[UnicodeScalar(0x0EAB)!, UnicodeScalar(0x0E99)!]) }
    if value == 0x0EDD { return (true, to:[UnicodeScalar(0x0EAB)!, UnicodeScalar(0x0EA1)!]) }
    if value == 0x0F0C { return (true, to:[UnicodeScalar(0x0F0B)!]) }
    if value == 0x0F43 { return (true, to:[UnicodeScalar(0x0F42)!, UnicodeScalar(0x0FB7)!]) }
    if value == 0x0F4D { return (true, to:[UnicodeScalar(0x0F4C)!, UnicodeScalar(0x0FB7)!]) }
    if value == 0x0F52 { return (true, to:[UnicodeScalar(0x0F51)!, UnicodeScalar(0x0FB7)!]) }
    if value == 0x0F57 { return (true, to:[UnicodeScalar(0x0F56)!, UnicodeScalar(0x0FB7)!]) }
    if value == 0x0F5C { return (true, to:[UnicodeScalar(0x0F5B)!, UnicodeScalar(0x0FB7)!]) }
    if value == 0x0F69 { return (true, to:[UnicodeScalar(0x0F40)!, UnicodeScalar(0x0FB5)!]) }
    if value == 0x0F73 { return (true, to:[UnicodeScalar(0x0F71)!, UnicodeScalar(0x0F72)!]) }
    if value == 0x0F75 { return (true, to:[UnicodeScalar(0x0F71)!, UnicodeScalar(0x0F74)!]) }
    if value == 0x0F76 { return (true, to:[UnicodeScalar(0x0FB2)!, UnicodeScalar(0x0F80)!]) }
    if value == 0x0F77 { return (true, to:[UnicodeScalar(0x0FB2)!, UnicodeScalar(0x0F71)!, UnicodeScalar(0x0F80)!]) }
    if value == 0x0F78 { return (true, to:[UnicodeScalar(0x0FB3)!, UnicodeScalar(0x0F80)!]) }
    if value == 0x0F79 { return (true, to:[UnicodeScalar(0x0FB3)!, UnicodeScalar(0x0F71)!, UnicodeScalar(0x0F80)!]) }
    if value == 0x0F81 { return (true, to:[UnicodeScalar(0x0F71)!, UnicodeScalar(0x0F80)!]) }
    if value == 0x0F93 { return (true, to:[UnicodeScalar(0x0F92)!, UnicodeScalar(0x0FB7)!]) }
    if value == 0x0F9D { return (true, to:[UnicodeScalar(0x0F9C)!, UnicodeScalar(0x0FB7)!]) }
    if value == 0x0FA2 { return (true, to:[UnicodeScalar(0x0FA1)!, UnicodeScalar(0x0FB7)!]) }
    if value == 0x0FA7 { return (true, to:[UnicodeScalar(0x0FA6)!, UnicodeScalar(0x0FB7)!]) }
    if value == 0x0FAC { return (true, to:[UnicodeScalar(0x0FAB)!, UnicodeScalar(0x0FB7)!]) }
    if value == 0x0FB9 { return (true, to:[UnicodeScalar(0x0F90)!, UnicodeScalar(0x0FB5)!]) }
    if value == 0x10C7 { return (true, to:[UnicodeScalar(0x2D27)!]) }
    if value == 0x10CD { return (true, to:[UnicodeScalar(0x2D2D)!]) }
    if value == 0x10FC { return (true, to:[UnicodeScalar(0x10DC)!]) }
    if value == 0x13F8 { return (true, to:[UnicodeScalar(0x13F0)!]) }
    if value == 0x13F9 { return (true, to:[UnicodeScalar(0x13F1)!]) }
    if value == 0x13FA { return (true, to:[UnicodeScalar(0x13F2)!]) }
    if value == 0x13FB { return (true, to:[UnicodeScalar(0x13F3)!]) }
    if value == 0x13FC { return (true, to:[UnicodeScalar(0x13F4)!]) }
    if value == 0x13FD { return (true, to:[UnicodeScalar(0x13F5)!]) }
    if value == 0x1C80 { return (true, to:[UnicodeScalar(0x0432)!]) }
    if value == 0x1C81 { return (true, to:[UnicodeScalar(0x0434)!]) }
    if value == 0x1C82 { return (true, to:[UnicodeScalar(0x043E)!]) }
    if value == 0x1C83 { return (true, to:[UnicodeScalar(0x0441)!]) }
    if (0x1C84 <= value && value <= 0x1C85) { return (true, to:[UnicodeScalar(0x0442)!]) }
    if value == 0x1C86 { return (true, to:[UnicodeScalar(0x044A)!]) }
    if value == 0x1C87 { return (true, to:[UnicodeScalar(0x0463)!]) }
    if value == 0x1C88 { return (true, to:[UnicodeScalar(0xA64B)!]) }
    if value == 0x1D2C { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D2D { return (true, to:[UnicodeScalar(0x00E6)!]) }
    if value == 0x1D2E { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D30 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D31 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D32 { return (true, to:[UnicodeScalar(0x01DD)!]) }
    if value == 0x1D33 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D34 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D35 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D36 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D37 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D38 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D39 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D3A { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D3C { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D3D { return (true, to:[UnicodeScalar(0x0223)!]) }
    if value == 0x1D3E { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D3F { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D40 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D41 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D42 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D43 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D44 { return (true, to:[UnicodeScalar(0x0250)!]) }
    if value == 0x1D45 { return (true, to:[UnicodeScalar(0x0251)!]) }
    if value == 0x1D46 { return (true, to:[UnicodeScalar(0x1D02)!]) }
    if value == 0x1D47 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D48 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D49 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D4A { return (true, to:[UnicodeScalar(0x0259)!]) }
    if value == 0x1D4B { return (true, to:[UnicodeScalar(0x025B)!]) }
    if value == 0x1D4C { return (true, to:[UnicodeScalar(0x025C)!]) }
    if value == 0x1D4D { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D4F { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D50 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D51 { return (true, to:[UnicodeScalar(0x014B)!]) }
    if value == 0x1D52 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D53 { return (true, to:[UnicodeScalar(0x0254)!]) }
    if value == 0x1D54 { return (true, to:[UnicodeScalar(0x1D16)!]) }
    if value == 0x1D55 { return (true, to:[UnicodeScalar(0x1D17)!]) }
    if value == 0x1D56 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D57 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D58 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D59 { return (true, to:[UnicodeScalar(0x1D1D)!]) }
    if value == 0x1D5A { return (true, to:[UnicodeScalar(0x026F)!]) }
    if value == 0x1D5B { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D5C { return (true, to:[UnicodeScalar(0x1D25)!]) }
    if value == 0x1D5D { return (true, to:[UnicodeScalar(0x03B2)!]) }
    if value == 0x1D5E { return (true, to:[UnicodeScalar(0x03B3)!]) }
    if value == 0x1D5F { return (true, to:[UnicodeScalar(0x03B4)!]) }
    if value == 0x1D60 { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D61 { return (true, to:[UnicodeScalar(0x03C7)!]) }
    if value == 0x1D62 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D63 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D64 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D65 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D66 { return (true, to:[UnicodeScalar(0x03B2)!]) }
    if value == 0x1D67 { return (true, to:[UnicodeScalar(0x03B3)!]) }
    if value == 0x1D68 { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if value == 0x1D69 { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D6A { return (true, to:[UnicodeScalar(0x03C7)!]) }
    if value == 0x1D78 { return (true, to:[UnicodeScalar(0x043D)!]) }
    if value == 0x1D9B { return (true, to:[UnicodeScalar(0x0252)!]) }
    if value == 0x1D9C { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D9D { return (true, to:[UnicodeScalar(0x0255)!]) }
    if value == 0x1D9E { return (true, to:[UnicodeScalar(0x00F0)!]) }
    if value == 0x1D9F { return (true, to:[UnicodeScalar(0x025C)!]) }
    if value == 0x1DA0 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1DA1 { return (true, to:[UnicodeScalar(0x025F)!]) }
    if value == 0x1DA2 { return (true, to:[UnicodeScalar(0x0261)!]) }
    if value == 0x1DA3 { return (true, to:[UnicodeScalar(0x0265)!]) }
    if value == 0x1DA4 { return (true, to:[UnicodeScalar(0x0268)!]) }
    if value == 0x1DA5 { return (true, to:[UnicodeScalar(0x0269)!]) }
    if value == 0x1DA6 { return (true, to:[UnicodeScalar(0x026A)!]) }
    if value == 0x1DA7 { return (true, to:[UnicodeScalar(0x1D7B)!]) }
    if value == 0x1DA8 { return (true, to:[UnicodeScalar(0x029D)!]) }
    if value == 0x1DA9 { return (true, to:[UnicodeScalar(0x026D)!]) }
    if value == 0x1DAA { return (true, to:[UnicodeScalar(0x1D85)!]) }
    if value == 0x1DAB { return (true, to:[UnicodeScalar(0x029F)!]) }
    if value == 0x1DAC { return (true, to:[UnicodeScalar(0x0271)!]) }
    if value == 0x1DAD { return (true, to:[UnicodeScalar(0x0270)!]) }
    if value == 0x1DAE { return (true, to:[UnicodeScalar(0x0272)!]) }
    if value == 0x1DAF { return (true, to:[UnicodeScalar(0x0273)!]) }
    if value == 0x1DB0 { return (true, to:[UnicodeScalar(0x0274)!]) }
    if value == 0x1DB1 { return (true, to:[UnicodeScalar(0x0275)!]) }
    if value == 0x1DB2 { return (true, to:[UnicodeScalar(0x0278)!]) }
    if value == 0x1DB3 { return (true, to:[UnicodeScalar(0x0282)!]) }
    if value == 0x1DB4 { return (true, to:[UnicodeScalar(0x0283)!]) }
    if value == 0x1DB5 { return (true, to:[UnicodeScalar(0x01AB)!]) }
    if value == 0x1DB6 { return (true, to:[UnicodeScalar(0x0289)!]) }
    if value == 0x1DB7 { return (true, to:[UnicodeScalar(0x028A)!]) }
    if value == 0x1DB8 { return (true, to:[UnicodeScalar(0x1D1C)!]) }
    if value == 0x1DB9 { return (true, to:[UnicodeScalar(0x028B)!]) }
    if value == 0x1DBA { return (true, to:[UnicodeScalar(0x028C)!]) }
    if value == 0x1DBB { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1DBC { return (true, to:[UnicodeScalar(0x0290)!]) }
    if value == 0x1DBD { return (true, to:[UnicodeScalar(0x0291)!]) }
    if value == 0x1DBE { return (true, to:[UnicodeScalar(0x0292)!]) }
    if value == 0x1DBF { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1E00 { return (true, to:[UnicodeScalar(0x1E01)!]) }
    if value == 0x1E02 { return (true, to:[UnicodeScalar(0x1E03)!]) }
    if value == 0x1E04 { return (true, to:[UnicodeScalar(0x1E05)!]) }
    if value == 0x1E06 { return (true, to:[UnicodeScalar(0x1E07)!]) }
    if value == 0x1E08 { return (true, to:[UnicodeScalar(0x1E09)!]) }
    if value == 0x1E0A { return (true, to:[UnicodeScalar(0x1E0B)!]) }
    if value == 0x1E0C { return (true, to:[UnicodeScalar(0x1E0D)!]) }
    if value == 0x1E0E { return (true, to:[UnicodeScalar(0x1E0F)!]) }
    if value == 0x1E10 { return (true, to:[UnicodeScalar(0x1E11)!]) }
    if value == 0x1E12 { return (true, to:[UnicodeScalar(0x1E13)!]) }
    if value == 0x1E14 { return (true, to:[UnicodeScalar(0x1E15)!]) }
    if value == 0x1E16 { return (true, to:[UnicodeScalar(0x1E17)!]) }
    if value == 0x1E18 { return (true, to:[UnicodeScalar(0x1E19)!]) }
    if value == 0x1E1A { return (true, to:[UnicodeScalar(0x1E1B)!]) }
    if value == 0x1E1C { return (true, to:[UnicodeScalar(0x1E1D)!]) }
    if value == 0x1E1E { return (true, to:[UnicodeScalar(0x1E1F)!]) }
    if value == 0x1E20 { return (true, to:[UnicodeScalar(0x1E21)!]) }
    if value == 0x1E22 { return (true, to:[UnicodeScalar(0x1E23)!]) }
    if value == 0x1E24 { return (true, to:[UnicodeScalar(0x1E25)!]) }
    if value == 0x1E26 { return (true, to:[UnicodeScalar(0x1E27)!]) }
    if value == 0x1E28 { return (true, to:[UnicodeScalar(0x1E29)!]) }
    if value == 0x1E2A { return (true, to:[UnicodeScalar(0x1E2B)!]) }
    if value == 0x1E2C { return (true, to:[UnicodeScalar(0x1E2D)!]) }
    if value == 0x1E2E { return (true, to:[UnicodeScalar(0x1E2F)!]) }
    if value == 0x1E30 { return (true, to:[UnicodeScalar(0x1E31)!]) }
    if value == 0x1E32 { return (true, to:[UnicodeScalar(0x1E33)!]) }
    if value == 0x1E34 { return (true, to:[UnicodeScalar(0x1E35)!]) }
    if value == 0x1E36 { return (true, to:[UnicodeScalar(0x1E37)!]) }
    if value == 0x1E38 { return (true, to:[UnicodeScalar(0x1E39)!]) }
    if value == 0x1E3A { return (true, to:[UnicodeScalar(0x1E3B)!]) }
    if value == 0x1E3C { return (true, to:[UnicodeScalar(0x1E3D)!]) }
    if value == 0x1E3E { return (true, to:[UnicodeScalar(0x1E3F)!]) }
    if value == 0x1E40 { return (true, to:[UnicodeScalar(0x1E41)!]) }
    if value == 0x1E42 { return (true, to:[UnicodeScalar(0x1E43)!]) }
    if value == 0x1E44 { return (true, to:[UnicodeScalar(0x1E45)!]) }
    if value == 0x1E46 { return (true, to:[UnicodeScalar(0x1E47)!]) }
    if value == 0x1E48 { return (true, to:[UnicodeScalar(0x1E49)!]) }
    if value == 0x1E4A { return (true, to:[UnicodeScalar(0x1E4B)!]) }
    if value == 0x1E4C { return (true, to:[UnicodeScalar(0x1E4D)!]) }
    if value == 0x1E4E { return (true, to:[UnicodeScalar(0x1E4F)!]) }
    if value == 0x1E50 { return (true, to:[UnicodeScalar(0x1E51)!]) }
    if value == 0x1E52 { return (true, to:[UnicodeScalar(0x1E53)!]) }
    if value == 0x1E54 { return (true, to:[UnicodeScalar(0x1E55)!]) }
    if value == 0x1E56 { return (true, to:[UnicodeScalar(0x1E57)!]) }
    if value == 0x1E58 { return (true, to:[UnicodeScalar(0x1E59)!]) }
    if value == 0x1E5A { return (true, to:[UnicodeScalar(0x1E5B)!]) }
    if value == 0x1E5C { return (true, to:[UnicodeScalar(0x1E5D)!]) }
    if value == 0x1E5E { return (true, to:[UnicodeScalar(0x1E5F)!]) }
    if value == 0x1E60 { return (true, to:[UnicodeScalar(0x1E61)!]) }
    if value == 0x1E62 { return (true, to:[UnicodeScalar(0x1E63)!]) }
    if value == 0x1E64 { return (true, to:[UnicodeScalar(0x1E65)!]) }
    if value == 0x1E66 { return (true, to:[UnicodeScalar(0x1E67)!]) }
    if value == 0x1E68 { return (true, to:[UnicodeScalar(0x1E69)!]) }
    if value == 0x1E6A { return (true, to:[UnicodeScalar(0x1E6B)!]) }
    if value == 0x1E6C { return (true, to:[UnicodeScalar(0x1E6D)!]) }
    if value == 0x1E6E { return (true, to:[UnicodeScalar(0x1E6F)!]) }
    if value == 0x1E70 { return (true, to:[UnicodeScalar(0x1E71)!]) }
    if value == 0x1E72 { return (true, to:[UnicodeScalar(0x1E73)!]) }
    if value == 0x1E74 { return (true, to:[UnicodeScalar(0x1E75)!]) }
    if value == 0x1E76 { return (true, to:[UnicodeScalar(0x1E77)!]) }
    if value == 0x1E78 { return (true, to:[UnicodeScalar(0x1E79)!]) }
    if value == 0x1E7A { return (true, to:[UnicodeScalar(0x1E7B)!]) }
    if value == 0x1E7C { return (true, to:[UnicodeScalar(0x1E7D)!]) }
    if value == 0x1E7E { return (true, to:[UnicodeScalar(0x1E7F)!]) }
    if value == 0x1E80 { return (true, to:[UnicodeScalar(0x1E81)!]) }
    if value == 0x1E82 { return (true, to:[UnicodeScalar(0x1E83)!]) }
    if value == 0x1E84 { return (true, to:[UnicodeScalar(0x1E85)!]) }
    if value == 0x1E86 { return (true, to:[UnicodeScalar(0x1E87)!]) }
    if value == 0x1E88 { return (true, to:[UnicodeScalar(0x1E89)!]) }
    if value == 0x1E8A { return (true, to:[UnicodeScalar(0x1E8B)!]) }
    if value == 0x1E8C { return (true, to:[UnicodeScalar(0x1E8D)!]) }
    if value == 0x1E8E { return (true, to:[UnicodeScalar(0x1E8F)!]) }
    if value == 0x1E90 { return (true, to:[UnicodeScalar(0x1E91)!]) }
    if value == 0x1E92 { return (true, to:[UnicodeScalar(0x1E93)!]) }
    if value == 0x1E94 { return (true, to:[UnicodeScalar(0x1E95)!]) }
    if value == 0x1E9A { return (true, to:[UnicodeScalar(0x0061)!, UnicodeScalar(0x02BE)!]) }
    if value == 0x1E9B { return (true, to:[UnicodeScalar(0x1E61)!]) }
    if value == 0x1E9E { return (true, to:[UnicodeScalar(0x0073)!, UnicodeScalar(0x0073)!]) }
    if value == 0x1EA0 { return (true, to:[UnicodeScalar(0x1EA1)!]) }
    if value == 0x1EA2 { return (true, to:[UnicodeScalar(0x1EA3)!]) }
    if value == 0x1EA4 { return (true, to:[UnicodeScalar(0x1EA5)!]) }
    if value == 0x1EA6 { return (true, to:[UnicodeScalar(0x1EA7)!]) }
    if value == 0x1EA8 { return (true, to:[UnicodeScalar(0x1EA9)!]) }
    if value == 0x1EAA { return (true, to:[UnicodeScalar(0x1EAB)!]) }
    if value == 0x1EAC { return (true, to:[UnicodeScalar(0x1EAD)!]) }
    if value == 0x1EAE { return (true, to:[UnicodeScalar(0x1EAF)!]) }
    if value == 0x1EB0 { return (true, to:[UnicodeScalar(0x1EB1)!]) }
    if value == 0x1EB2 { return (true, to:[UnicodeScalar(0x1EB3)!]) }
    if value == 0x1EB4 { return (true, to:[UnicodeScalar(0x1EB5)!]) }
    if value == 0x1EB6 { return (true, to:[UnicodeScalar(0x1EB7)!]) }
    if value == 0x1EB8 { return (true, to:[UnicodeScalar(0x1EB9)!]) }
    if value == 0x1EBA { return (true, to:[UnicodeScalar(0x1EBB)!]) }
    if value == 0x1EBC { return (true, to:[UnicodeScalar(0x1EBD)!]) }
    if value == 0x1EBE { return (true, to:[UnicodeScalar(0x1EBF)!]) }
    if value == 0x1EC0 { return (true, to:[UnicodeScalar(0x1EC1)!]) }
    if value == 0x1EC2 { return (true, to:[UnicodeScalar(0x1EC3)!]) }
    if value == 0x1EC4 { return (true, to:[UnicodeScalar(0x1EC5)!]) }
    if value == 0x1EC6 { return (true, to:[UnicodeScalar(0x1EC7)!]) }
    if value == 0x1EC8 { return (true, to:[UnicodeScalar(0x1EC9)!]) }
    if value == 0x1ECA { return (true, to:[UnicodeScalar(0x1ECB)!]) }
    if value == 0x1ECC { return (true, to:[UnicodeScalar(0x1ECD)!]) }
    if value == 0x1ECE { return (true, to:[UnicodeScalar(0x1ECF)!]) }
    if value == 0x1ED0 { return (true, to:[UnicodeScalar(0x1ED1)!]) }
    if value == 0x1ED2 { return (true, to:[UnicodeScalar(0x1ED3)!]) }
    if value == 0x1ED4 { return (true, to:[UnicodeScalar(0x1ED5)!]) }
    if value == 0x1ED6 { return (true, to:[UnicodeScalar(0x1ED7)!]) }
    if value == 0x1ED8 { return (true, to:[UnicodeScalar(0x1ED9)!]) }
    if value == 0x1EDA { return (true, to:[UnicodeScalar(0x1EDB)!]) }
    if value == 0x1EDC { return (true, to:[UnicodeScalar(0x1EDD)!]) }
    if value == 0x1EDE { return (true, to:[UnicodeScalar(0x1EDF)!]) }
    if value == 0x1EE0 { return (true, to:[UnicodeScalar(0x1EE1)!]) }
    if value == 0x1EE2 { return (true, to:[UnicodeScalar(0x1EE3)!]) }
    if value == 0x1EE4 { return (true, to:[UnicodeScalar(0x1EE5)!]) }
    if value == 0x1EE6 { return (true, to:[UnicodeScalar(0x1EE7)!]) }
    if value == 0x1EE8 { return (true, to:[UnicodeScalar(0x1EE9)!]) }
    if value == 0x1EEA { return (true, to:[UnicodeScalar(0x1EEB)!]) }
    if value == 0x1EEC { return (true, to:[UnicodeScalar(0x1EED)!]) }
    if value == 0x1EEE { return (true, to:[UnicodeScalar(0x1EEF)!]) }
    if value == 0x1EF0 { return (true, to:[UnicodeScalar(0x1EF1)!]) }
    if value == 0x1EF2 { return (true, to:[UnicodeScalar(0x1EF3)!]) }
    if value == 0x1EF4 { return (true, to:[UnicodeScalar(0x1EF5)!]) }
    if value == 0x1EF6 { return (true, to:[UnicodeScalar(0x1EF7)!]) }
    if value == 0x1EF8 { return (true, to:[UnicodeScalar(0x1EF9)!]) }
    if value == 0x1EFA { return (true, to:[UnicodeScalar(0x1EFB)!]) }
    if value == 0x1EFC { return (true, to:[UnicodeScalar(0x1EFD)!]) }
    if value == 0x1EFE { return (true, to:[UnicodeScalar(0x1EFF)!]) }
    if value == 0x1F08 { return (true, to:[UnicodeScalar(0x1F00)!]) }
    if value == 0x1F09 { return (true, to:[UnicodeScalar(0x1F01)!]) }
    if value == 0x1F0A { return (true, to:[UnicodeScalar(0x1F02)!]) }
    if value == 0x1F0B { return (true, to:[UnicodeScalar(0x1F03)!]) }
    if value == 0x1F0C { return (true, to:[UnicodeScalar(0x1F04)!]) }
    if value == 0x1F0D { return (true, to:[UnicodeScalar(0x1F05)!]) }
    if value == 0x1F0E { return (true, to:[UnicodeScalar(0x1F06)!]) }
    if value == 0x1F0F { return (true, to:[UnicodeScalar(0x1F07)!]) }
    if value == 0x1F18 { return (true, to:[UnicodeScalar(0x1F10)!]) }
    if value == 0x1F19 { return (true, to:[UnicodeScalar(0x1F11)!]) }
    if value == 0x1F1A { return (true, to:[UnicodeScalar(0x1F12)!]) }
    if value == 0x1F1B { return (true, to:[UnicodeScalar(0x1F13)!]) }
    if value == 0x1F1C { return (true, to:[UnicodeScalar(0x1F14)!]) }
    if value == 0x1F1D { return (true, to:[UnicodeScalar(0x1F15)!]) }
    if value == 0x1F28 { return (true, to:[UnicodeScalar(0x1F20)!]) }
    if value == 0x1F29 { return (true, to:[UnicodeScalar(0x1F21)!]) }
    if value == 0x1F2A { return (true, to:[UnicodeScalar(0x1F22)!]) }
    if value == 0x1F2B { return (true, to:[UnicodeScalar(0x1F23)!]) }
    if value == 0x1F2C { return (true, to:[UnicodeScalar(0x1F24)!]) }
    if value == 0x1F2D { return (true, to:[UnicodeScalar(0x1F25)!]) }
    if value == 0x1F2E { return (true, to:[UnicodeScalar(0x1F26)!]) }
    if value == 0x1F2F { return (true, to:[UnicodeScalar(0x1F27)!]) }
    if value == 0x1F38 { return (true, to:[UnicodeScalar(0x1F30)!]) }
    if value == 0x1F39 { return (true, to:[UnicodeScalar(0x1F31)!]) }
    if value == 0x1F3A { return (true, to:[UnicodeScalar(0x1F32)!]) }
    if value == 0x1F3B { return (true, to:[UnicodeScalar(0x1F33)!]) }
    if value == 0x1F3C { return (true, to:[UnicodeScalar(0x1F34)!]) }
    if value == 0x1F3D { return (true, to:[UnicodeScalar(0x1F35)!]) }
    if value == 0x1F3E { return (true, to:[UnicodeScalar(0x1F36)!]) }
    if value == 0x1F3F { return (true, to:[UnicodeScalar(0x1F37)!]) }
    if value == 0x1F48 { return (true, to:[UnicodeScalar(0x1F40)!]) }
    if value == 0x1F49 { return (true, to:[UnicodeScalar(0x1F41)!]) }
    if value == 0x1F4A { return (true, to:[UnicodeScalar(0x1F42)!]) }
    if value == 0x1F4B { return (true, to:[UnicodeScalar(0x1F43)!]) }
    if value == 0x1F4C { return (true, to:[UnicodeScalar(0x1F44)!]) }
    if value == 0x1F4D { return (true, to:[UnicodeScalar(0x1F45)!]) }
    if value == 0x1F59 { return (true, to:[UnicodeScalar(0x1F51)!]) }
    if value == 0x1F5B { return (true, to:[UnicodeScalar(0x1F53)!]) }
    if value == 0x1F5D { return (true, to:[UnicodeScalar(0x1F55)!]) }
    if value == 0x1F5F { return (true, to:[UnicodeScalar(0x1F57)!]) }
    if value == 0x1F68 { return (true, to:[UnicodeScalar(0x1F60)!]) }
    if value == 0x1F69 { return (true, to:[UnicodeScalar(0x1F61)!]) }
    if value == 0x1F6A { return (true, to:[UnicodeScalar(0x1F62)!]) }
    if value == 0x1F6B { return (true, to:[UnicodeScalar(0x1F63)!]) }
    if value == 0x1F6C { return (true, to:[UnicodeScalar(0x1F64)!]) }
    if value == 0x1F6D { return (true, to:[UnicodeScalar(0x1F65)!]) }
    if value == 0x1F6E { return (true, to:[UnicodeScalar(0x1F66)!]) }
    if value == 0x1F6F { return (true, to:[UnicodeScalar(0x1F67)!]) }
    if value == 0x1F71 { return (true, to:[UnicodeScalar(0x03AC)!]) }
    if value == 0x1F73 { return (true, to:[UnicodeScalar(0x03AD)!]) }
    if value == 0x1F75 { return (true, to:[UnicodeScalar(0x03AE)!]) }
    if value == 0x1F77 { return (true, to:[UnicodeScalar(0x03AF)!]) }
    if value == 0x1F79 { return (true, to:[UnicodeScalar(0x03CC)!]) }
    if value == 0x1F7B { return (true, to:[UnicodeScalar(0x03CD)!]) }
    if value == 0x1F7D { return (true, to:[UnicodeScalar(0x03CE)!]) }
    if value == 0x1F80 { return (true, to:[UnicodeScalar(0x1F00)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F81 { return (true, to:[UnicodeScalar(0x1F01)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F82 { return (true, to:[UnicodeScalar(0x1F02)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F83 { return (true, to:[UnicodeScalar(0x1F03)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F84 { return (true, to:[UnicodeScalar(0x1F04)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F85 { return (true, to:[UnicodeScalar(0x1F05)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F86 { return (true, to:[UnicodeScalar(0x1F06)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F87 { return (true, to:[UnicodeScalar(0x1F07)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F88 { return (true, to:[UnicodeScalar(0x1F00)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F89 { return (true, to:[UnicodeScalar(0x1F01)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F8A { return (true, to:[UnicodeScalar(0x1F02)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F8B { return (true, to:[UnicodeScalar(0x1F03)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F8C { return (true, to:[UnicodeScalar(0x1F04)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F8D { return (true, to:[UnicodeScalar(0x1F05)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F8E { return (true, to:[UnicodeScalar(0x1F06)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F8F { return (true, to:[UnicodeScalar(0x1F07)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F90 { return (true, to:[UnicodeScalar(0x1F20)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F91 { return (true, to:[UnicodeScalar(0x1F21)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F92 { return (true, to:[UnicodeScalar(0x1F22)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F93 { return (true, to:[UnicodeScalar(0x1F23)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F94 { return (true, to:[UnicodeScalar(0x1F24)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F95 { return (true, to:[UnicodeScalar(0x1F25)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F96 { return (true, to:[UnicodeScalar(0x1F26)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F97 { return (true, to:[UnicodeScalar(0x1F27)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F98 { return (true, to:[UnicodeScalar(0x1F20)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F99 { return (true, to:[UnicodeScalar(0x1F21)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F9A { return (true, to:[UnicodeScalar(0x1F22)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F9B { return (true, to:[UnicodeScalar(0x1F23)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F9C { return (true, to:[UnicodeScalar(0x1F24)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F9D { return (true, to:[UnicodeScalar(0x1F25)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F9E { return (true, to:[UnicodeScalar(0x1F26)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1F9F { return (true, to:[UnicodeScalar(0x1F27)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FA0 { return (true, to:[UnicodeScalar(0x1F60)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FA1 { return (true, to:[UnicodeScalar(0x1F61)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FA2 { return (true, to:[UnicodeScalar(0x1F62)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FA3 { return (true, to:[UnicodeScalar(0x1F63)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FA4 { return (true, to:[UnicodeScalar(0x1F64)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FA5 { return (true, to:[UnicodeScalar(0x1F65)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FA6 { return (true, to:[UnicodeScalar(0x1F66)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FA7 { return (true, to:[UnicodeScalar(0x1F67)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FA8 { return (true, to:[UnicodeScalar(0x1F60)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FA9 { return (true, to:[UnicodeScalar(0x1F61)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FAA { return (true, to:[UnicodeScalar(0x1F62)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FAB { return (true, to:[UnicodeScalar(0x1F63)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FAC { return (true, to:[UnicodeScalar(0x1F64)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FAD { return (true, to:[UnicodeScalar(0x1F65)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FAE { return (true, to:[UnicodeScalar(0x1F66)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FAF { return (true, to:[UnicodeScalar(0x1F67)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FB2 { return (true, to:[UnicodeScalar(0x1F70)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FB3 { return (true, to:[UnicodeScalar(0x03B1)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FB4 { return (true, to:[UnicodeScalar(0x03AC)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FB7 { return (true, to:[UnicodeScalar(0x1FB6)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FB8 { return (true, to:[UnicodeScalar(0x1FB0)!]) }
    if value == 0x1FB9 { return (true, to:[UnicodeScalar(0x1FB1)!]) }
    if value == 0x1FBA { return (true, to:[UnicodeScalar(0x1F70)!]) }
    if value == 0x1FBB { return (true, to:[UnicodeScalar(0x03AC)!]) }
    if value == 0x1FBC { return (true, to:[UnicodeScalar(0x03B1)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FBE { return (true, to:[UnicodeScalar(0x03B9)!]) }
    if value == 0x1FC2 { return (true, to:[UnicodeScalar(0x1F74)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FC3 { return (true, to:[UnicodeScalar(0x03B7)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FC4 { return (true, to:[UnicodeScalar(0x03AE)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FC7 { return (true, to:[UnicodeScalar(0x1FC6)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FC8 { return (true, to:[UnicodeScalar(0x1F72)!]) }
    if value == 0x1FC9 { return (true, to:[UnicodeScalar(0x03AD)!]) }
    if value == 0x1FCA { return (true, to:[UnicodeScalar(0x1F74)!]) }
    if value == 0x1FCB { return (true, to:[UnicodeScalar(0x03AE)!]) }
    if value == 0x1FCC { return (true, to:[UnicodeScalar(0x03B7)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FD3 { return (true, to:[UnicodeScalar(0x0390)!]) }
    if value == 0x1FD8 { return (true, to:[UnicodeScalar(0x1FD0)!]) }
    if value == 0x1FD9 { return (true, to:[UnicodeScalar(0x1FD1)!]) }
    if value == 0x1FDA { return (true, to:[UnicodeScalar(0x1F76)!]) }
    if value == 0x1FDB { return (true, to:[UnicodeScalar(0x03AF)!]) }
    if value == 0x1FE3 { return (true, to:[UnicodeScalar(0x03B0)!]) }
    if value == 0x1FE8 { return (true, to:[UnicodeScalar(0x1FE0)!]) }
    if value == 0x1FE9 { return (true, to:[UnicodeScalar(0x1FE1)!]) }
    if value == 0x1FEA { return (true, to:[UnicodeScalar(0x1F7A)!]) }
    if value == 0x1FEB { return (true, to:[UnicodeScalar(0x03CD)!]) }
    if value == 0x1FEC { return (true, to:[UnicodeScalar(0x1FE5)!]) }
    if value == 0x1FF2 { return (true, to:[UnicodeScalar(0x1F7C)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FF3 { return (true, to:[UnicodeScalar(0x03C9)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FF4 { return (true, to:[UnicodeScalar(0x03CE)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FF7 { return (true, to:[UnicodeScalar(0x1FF6)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x1FF8 { return (true, to:[UnicodeScalar(0x1F78)!]) }
    if value == 0x1FF9 { return (true, to:[UnicodeScalar(0x03CC)!]) }
    if value == 0x1FFA { return (true, to:[UnicodeScalar(0x1F7C)!]) }
    if value == 0x1FFB { return (true, to:[UnicodeScalar(0x03CE)!]) }
    if value == 0x1FFC { return (true, to:[UnicodeScalar(0x03C9)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x2011 { return (true, to:[UnicodeScalar(0x2010)!]) }
    if value == 0x2033 { return (true, to:[UnicodeScalar(0x2032)!, UnicodeScalar(0x2032)!]) }
    if value == 0x2034 { return (true, to:[UnicodeScalar(0x2032)!, UnicodeScalar(0x2032)!, UnicodeScalar(0x2032)!]) }
    if value == 0x2036 { return (true, to:[UnicodeScalar(0x2035)!, UnicodeScalar(0x2035)!]) }
    if value == 0x2037 { return (true, to:[UnicodeScalar(0x2035)!, UnicodeScalar(0x2035)!, UnicodeScalar(0x2035)!]) }
    if value == 0x2057 { return (true, to:[UnicodeScalar(0x2032)!, UnicodeScalar(0x2032)!, UnicodeScalar(0x2032)!, UnicodeScalar(0x2032)!]) }
    if value == 0x2070 { return (true, to:[UnicodeScalar(0x0030)!]) }
    if value == 0x2071 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x2074 { return (true, to:[UnicodeScalar(0x0034)!]) }
    if value == 0x2075 { return (true, to:[UnicodeScalar(0x0035)!]) }
    if value == 0x2076 { return (true, to:[UnicodeScalar(0x0036)!]) }
    if value == 0x2077 { return (true, to:[UnicodeScalar(0x0037)!]) }
    if value == 0x2078 { return (true, to:[UnicodeScalar(0x0038)!]) }
    if value == 0x2079 { return (true, to:[UnicodeScalar(0x0039)!]) }
    if value == 0x207B { return (true, to:[UnicodeScalar(0x2212)!]) }
    if value == 0x207F { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x2080 { return (true, to:[UnicodeScalar(0x0030)!]) }
    if value == 0x2081 { return (true, to:[UnicodeScalar(0x0031)!]) }
    if value == 0x2082 { return (true, to:[UnicodeScalar(0x0032)!]) }
    if value == 0x2083 { return (true, to:[UnicodeScalar(0x0033)!]) }
    if value == 0x2084 { return (true, to:[UnicodeScalar(0x0034)!]) }
    if value == 0x2085 { return (true, to:[UnicodeScalar(0x0035)!]) }
    if value == 0x2086 { return (true, to:[UnicodeScalar(0x0036)!]) }
    if value == 0x2087 { return (true, to:[UnicodeScalar(0x0037)!]) }
    if value == 0x2088 { return (true, to:[UnicodeScalar(0x0038)!]) }
    if value == 0x2089 { return (true, to:[UnicodeScalar(0x0039)!]) }
    if value == 0x208B { return (true, to:[UnicodeScalar(0x2212)!]) }
    if value == 0x2090 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x2091 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x2092 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x2093 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x2094 { return (true, to:[UnicodeScalar(0x0259)!]) }
    if value == 0x2095 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x2096 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x2097 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x2098 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x2099 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x209A { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x209B { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x209C { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x20A8 { return (true, to:[UnicodeScalar(0x0072)!, UnicodeScalar(0x0073)!]) }
    if value == 0x2102 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x2103 { return (true, to:[UnicodeScalar(0x00B0)!, UnicodeScalar(0x0063)!]) }
    if value == 0x2107 { return (true, to:[UnicodeScalar(0x025B)!]) }
    if value == 0x2109 { return (true, to:[UnicodeScalar(0x00B0)!, UnicodeScalar(0x0066)!]) }
    if value == 0x210A { return (true, to:[UnicodeScalar(0x0067)!]) }
    if (0x210B <= value && value <= 0x210E) { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x210F { return (true, to:[UnicodeScalar(0x0127)!]) }
    if (0x2110 <= value && value <= 0x2111) { return (true, to:[UnicodeScalar(0x0069)!]) }
    if (0x2112 <= value && value <= 0x2113) { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x2115 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x2116 { return (true, to:[UnicodeScalar(0x006E)!, UnicodeScalar(0x006F)!]) }
    if value == 0x2119 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x211A { return (true, to:[UnicodeScalar(0x0071)!]) }
    if (0x211B <= value && value <= 0x211D) { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x2120 { return (true, to:[UnicodeScalar(0x0073)!, UnicodeScalar(0x006D)!]) }
    if value == 0x2121 { return (true, to:[UnicodeScalar(0x0074)!, UnicodeScalar(0x0065)!, UnicodeScalar(0x006C)!]) }
    if value == 0x2122 { return (true, to:[UnicodeScalar(0x0074)!, UnicodeScalar(0x006D)!]) }
    if value == 0x2124 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x2126 { return (true, to:[UnicodeScalar(0x03C9)!]) }
    if value == 0x2128 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x212A { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x212B { return (true, to:[UnicodeScalar(0x00E5)!]) }
    if value == 0x212C { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x212D { return (true, to:[UnicodeScalar(0x0063)!]) }
    if (0x212F <= value && value <= 0x2130) { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x2131 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x2133 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x2134 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x2135 { return (true, to:[UnicodeScalar(0x05D0)!]) }
    if value == 0x2136 { return (true, to:[UnicodeScalar(0x05D1)!]) }
    if value == 0x2137 { return (true, to:[UnicodeScalar(0x05D2)!]) }
    if value == 0x2138 { return (true, to:[UnicodeScalar(0x05D3)!]) }
    if value == 0x2139 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x213B { return (true, to:[UnicodeScalar(0x0066)!, UnicodeScalar(0x0061)!, UnicodeScalar(0x0078)!]) }
    if value == 0x213C { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if (0x213D <= value && value <= 0x213E) { return (true, to:[UnicodeScalar(0x03B3)!]) }
    if value == 0x213F { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x2140 { return (true, to:[UnicodeScalar(0x2211)!]) }
    if (0x2145 <= value && value <= 0x2146) { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x2147 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x2148 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x2149 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x2150 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0037)!]) }
    if value == 0x2151 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0039)!]) }
    if value == 0x2152 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x0030)!]) }
    if value == 0x2153 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0033)!]) }
    if value == 0x2154 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0033)!]) }
    if value == 0x2155 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0035)!]) }
    if value == 0x2156 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0035)!]) }
    if value == 0x2157 { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0035)!]) }
    if value == 0x2158 { return (true, to:[UnicodeScalar(0x0034)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0035)!]) }
    if value == 0x2159 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0036)!]) }
    if value == 0x215A { return (true, to:[UnicodeScalar(0x0035)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0036)!]) }
    if value == 0x215B { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0038)!]) }
    if value == 0x215C { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0038)!]) }
    if value == 0x215D { return (true, to:[UnicodeScalar(0x0035)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0038)!]) }
    if value == 0x215E { return (true, to:[UnicodeScalar(0x0037)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0038)!]) }
    if value == 0x215F { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x2044)!]) }
    if value == 0x2160 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x2161 { return (true, to:[UnicodeScalar(0x0069)!, UnicodeScalar(0x0069)!]) }
    if value == 0x2162 { return (true, to:[UnicodeScalar(0x0069)!, UnicodeScalar(0x0069)!, UnicodeScalar(0x0069)!]) }
    if value == 0x2163 { return (true, to:[UnicodeScalar(0x0069)!, UnicodeScalar(0x0076)!]) }
    if value == 0x2164 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x2165 { return (true, to:[UnicodeScalar(0x0076)!, UnicodeScalar(0x0069)!]) }
    if value == 0x2166 { return (true, to:[UnicodeScalar(0x0076)!, UnicodeScalar(0x0069)!, UnicodeScalar(0x0069)!]) }
    if value == 0x2167 { return (true, to:[UnicodeScalar(0x0076)!, UnicodeScalar(0x0069)!, UnicodeScalar(0x0069)!, UnicodeScalar(0x0069)!]) }
    if value == 0x2168 { return (true, to:[UnicodeScalar(0x0069)!, UnicodeScalar(0x0078)!]) }
    if value == 0x2169 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x216A { return (true, to:[UnicodeScalar(0x0078)!, UnicodeScalar(0x0069)!]) }
    if value == 0x216B { return (true, to:[UnicodeScalar(0x0078)!, UnicodeScalar(0x0069)!, UnicodeScalar(0x0069)!]) }
    if value == 0x216C { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x216D { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x216E { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x216F { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x2170 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x2171 { return (true, to:[UnicodeScalar(0x0069)!, UnicodeScalar(0x0069)!]) }
    if value == 0x2172 { return (true, to:[UnicodeScalar(0x0069)!, UnicodeScalar(0x0069)!, UnicodeScalar(0x0069)!]) }
    if value == 0x2173 { return (true, to:[UnicodeScalar(0x0069)!, UnicodeScalar(0x0076)!]) }
    if value == 0x2174 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x2175 { return (true, to:[UnicodeScalar(0x0076)!, UnicodeScalar(0x0069)!]) }
    if value == 0x2176 { return (true, to:[UnicodeScalar(0x0076)!, UnicodeScalar(0x0069)!, UnicodeScalar(0x0069)!]) }
    if value == 0x2177 { return (true, to:[UnicodeScalar(0x0076)!, UnicodeScalar(0x0069)!, UnicodeScalar(0x0069)!, UnicodeScalar(0x0069)!]) }
    if value == 0x2178 { return (true, to:[UnicodeScalar(0x0069)!, UnicodeScalar(0x0078)!]) }
    if value == 0x2179 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x217A { return (true, to:[UnicodeScalar(0x0078)!, UnicodeScalar(0x0069)!]) }
    if value == 0x217B { return (true, to:[UnicodeScalar(0x0078)!, UnicodeScalar(0x0069)!, UnicodeScalar(0x0069)!]) }
    if value == 0x217C { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x217D { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x217E { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x217F { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x2189 { return (true, to:[UnicodeScalar(0x0030)!, UnicodeScalar(0x2044)!, UnicodeScalar(0x0033)!]) }
    if value == 0x222C { return (true, to:[UnicodeScalar(0x222B)!, UnicodeScalar(0x222B)!]) }
    if value == 0x222D { return (true, to:[UnicodeScalar(0x222B)!, UnicodeScalar(0x222B)!, UnicodeScalar(0x222B)!]) }
    if value == 0x222F { return (true, to:[UnicodeScalar(0x222E)!, UnicodeScalar(0x222E)!]) }
    if value == 0x2230 { return (true, to:[UnicodeScalar(0x222E)!, UnicodeScalar(0x222E)!, UnicodeScalar(0x222E)!]) }
    if value == 0x2329 { return (true, to:[UnicodeScalar(0x3008)!]) }
    if value == 0x232A { return (true, to:[UnicodeScalar(0x3009)!]) }
    if value == 0x2460 { return (true, to:[UnicodeScalar(0x0031)!]) }
    if value == 0x2461 { return (true, to:[UnicodeScalar(0x0032)!]) }
    if value == 0x2462 { return (true, to:[UnicodeScalar(0x0033)!]) }
    if value == 0x2463 { return (true, to:[UnicodeScalar(0x0034)!]) }
    if value == 0x2464 { return (true, to:[UnicodeScalar(0x0035)!]) }
    if value == 0x2465 { return (true, to:[UnicodeScalar(0x0036)!]) }
    if value == 0x2466 { return (true, to:[UnicodeScalar(0x0037)!]) }
    if value == 0x2467 { return (true, to:[UnicodeScalar(0x0038)!]) }
    if value == 0x2468 { return (true, to:[UnicodeScalar(0x0039)!]) }
    if value == 0x2469 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0030)!]) }
    if value == 0x246A { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0031)!]) }
    if value == 0x246B { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0032)!]) }
    if value == 0x246C { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0033)!]) }
    if value == 0x246D { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0034)!]) }
    if value == 0x246E { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0035)!]) }
    if value == 0x246F { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0036)!]) }
    if value == 0x2470 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0037)!]) }
    if value == 0x2471 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0038)!]) }
    if value == 0x2472 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0039)!]) }
    if value == 0x2473 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0030)!]) }
    if value == 0x24B6 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x24B7 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x24B8 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x24B9 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x24BA { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x24BB { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x24BC { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x24BD { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x24BE { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x24BF { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x24C0 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x24C1 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x24C2 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x24C3 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x24C4 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x24C5 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x24C6 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x24C7 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x24C8 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x24C9 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x24CA { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x24CB { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x24CC { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x24CD { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x24CE { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x24CF { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x24D0 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x24D1 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x24D2 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x24D3 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x24D4 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x24D5 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x24D6 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x24D7 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x24D8 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x24D9 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x24DA { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x24DB { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x24DC { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x24DD { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x24DE { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x24DF { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x24E0 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x24E1 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x24E2 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x24E3 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x24E4 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x24E5 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x24E6 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x24E7 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x24E8 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x24E9 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x24EA { return (true, to:[UnicodeScalar(0x0030)!]) }
    if value == 0x2A0C { return (true, to:[UnicodeScalar(0x222B)!, UnicodeScalar(0x222B)!, UnicodeScalar(0x222B)!, UnicodeScalar(0x222B)!]) }
    if value == 0x2ADC { return (true, to:[UnicodeScalar(0x2ADD)!, UnicodeScalar(0x0338)!]) }
    if value == 0x2C00 { return (true, to:[UnicodeScalar(0x2C30)!]) }
    if value == 0x2C01 { return (true, to:[UnicodeScalar(0x2C31)!]) }
    if value == 0x2C02 { return (true, to:[UnicodeScalar(0x2C32)!]) }
    if value == 0x2C03 { return (true, to:[UnicodeScalar(0x2C33)!]) }
    if value == 0x2C04 { return (true, to:[UnicodeScalar(0x2C34)!]) }
    if value == 0x2C05 { return (true, to:[UnicodeScalar(0x2C35)!]) }
    if value == 0x2C06 { return (true, to:[UnicodeScalar(0x2C36)!]) }
    if value == 0x2C07 { return (true, to:[UnicodeScalar(0x2C37)!]) }
    if value == 0x2C08 { return (true, to:[UnicodeScalar(0x2C38)!]) }
    if value == 0x2C09 { return (true, to:[UnicodeScalar(0x2C39)!]) }
    if value == 0x2C0A { return (true, to:[UnicodeScalar(0x2C3A)!]) }
    if value == 0x2C0B { return (true, to:[UnicodeScalar(0x2C3B)!]) }
    if value == 0x2C0C { return (true, to:[UnicodeScalar(0x2C3C)!]) }
    if value == 0x2C0D { return (true, to:[UnicodeScalar(0x2C3D)!]) }
    if value == 0x2C0E { return (true, to:[UnicodeScalar(0x2C3E)!]) }
    if value == 0x2C0F { return (true, to:[UnicodeScalar(0x2C3F)!]) }
    if value == 0x2C10 { return (true, to:[UnicodeScalar(0x2C40)!]) }
    if value == 0x2C11 { return (true, to:[UnicodeScalar(0x2C41)!]) }
    if value == 0x2C12 { return (true, to:[UnicodeScalar(0x2C42)!]) }
    if value == 0x2C13 { return (true, to:[UnicodeScalar(0x2C43)!]) }
    if value == 0x2C14 { return (true, to:[UnicodeScalar(0x2C44)!]) }
    if value == 0x2C15 { return (true, to:[UnicodeScalar(0x2C45)!]) }
    if value == 0x2C16 { return (true, to:[UnicodeScalar(0x2C46)!]) }
    if value == 0x2C17 { return (true, to:[UnicodeScalar(0x2C47)!]) }
    if value == 0x2C18 { return (true, to:[UnicodeScalar(0x2C48)!]) }
    if value == 0x2C19 { return (true, to:[UnicodeScalar(0x2C49)!]) }
    if value == 0x2C1A { return (true, to:[UnicodeScalar(0x2C4A)!]) }
    if value == 0x2C1B { return (true, to:[UnicodeScalar(0x2C4B)!]) }
    if value == 0x2C1C { return (true, to:[UnicodeScalar(0x2C4C)!]) }
    if value == 0x2C1D { return (true, to:[UnicodeScalar(0x2C4D)!]) }
    if value == 0x2C1E { return (true, to:[UnicodeScalar(0x2C4E)!]) }
    if value == 0x2C1F { return (true, to:[UnicodeScalar(0x2C4F)!]) }
    if value == 0x2C20 { return (true, to:[UnicodeScalar(0x2C50)!]) }
    if value == 0x2C21 { return (true, to:[UnicodeScalar(0x2C51)!]) }
    if value == 0x2C22 { return (true, to:[UnicodeScalar(0x2C52)!]) }
    if value == 0x2C23 { return (true, to:[UnicodeScalar(0x2C53)!]) }
    if value == 0x2C24 { return (true, to:[UnicodeScalar(0x2C54)!]) }
    if value == 0x2C25 { return (true, to:[UnicodeScalar(0x2C55)!]) }
    if value == 0x2C26 { return (true, to:[UnicodeScalar(0x2C56)!]) }
    if value == 0x2C27 { return (true, to:[UnicodeScalar(0x2C57)!]) }
    if value == 0x2C28 { return (true, to:[UnicodeScalar(0x2C58)!]) }
    if value == 0x2C29 { return (true, to:[UnicodeScalar(0x2C59)!]) }
    if value == 0x2C2A { return (true, to:[UnicodeScalar(0x2C5A)!]) }
    if value == 0x2C2B { return (true, to:[UnicodeScalar(0x2C5B)!]) }
    if value == 0x2C2C { return (true, to:[UnicodeScalar(0x2C5C)!]) }
    if value == 0x2C2D { return (true, to:[UnicodeScalar(0x2C5D)!]) }
    if value == 0x2C2E { return (true, to:[UnicodeScalar(0x2C5E)!]) }
    if value == 0x2C60 { return (true, to:[UnicodeScalar(0x2C61)!]) }
    if value == 0x2C62 { return (true, to:[UnicodeScalar(0x026B)!]) }
    if value == 0x2C63 { return (true, to:[UnicodeScalar(0x1D7D)!]) }
    if value == 0x2C64 { return (true, to:[UnicodeScalar(0x027D)!]) }
    if value == 0x2C67 { return (true, to:[UnicodeScalar(0x2C68)!]) }
    if value == 0x2C69 { return (true, to:[UnicodeScalar(0x2C6A)!]) }
    if value == 0x2C6B { return (true, to:[UnicodeScalar(0x2C6C)!]) }
    if value == 0x2C6D { return (true, to:[UnicodeScalar(0x0251)!]) }
    if value == 0x2C6E { return (true, to:[UnicodeScalar(0x0271)!]) }
    if value == 0x2C6F { return (true, to:[UnicodeScalar(0x0250)!]) }
    if value == 0x2C70 { return (true, to:[UnicodeScalar(0x0252)!]) }
    if value == 0x2C72 { return (true, to:[UnicodeScalar(0x2C73)!]) }
    if value == 0x2C75 { return (true, to:[UnicodeScalar(0x2C76)!]) }
    if value == 0x2C7C { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x2C7D { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x2C7E { return (true, to:[UnicodeScalar(0x023F)!]) }
    if value == 0x2C7F { return (true, to:[UnicodeScalar(0x0240)!]) }
    if value == 0x2C80 { return (true, to:[UnicodeScalar(0x2C81)!]) }
    if value == 0x2C82 { return (true, to:[UnicodeScalar(0x2C83)!]) }
    if value == 0x2C84 { return (true, to:[UnicodeScalar(0x2C85)!]) }
    if value == 0x2C86 { return (true, to:[UnicodeScalar(0x2C87)!]) }
    if value == 0x2C88 { return (true, to:[UnicodeScalar(0x2C89)!]) }
    if value == 0x2C8A { return (true, to:[UnicodeScalar(0x2C8B)!]) }
    if value == 0x2C8C { return (true, to:[UnicodeScalar(0x2C8D)!]) }
    if value == 0x2C8E { return (true, to:[UnicodeScalar(0x2C8F)!]) }
    if value == 0x2C90 { return (true, to:[UnicodeScalar(0x2C91)!]) }
    if value == 0x2C92 { return (true, to:[UnicodeScalar(0x2C93)!]) }
    if value == 0x2C94 { return (true, to:[UnicodeScalar(0x2C95)!]) }
    if value == 0x2C96 { return (true, to:[UnicodeScalar(0x2C97)!]) }
    if value == 0x2C98 { return (true, to:[UnicodeScalar(0x2C99)!]) }
    if value == 0x2C9A { return (true, to:[UnicodeScalar(0x2C9B)!]) }
    if value == 0x2C9C { return (true, to:[UnicodeScalar(0x2C9D)!]) }
    if value == 0x2C9E { return (true, to:[UnicodeScalar(0x2C9F)!]) }
    if value == 0x2CA0 { return (true, to:[UnicodeScalar(0x2CA1)!]) }
    if value == 0x2CA2 { return (true, to:[UnicodeScalar(0x2CA3)!]) }
    if value == 0x2CA4 { return (true, to:[UnicodeScalar(0x2CA5)!]) }
    if value == 0x2CA6 { return (true, to:[UnicodeScalar(0x2CA7)!]) }
    if value == 0x2CA8 { return (true, to:[UnicodeScalar(0x2CA9)!]) }
    if value == 0x2CAA { return (true, to:[UnicodeScalar(0x2CAB)!]) }
    if value == 0x2CAC { return (true, to:[UnicodeScalar(0x2CAD)!]) }
    if value == 0x2CAE { return (true, to:[UnicodeScalar(0x2CAF)!]) }
    if value == 0x2CB0 { return (true, to:[UnicodeScalar(0x2CB1)!]) }
    if value == 0x2CB2 { return (true, to:[UnicodeScalar(0x2CB3)!]) }
    if value == 0x2CB4 { return (true, to:[UnicodeScalar(0x2CB5)!]) }
    if value == 0x2CB6 { return (true, to:[UnicodeScalar(0x2CB7)!]) }
    if value == 0x2CB8 { return (true, to:[UnicodeScalar(0x2CB9)!]) }
    if value == 0x2CBA { return (true, to:[UnicodeScalar(0x2CBB)!]) }
    if value == 0x2CBC { return (true, to:[UnicodeScalar(0x2CBD)!]) }
    if value == 0x2CBE { return (true, to:[UnicodeScalar(0x2CBF)!]) }
    if value == 0x2CC0 { return (true, to:[UnicodeScalar(0x2CC1)!]) }
    if value == 0x2CC2 { return (true, to:[UnicodeScalar(0x2CC3)!]) }
    if value == 0x2CC4 { return (true, to:[UnicodeScalar(0x2CC5)!]) }
    if value == 0x2CC6 { return (true, to:[UnicodeScalar(0x2CC7)!]) }
    if value == 0x2CC8 { return (true, to:[UnicodeScalar(0x2CC9)!]) }
    if value == 0x2CCA { return (true, to:[UnicodeScalar(0x2CCB)!]) }
    if value == 0x2CCC { return (true, to:[UnicodeScalar(0x2CCD)!]) }
    if value == 0x2CCE { return (true, to:[UnicodeScalar(0x2CCF)!]) }
    if value == 0x2CD0 { return (true, to:[UnicodeScalar(0x2CD1)!]) }
    if value == 0x2CD2 { return (true, to:[UnicodeScalar(0x2CD3)!]) }
    if value == 0x2CD4 { return (true, to:[UnicodeScalar(0x2CD5)!]) }
    if value == 0x2CD6 { return (true, to:[UnicodeScalar(0x2CD7)!]) }
    if value == 0x2CD8 { return (true, to:[UnicodeScalar(0x2CD9)!]) }
    if value == 0x2CDA { return (true, to:[UnicodeScalar(0x2CDB)!]) }
    if value == 0x2CDC { return (true, to:[UnicodeScalar(0x2CDD)!]) }
    if value == 0x2CDE { return (true, to:[UnicodeScalar(0x2CDF)!]) }
    if value == 0x2CE0 { return (true, to:[UnicodeScalar(0x2CE1)!]) }
    if value == 0x2CE2 { return (true, to:[UnicodeScalar(0x2CE3)!]) }
    if value == 0x2CEB { return (true, to:[UnicodeScalar(0x2CEC)!]) }
    if value == 0x2CED { return (true, to:[UnicodeScalar(0x2CEE)!]) }
    if value == 0x2CF2 { return (true, to:[UnicodeScalar(0x2CF3)!]) }
    if value == 0x2D6F { return (true, to:[UnicodeScalar(0x2D61)!]) }
    if value == 0x2E9F { return (true, to:[UnicodeScalar(0x6BCD)!]) }
    if value == 0x2EF3 { return (true, to:[UnicodeScalar(0x9F9F)!]) }
    if value == 0x2F00 { return (true, to:[UnicodeScalar(0x4E00)!]) }
    if value == 0x2F01 { return (true, to:[UnicodeScalar(0x4E28)!]) }
    if value == 0x2F02 { return (true, to:[UnicodeScalar(0x4E36)!]) }
    if value == 0x2F03 { return (true, to:[UnicodeScalar(0x4E3F)!]) }
    if value == 0x2F04 { return (true, to:[UnicodeScalar(0x4E59)!]) }
    if value == 0x2F05 { return (true, to:[UnicodeScalar(0x4E85)!]) }
    if value == 0x2F06 { return (true, to:[UnicodeScalar(0x4E8C)!]) }
    if value == 0x2F07 { return (true, to:[UnicodeScalar(0x4EA0)!]) }
    if value == 0x2F08 { return (true, to:[UnicodeScalar(0x4EBA)!]) }
    if value == 0x2F09 { return (true, to:[UnicodeScalar(0x513F)!]) }
    if value == 0x2F0A { return (true, to:[UnicodeScalar(0x5165)!]) }
    if value == 0x2F0B { return (true, to:[UnicodeScalar(0x516B)!]) }
    if value == 0x2F0C { return (true, to:[UnicodeScalar(0x5182)!]) }
    if value == 0x2F0D { return (true, to:[UnicodeScalar(0x5196)!]) }
    if value == 0x2F0E { return (true, to:[UnicodeScalar(0x51AB)!]) }
    if value == 0x2F0F { return (true, to:[UnicodeScalar(0x51E0)!]) }
    if value == 0x2F10 { return (true, to:[UnicodeScalar(0x51F5)!]) }
    if value == 0x2F11 { return (true, to:[UnicodeScalar(0x5200)!]) }
    if value == 0x2F12 { return (true, to:[UnicodeScalar(0x529B)!]) }
    if value == 0x2F13 { return (true, to:[UnicodeScalar(0x52F9)!]) }
    if value == 0x2F14 { return (true, to:[UnicodeScalar(0x5315)!]) }
    if value == 0x2F15 { return (true, to:[UnicodeScalar(0x531A)!]) }
    if value == 0x2F16 { return (true, to:[UnicodeScalar(0x5338)!]) }
    if value == 0x2F17 { return (true, to:[UnicodeScalar(0x5341)!]) }
    if value == 0x2F18 { return (true, to:[UnicodeScalar(0x535C)!]) }
    if value == 0x2F19 { return (true, to:[UnicodeScalar(0x5369)!]) }
    if value == 0x2F1A { return (true, to:[UnicodeScalar(0x5382)!]) }
    if value == 0x2F1B { return (true, to:[UnicodeScalar(0x53B6)!]) }
    if value == 0x2F1C { return (true, to:[UnicodeScalar(0x53C8)!]) }
    if value == 0x2F1D { return (true, to:[UnicodeScalar(0x53E3)!]) }
    if value == 0x2F1E { return (true, to:[UnicodeScalar(0x56D7)!]) }
    if value == 0x2F1F { return (true, to:[UnicodeScalar(0x571F)!]) }
    if value == 0x2F20 { return (true, to:[UnicodeScalar(0x58EB)!]) }
    if value == 0x2F21 { return (true, to:[UnicodeScalar(0x5902)!]) }
    if value == 0x2F22 { return (true, to:[UnicodeScalar(0x590A)!]) }
    if value == 0x2F23 { return (true, to:[UnicodeScalar(0x5915)!]) }
    if value == 0x2F24 { return (true, to:[UnicodeScalar(0x5927)!]) }
    if value == 0x2F25 { return (true, to:[UnicodeScalar(0x5973)!]) }
    if value == 0x2F26 { return (true, to:[UnicodeScalar(0x5B50)!]) }
    if value == 0x2F27 { return (true, to:[UnicodeScalar(0x5B80)!]) }
    if value == 0x2F28 { return (true, to:[UnicodeScalar(0x5BF8)!]) }
    if value == 0x2F29 { return (true, to:[UnicodeScalar(0x5C0F)!]) }
    if value == 0x2F2A { return (true, to:[UnicodeScalar(0x5C22)!]) }
    if value == 0x2F2B { return (true, to:[UnicodeScalar(0x5C38)!]) }
    if value == 0x2F2C { return (true, to:[UnicodeScalar(0x5C6E)!]) }
    if value == 0x2F2D { return (true, to:[UnicodeScalar(0x5C71)!]) }
    if value == 0x2F2E { return (true, to:[UnicodeScalar(0x5DDB)!]) }
    if value == 0x2F2F { return (true, to:[UnicodeScalar(0x5DE5)!]) }
    if value == 0x2F30 { return (true, to:[UnicodeScalar(0x5DF1)!]) }
    if value == 0x2F31 { return (true, to:[UnicodeScalar(0x5DFE)!]) }
    if value == 0x2F32 { return (true, to:[UnicodeScalar(0x5E72)!]) }
    if value == 0x2F33 { return (true, to:[UnicodeScalar(0x5E7A)!]) }
    if value == 0x2F34 { return (true, to:[UnicodeScalar(0x5E7F)!]) }
    if value == 0x2F35 { return (true, to:[UnicodeScalar(0x5EF4)!]) }
    if value == 0x2F36 { return (true, to:[UnicodeScalar(0x5EFE)!]) }
    if value == 0x2F37 { return (true, to:[UnicodeScalar(0x5F0B)!]) }
    if value == 0x2F38 { return (true, to:[UnicodeScalar(0x5F13)!]) }
    if value == 0x2F39 { return (true, to:[UnicodeScalar(0x5F50)!]) }
    if value == 0x2F3A { return (true, to:[UnicodeScalar(0x5F61)!]) }
    if value == 0x2F3B { return (true, to:[UnicodeScalar(0x5F73)!]) }
    if value == 0x2F3C { return (true, to:[UnicodeScalar(0x5FC3)!]) }
    if value == 0x2F3D { return (true, to:[UnicodeScalar(0x6208)!]) }
    if value == 0x2F3E { return (true, to:[UnicodeScalar(0x6236)!]) }
    if value == 0x2F3F { return (true, to:[UnicodeScalar(0x624B)!]) }
    if value == 0x2F40 { return (true, to:[UnicodeScalar(0x652F)!]) }
    if value == 0x2F41 { return (true, to:[UnicodeScalar(0x6534)!]) }
    if value == 0x2F42 { return (true, to:[UnicodeScalar(0x6587)!]) }
    if value == 0x2F43 { return (true, to:[UnicodeScalar(0x6597)!]) }
    if value == 0x2F44 { return (true, to:[UnicodeScalar(0x65A4)!]) }
    if value == 0x2F45 { return (true, to:[UnicodeScalar(0x65B9)!]) }
    if value == 0x2F46 { return (true, to:[UnicodeScalar(0x65E0)!]) }
    if value == 0x2F47 { return (true, to:[UnicodeScalar(0x65E5)!]) }
    if value == 0x2F48 { return (true, to:[UnicodeScalar(0x66F0)!]) }
    if value == 0x2F49 { return (true, to:[UnicodeScalar(0x6708)!]) }
    if value == 0x2F4A { return (true, to:[UnicodeScalar(0x6728)!]) }
    if value == 0x2F4B { return (true, to:[UnicodeScalar(0x6B20)!]) }
    if value == 0x2F4C { return (true, to:[UnicodeScalar(0x6B62)!]) }
    if value == 0x2F4D { return (true, to:[UnicodeScalar(0x6B79)!]) }
    if value == 0x2F4E { return (true, to:[UnicodeScalar(0x6BB3)!]) }
    if value == 0x2F4F { return (true, to:[UnicodeScalar(0x6BCB)!]) }
    if value == 0x2F50 { return (true, to:[UnicodeScalar(0x6BD4)!]) }
    if value == 0x2F51 { return (true, to:[UnicodeScalar(0x6BDB)!]) }
    if value == 0x2F52 { return (true, to:[UnicodeScalar(0x6C0F)!]) }
    if value == 0x2F53 { return (true, to:[UnicodeScalar(0x6C14)!]) }
    if value == 0x2F54 { return (true, to:[UnicodeScalar(0x6C34)!]) }
    if value == 0x2F55 { return (true, to:[UnicodeScalar(0x706B)!]) }
    if value == 0x2F56 { return (true, to:[UnicodeScalar(0x722A)!]) }
    if value == 0x2F57 { return (true, to:[UnicodeScalar(0x7236)!]) }
    if value == 0x2F58 { return (true, to:[UnicodeScalar(0x723B)!]) }
    if value == 0x2F59 { return (true, to:[UnicodeScalar(0x723F)!]) }
    if value == 0x2F5A { return (true, to:[UnicodeScalar(0x7247)!]) }
    if value == 0x2F5B { return (true, to:[UnicodeScalar(0x7259)!]) }
    if value == 0x2F5C { return (true, to:[UnicodeScalar(0x725B)!]) }
    if value == 0x2F5D { return (true, to:[UnicodeScalar(0x72AC)!]) }
    if value == 0x2F5E { return (true, to:[UnicodeScalar(0x7384)!]) }
    if value == 0x2F5F { return (true, to:[UnicodeScalar(0x7389)!]) }
    if value == 0x2F60 { return (true, to:[UnicodeScalar(0x74DC)!]) }
    if value == 0x2F61 { return (true, to:[UnicodeScalar(0x74E6)!]) }
    if value == 0x2F62 { return (true, to:[UnicodeScalar(0x7518)!]) }
    if value == 0x2F63 { return (true, to:[UnicodeScalar(0x751F)!]) }
    if value == 0x2F64 { return (true, to:[UnicodeScalar(0x7528)!]) }
    if value == 0x2F65 { return (true, to:[UnicodeScalar(0x7530)!]) }
    if value == 0x2F66 { return (true, to:[UnicodeScalar(0x758B)!]) }
    if value == 0x2F67 { return (true, to:[UnicodeScalar(0x7592)!]) }
    if value == 0x2F68 { return (true, to:[UnicodeScalar(0x7676)!]) }
    if value == 0x2F69 { return (true, to:[UnicodeScalar(0x767D)!]) }
    if value == 0x2F6A { return (true, to:[UnicodeScalar(0x76AE)!]) }
    if value == 0x2F6B { return (true, to:[UnicodeScalar(0x76BF)!]) }
    if value == 0x2F6C { return (true, to:[UnicodeScalar(0x76EE)!]) }
    if value == 0x2F6D { return (true, to:[UnicodeScalar(0x77DB)!]) }
    if value == 0x2F6E { return (true, to:[UnicodeScalar(0x77E2)!]) }
    if value == 0x2F6F { return (true, to:[UnicodeScalar(0x77F3)!]) }
    if value == 0x2F70 { return (true, to:[UnicodeScalar(0x793A)!]) }
    if value == 0x2F71 { return (true, to:[UnicodeScalar(0x79B8)!]) }
    if value == 0x2F72 { return (true, to:[UnicodeScalar(0x79BE)!]) }
    if value == 0x2F73 { return (true, to:[UnicodeScalar(0x7A74)!]) }
    if value == 0x2F74 { return (true, to:[UnicodeScalar(0x7ACB)!]) }
    if value == 0x2F75 { return (true, to:[UnicodeScalar(0x7AF9)!]) }
    if value == 0x2F76 { return (true, to:[UnicodeScalar(0x7C73)!]) }
    if value == 0x2F77 { return (true, to:[UnicodeScalar(0x7CF8)!]) }
    if value == 0x2F78 { return (true, to:[UnicodeScalar(0x7F36)!]) }
    if value == 0x2F79 { return (true, to:[UnicodeScalar(0x7F51)!]) }
    if value == 0x2F7A { return (true, to:[UnicodeScalar(0x7F8A)!]) }
    if value == 0x2F7B { return (true, to:[UnicodeScalar(0x7FBD)!]) }
    if value == 0x2F7C { return (true, to:[UnicodeScalar(0x8001)!]) }
    if value == 0x2F7D { return (true, to:[UnicodeScalar(0x800C)!]) }
    if value == 0x2F7E { return (true, to:[UnicodeScalar(0x8012)!]) }
    if value == 0x2F7F { return (true, to:[UnicodeScalar(0x8033)!]) }
    if value == 0x2F80 { return (true, to:[UnicodeScalar(0x807F)!]) }
    if value == 0x2F81 { return (true, to:[UnicodeScalar(0x8089)!]) }
    if value == 0x2F82 { return (true, to:[UnicodeScalar(0x81E3)!]) }
    if value == 0x2F83 { return (true, to:[UnicodeScalar(0x81EA)!]) }
    if value == 0x2F84 { return (true, to:[UnicodeScalar(0x81F3)!]) }
    if value == 0x2F85 { return (true, to:[UnicodeScalar(0x81FC)!]) }
    if value == 0x2F86 { return (true, to:[UnicodeScalar(0x820C)!]) }
    if value == 0x2F87 { return (true, to:[UnicodeScalar(0x821B)!]) }
    if value == 0x2F88 { return (true, to:[UnicodeScalar(0x821F)!]) }
    if value == 0x2F89 { return (true, to:[UnicodeScalar(0x826E)!]) }
    if value == 0x2F8A { return (true, to:[UnicodeScalar(0x8272)!]) }
    if value == 0x2F8B { return (true, to:[UnicodeScalar(0x8278)!]) }
    if value == 0x2F8C { return (true, to:[UnicodeScalar(0x864D)!]) }
    if value == 0x2F8D { return (true, to:[UnicodeScalar(0x866B)!]) }
    if value == 0x2F8E { return (true, to:[UnicodeScalar(0x8840)!]) }
    if value == 0x2F8F { return (true, to:[UnicodeScalar(0x884C)!]) }
    if value == 0x2F90 { return (true, to:[UnicodeScalar(0x8863)!]) }
    if value == 0x2F91 { return (true, to:[UnicodeScalar(0x897E)!]) }
    if value == 0x2F92 { return (true, to:[UnicodeScalar(0x898B)!]) }
    if value == 0x2F93 { return (true, to:[UnicodeScalar(0x89D2)!]) }
    if value == 0x2F94 { return (true, to:[UnicodeScalar(0x8A00)!]) }
    if value == 0x2F95 { return (true, to:[UnicodeScalar(0x8C37)!]) }
    if value == 0x2F96 { return (true, to:[UnicodeScalar(0x8C46)!]) }
    if value == 0x2F97 { return (true, to:[UnicodeScalar(0x8C55)!]) }
    if value == 0x2F98 { return (true, to:[UnicodeScalar(0x8C78)!]) }
    if value == 0x2F99 { return (true, to:[UnicodeScalar(0x8C9D)!]) }
    if value == 0x2F9A { return (true, to:[UnicodeScalar(0x8D64)!]) }
    if value == 0x2F9B { return (true, to:[UnicodeScalar(0x8D70)!]) }
    if value == 0x2F9C { return (true, to:[UnicodeScalar(0x8DB3)!]) }
    if value == 0x2F9D { return (true, to:[UnicodeScalar(0x8EAB)!]) }
    if value == 0x2F9E { return (true, to:[UnicodeScalar(0x8ECA)!]) }
    if value == 0x2F9F { return (true, to:[UnicodeScalar(0x8F9B)!]) }
    if value == 0x2FA0 { return (true, to:[UnicodeScalar(0x8FB0)!]) }
    if value == 0x2FA1 { return (true, to:[UnicodeScalar(0x8FB5)!]) }
    if value == 0x2FA2 { return (true, to:[UnicodeScalar(0x9091)!]) }
    if value == 0x2FA3 { return (true, to:[UnicodeScalar(0x9149)!]) }
    if value == 0x2FA4 { return (true, to:[UnicodeScalar(0x91C6)!]) }
    if value == 0x2FA5 { return (true, to:[UnicodeScalar(0x91CC)!]) }
    if value == 0x2FA6 { return (true, to:[UnicodeScalar(0x91D1)!]) }
    if value == 0x2FA7 { return (true, to:[UnicodeScalar(0x9577)!]) }
    if value == 0x2FA8 { return (true, to:[UnicodeScalar(0x9580)!]) }
    if value == 0x2FA9 { return (true, to:[UnicodeScalar(0x961C)!]) }
    if value == 0x2FAA { return (true, to:[UnicodeScalar(0x96B6)!]) }
    if value == 0x2FAB { return (true, to:[UnicodeScalar(0x96B9)!]) }
    if value == 0x2FAC { return (true, to:[UnicodeScalar(0x96E8)!]) }
    if value == 0x2FAD { return (true, to:[UnicodeScalar(0x9751)!]) }
    if value == 0x2FAE { return (true, to:[UnicodeScalar(0x975E)!]) }
    if value == 0x2FAF { return (true, to:[UnicodeScalar(0x9762)!]) }
    if value == 0x2FB0 { return (true, to:[UnicodeScalar(0x9769)!]) }
    if value == 0x2FB1 { return (true, to:[UnicodeScalar(0x97CB)!]) }
    if value == 0x2FB2 { return (true, to:[UnicodeScalar(0x97ED)!]) }
    if value == 0x2FB3 { return (true, to:[UnicodeScalar(0x97F3)!]) }
    if value == 0x2FB4 { return (true, to:[UnicodeScalar(0x9801)!]) }
    if value == 0x2FB5 { return (true, to:[UnicodeScalar(0x98A8)!]) }
    if value == 0x2FB6 { return (true, to:[UnicodeScalar(0x98DB)!]) }
    if value == 0x2FB7 { return (true, to:[UnicodeScalar(0x98DF)!]) }
    if value == 0x2FB8 { return (true, to:[UnicodeScalar(0x9996)!]) }
    if value == 0x2FB9 { return (true, to:[UnicodeScalar(0x9999)!]) }
    if value == 0x2FBA { return (true, to:[UnicodeScalar(0x99AC)!]) }
    if value == 0x2FBB { return (true, to:[UnicodeScalar(0x9AA8)!]) }
    if value == 0x2FBC { return (true, to:[UnicodeScalar(0x9AD8)!]) }
    if value == 0x2FBD { return (true, to:[UnicodeScalar(0x9ADF)!]) }
    if value == 0x2FBE { return (true, to:[UnicodeScalar(0x9B25)!]) }
    if value == 0x2FBF { return (true, to:[UnicodeScalar(0x9B2F)!]) }
    if value == 0x2FC0 { return (true, to:[UnicodeScalar(0x9B32)!]) }
    if value == 0x2FC1 { return (true, to:[UnicodeScalar(0x9B3C)!]) }
    if value == 0x2FC2 { return (true, to:[UnicodeScalar(0x9B5A)!]) }
    if value == 0x2FC3 { return (true, to:[UnicodeScalar(0x9CE5)!]) }
    if value == 0x2FC4 { return (true, to:[UnicodeScalar(0x9E75)!]) }
    if value == 0x2FC5 { return (true, to:[UnicodeScalar(0x9E7F)!]) }
    if value == 0x2FC6 { return (true, to:[UnicodeScalar(0x9EA5)!]) }
    if value == 0x2FC7 { return (true, to:[UnicodeScalar(0x9EBB)!]) }
    if value == 0x2FC8 { return (true, to:[UnicodeScalar(0x9EC3)!]) }
    if value == 0x2FC9 { return (true, to:[UnicodeScalar(0x9ECD)!]) }
    if value == 0x2FCA { return (true, to:[UnicodeScalar(0x9ED1)!]) }
    if value == 0x2FCB { return (true, to:[UnicodeScalar(0x9EF9)!]) }
    if value == 0x2FCC { return (true, to:[UnicodeScalar(0x9EFD)!]) }
    if value == 0x2FCD { return (true, to:[UnicodeScalar(0x9F0E)!]) }
    if value == 0x2FCE { return (true, to:[UnicodeScalar(0x9F13)!]) }
    if value == 0x2FCF { return (true, to:[UnicodeScalar(0x9F20)!]) }
    if value == 0x2FD0 { return (true, to:[UnicodeScalar(0x9F3B)!]) }
    if value == 0x2FD1 { return (true, to:[UnicodeScalar(0x9F4A)!]) }
    if value == 0x2FD2 { return (true, to:[UnicodeScalar(0x9F52)!]) }
    if value == 0x2FD3 { return (true, to:[UnicodeScalar(0x9F8D)!]) }
    if value == 0x2FD4 { return (true, to:[UnicodeScalar(0x9F9C)!]) }
    if value == 0x2FD5 { return (true, to:[UnicodeScalar(0x9FA0)!]) }
    if value == 0x3002 { return (true, to:[UnicodeScalar(0x002E)!]) }
    if value == 0x3036 { return (true, to:[UnicodeScalar(0x3012)!]) }
    if value == 0x3038 { return (true, to:[UnicodeScalar(0x5341)!]) }
    if value == 0x3039 { return (true, to:[UnicodeScalar(0x5344)!]) }
    if value == 0x303A { return (true, to:[UnicodeScalar(0x5345)!]) }
    if value == 0x309F { return (true, to:[UnicodeScalar(0x3088)!, UnicodeScalar(0x308A)!]) }
    if value == 0x30FF { return (true, to:[UnicodeScalar(0x30B3)!, UnicodeScalar(0x30C8)!]) }
    if value == 0x3131 { return (true, to:[UnicodeScalar(0x1100)!]) }
    if value == 0x3132 { return (true, to:[UnicodeScalar(0x1101)!]) }
    if value == 0x3133 { return (true, to:[UnicodeScalar(0x11AA)!]) }
    if value == 0x3134 { return (true, to:[UnicodeScalar(0x1102)!]) }
    if value == 0x3135 { return (true, to:[UnicodeScalar(0x11AC)!]) }
    if value == 0x3136 { return (true, to:[UnicodeScalar(0x11AD)!]) }
    if value == 0x3137 { return (true, to:[UnicodeScalar(0x1103)!]) }
    if value == 0x3138 { return (true, to:[UnicodeScalar(0x1104)!]) }
    if value == 0x3139 { return (true, to:[UnicodeScalar(0x1105)!]) }
    if value == 0x313A { return (true, to:[UnicodeScalar(0x11B0)!]) }
    if value == 0x313B { return (true, to:[UnicodeScalar(0x11B1)!]) }
    if value == 0x313C { return (true, to:[UnicodeScalar(0x11B2)!]) }
    if value == 0x313D { return (true, to:[UnicodeScalar(0x11B3)!]) }
    if value == 0x313E { return (true, to:[UnicodeScalar(0x11B4)!]) }
    if value == 0x313F { return (true, to:[UnicodeScalar(0x11B5)!]) }
    if value == 0x3140 { return (true, to:[UnicodeScalar(0x111A)!]) }
    if value == 0x3141 { return (true, to:[UnicodeScalar(0x1106)!]) }
    if value == 0x3142 { return (true, to:[UnicodeScalar(0x1107)!]) }
    if value == 0x3143 { return (true, to:[UnicodeScalar(0x1108)!]) }
    if value == 0x3144 { return (true, to:[UnicodeScalar(0x1121)!]) }
    if value == 0x3145 { return (true, to:[UnicodeScalar(0x1109)!]) }
    if value == 0x3146 { return (true, to:[UnicodeScalar(0x110A)!]) }
    if value == 0x3147 { return (true, to:[UnicodeScalar(0x110B)!]) }
    if value == 0x3148 { return (true, to:[UnicodeScalar(0x110C)!]) }
    if value == 0x3149 { return (true, to:[UnicodeScalar(0x110D)!]) }
    if value == 0x314A { return (true, to:[UnicodeScalar(0x110E)!]) }
    if value == 0x314B { return (true, to:[UnicodeScalar(0x110F)!]) }
    if value == 0x314C { return (true, to:[UnicodeScalar(0x1110)!]) }
    if value == 0x314D { return (true, to:[UnicodeScalar(0x1111)!]) }
    if value == 0x314E { return (true, to:[UnicodeScalar(0x1112)!]) }
    if value == 0x314F { return (true, to:[UnicodeScalar(0x1161)!]) }
    if value == 0x3150 { return (true, to:[UnicodeScalar(0x1162)!]) }
    if value == 0x3151 { return (true, to:[UnicodeScalar(0x1163)!]) }
    if value == 0x3152 { return (true, to:[UnicodeScalar(0x1164)!]) }
    if value == 0x3153 { return (true, to:[UnicodeScalar(0x1165)!]) }
    if value == 0x3154 { return (true, to:[UnicodeScalar(0x1166)!]) }
    if value == 0x3155 { return (true, to:[UnicodeScalar(0x1167)!]) }
    if value == 0x3156 { return (true, to:[UnicodeScalar(0x1168)!]) }
    if value == 0x3157 { return (true, to:[UnicodeScalar(0x1169)!]) }
    if value == 0x3158 { return (true, to:[UnicodeScalar(0x116A)!]) }
    if value == 0x3159 { return (true, to:[UnicodeScalar(0x116B)!]) }
    if value == 0x315A { return (true, to:[UnicodeScalar(0x116C)!]) }
    if value == 0x315B { return (true, to:[UnicodeScalar(0x116D)!]) }
    if value == 0x315C { return (true, to:[UnicodeScalar(0x116E)!]) }
    if value == 0x315D { return (true, to:[UnicodeScalar(0x116F)!]) }
    if value == 0x315E { return (true, to:[UnicodeScalar(0x1170)!]) }
    if value == 0x315F { return (true, to:[UnicodeScalar(0x1171)!]) }
    if value == 0x3160 { return (true, to:[UnicodeScalar(0x1172)!]) }
    if value == 0x3161 { return (true, to:[UnicodeScalar(0x1173)!]) }
    if value == 0x3162 { return (true, to:[UnicodeScalar(0x1174)!]) }
    if value == 0x3163 { return (true, to:[UnicodeScalar(0x1175)!]) }
    if value == 0x3165 { return (true, to:[UnicodeScalar(0x1114)!]) }
    if value == 0x3166 { return (true, to:[UnicodeScalar(0x1115)!]) }
    if value == 0x3167 { return (true, to:[UnicodeScalar(0x11C7)!]) }
    if value == 0x3168 { return (true, to:[UnicodeScalar(0x11C8)!]) }
    if value == 0x3169 { return (true, to:[UnicodeScalar(0x11CC)!]) }
    if value == 0x316A { return (true, to:[UnicodeScalar(0x11CE)!]) }
    if value == 0x316B { return (true, to:[UnicodeScalar(0x11D3)!]) }
    if value == 0x316C { return (true, to:[UnicodeScalar(0x11D7)!]) }
    if value == 0x316D { return (true, to:[UnicodeScalar(0x11D9)!]) }
    if value == 0x316E { return (true, to:[UnicodeScalar(0x111C)!]) }
    if value == 0x316F { return (true, to:[UnicodeScalar(0x11DD)!]) }
    if value == 0x3170 { return (true, to:[UnicodeScalar(0x11DF)!]) }
    if value == 0x3171 { return (true, to:[UnicodeScalar(0x111D)!]) }
    if value == 0x3172 { return (true, to:[UnicodeScalar(0x111E)!]) }
    if value == 0x3173 { return (true, to:[UnicodeScalar(0x1120)!]) }
    if value == 0x3174 { return (true, to:[UnicodeScalar(0x1122)!]) }
    if value == 0x3175 { return (true, to:[UnicodeScalar(0x1123)!]) }
    if value == 0x3176 { return (true, to:[UnicodeScalar(0x1127)!]) }
    if value == 0x3177 { return (true, to:[UnicodeScalar(0x1129)!]) }
    if value == 0x3178 { return (true, to:[UnicodeScalar(0x112B)!]) }
    if value == 0x3179 { return (true, to:[UnicodeScalar(0x112C)!]) }
    if value == 0x317A { return (true, to:[UnicodeScalar(0x112D)!]) }
    if value == 0x317B { return (true, to:[UnicodeScalar(0x112E)!]) }
    if value == 0x317C { return (true, to:[UnicodeScalar(0x112F)!]) }
    if value == 0x317D { return (true, to:[UnicodeScalar(0x1132)!]) }
    if value == 0x317E { return (true, to:[UnicodeScalar(0x1136)!]) }
    if value == 0x317F { return (true, to:[UnicodeScalar(0x1140)!]) }
    if value == 0x3180 { return (true, to:[UnicodeScalar(0x1147)!]) }
    if value == 0x3181 { return (true, to:[UnicodeScalar(0x114C)!]) }
    if value == 0x3182 { return (true, to:[UnicodeScalar(0x11F1)!]) }
    if value == 0x3183 { return (true, to:[UnicodeScalar(0x11F2)!]) }
    if value == 0x3184 { return (true, to:[UnicodeScalar(0x1157)!]) }
    if value == 0x3185 { return (true, to:[UnicodeScalar(0x1158)!]) }
    if value == 0x3186 { return (true, to:[UnicodeScalar(0x1159)!]) }
    if value == 0x3187 { return (true, to:[UnicodeScalar(0x1184)!]) }
    if value == 0x3188 { return (true, to:[UnicodeScalar(0x1185)!]) }
    if value == 0x3189 { return (true, to:[UnicodeScalar(0x1188)!]) }
    if value == 0x318A { return (true, to:[UnicodeScalar(0x1191)!]) }
    if value == 0x318B { return (true, to:[UnicodeScalar(0x1192)!]) }
    if value == 0x318C { return (true, to:[UnicodeScalar(0x1194)!]) }
    if value == 0x318D { return (true, to:[UnicodeScalar(0x119E)!]) }
    if value == 0x318E { return (true, to:[UnicodeScalar(0x11A1)!]) }
    if value == 0x3192 { return (true, to:[UnicodeScalar(0x4E00)!]) }
    if value == 0x3193 { return (true, to:[UnicodeScalar(0x4E8C)!]) }
    if value == 0x3194 { return (true, to:[UnicodeScalar(0x4E09)!]) }
    if value == 0x3195 { return (true, to:[UnicodeScalar(0x56DB)!]) }
    if value == 0x3196 { return (true, to:[UnicodeScalar(0x4E0A)!]) }
    if value == 0x3197 { return (true, to:[UnicodeScalar(0x4E2D)!]) }
    if value == 0x3198 { return (true, to:[UnicodeScalar(0x4E0B)!]) }
    if value == 0x3199 { return (true, to:[UnicodeScalar(0x7532)!]) }
    if value == 0x319A { return (true, to:[UnicodeScalar(0x4E59)!]) }
    if value == 0x319B { return (true, to:[UnicodeScalar(0x4E19)!]) }
    if value == 0x319C { return (true, to:[UnicodeScalar(0x4E01)!]) }
    if value == 0x319D { return (true, to:[UnicodeScalar(0x5929)!]) }
    if value == 0x319E { return (true, to:[UnicodeScalar(0x5730)!]) }
    if value == 0x319F { return (true, to:[UnicodeScalar(0x4EBA)!]) }
    if value == 0x3244 { return (true, to:[UnicodeScalar(0x554F)!]) }
    if value == 0x3245 { return (true, to:[UnicodeScalar(0x5E7C)!]) }
    if value == 0x3246 { return (true, to:[UnicodeScalar(0x6587)!]) }
    if value == 0x3247 { return (true, to:[UnicodeScalar(0x7B8F)!]) }
    if value == 0x3250 { return (true, to:[UnicodeScalar(0x0070)!, UnicodeScalar(0x0074)!, UnicodeScalar(0x0065)!]) }
    if value == 0x3251 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0031)!]) }
    if value == 0x3252 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0032)!]) }
    if value == 0x3253 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0033)!]) }
    if value == 0x3254 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0034)!]) }
    if value == 0x3255 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0035)!]) }
    if value == 0x3256 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0036)!]) }
    if value == 0x3257 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0037)!]) }
    if value == 0x3258 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0038)!]) }
    if value == 0x3259 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0039)!]) }
    if value == 0x325A { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x0030)!]) }
    if value == 0x325B { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x0031)!]) }
    if value == 0x325C { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x0032)!]) }
    if value == 0x325D { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x0033)!]) }
    if value == 0x325E { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x0034)!]) }
    if value == 0x325F { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x0035)!]) }
    if value == 0x3260 { return (true, to:[UnicodeScalar(0x1100)!]) }
    if value == 0x3261 { return (true, to:[UnicodeScalar(0x1102)!]) }
    if value == 0x3262 { return (true, to:[UnicodeScalar(0x1103)!]) }
    if value == 0x3263 { return (true, to:[UnicodeScalar(0x1105)!]) }
    if value == 0x3264 { return (true, to:[UnicodeScalar(0x1106)!]) }
    if value == 0x3265 { return (true, to:[UnicodeScalar(0x1107)!]) }
    if value == 0x3266 { return (true, to:[UnicodeScalar(0x1109)!]) }
    if value == 0x3267 { return (true, to:[UnicodeScalar(0x110B)!]) }
    if value == 0x3268 { return (true, to:[UnicodeScalar(0x110C)!]) }
    if value == 0x3269 { return (true, to:[UnicodeScalar(0x110E)!]) }
    if value == 0x326A { return (true, to:[UnicodeScalar(0x110F)!]) }
    if value == 0x326B { return (true, to:[UnicodeScalar(0x1110)!]) }
    if value == 0x326C { return (true, to:[UnicodeScalar(0x1111)!]) }
    if value == 0x326D { return (true, to:[UnicodeScalar(0x1112)!]) }
    if value == 0x326E { return (true, to:[UnicodeScalar(0xAC00)!]) }
    if value == 0x326F { return (true, to:[UnicodeScalar(0xB098)!]) }
    if value == 0x3270 { return (true, to:[UnicodeScalar(0xB2E4)!]) }
    if value == 0x3271 { return (true, to:[UnicodeScalar(0xB77C)!]) }
    if value == 0x3272 { return (true, to:[UnicodeScalar(0xB9C8)!]) }
    if value == 0x3273 { return (true, to:[UnicodeScalar(0xBC14)!]) }
    if value == 0x3274 { return (true, to:[UnicodeScalar(0xC0AC)!]) }
    if value == 0x3275 { return (true, to:[UnicodeScalar(0xC544)!]) }
    if value == 0x3276 { return (true, to:[UnicodeScalar(0xC790)!]) }
    if value == 0x3277 { return (true, to:[UnicodeScalar(0xCC28)!]) }
    if value == 0x3278 { return (true, to:[UnicodeScalar(0xCE74)!]) }
    if value == 0x3279 { return (true, to:[UnicodeScalar(0xD0C0)!]) }
    if value == 0x327A { return (true, to:[UnicodeScalar(0xD30C)!]) }
    if value == 0x327B { return (true, to:[UnicodeScalar(0xD558)!]) }
    if value == 0x327C { return (true, to:[UnicodeScalar(0xCC38)!, UnicodeScalar(0xACE0)!]) }
    if value == 0x327D { return (true, to:[UnicodeScalar(0xC8FC)!, UnicodeScalar(0xC758)!]) }
    if value == 0x327E { return (true, to:[UnicodeScalar(0xC6B0)!]) }
    if value == 0x3280 { return (true, to:[UnicodeScalar(0x4E00)!]) }
    if value == 0x3281 { return (true, to:[UnicodeScalar(0x4E8C)!]) }
    if value == 0x3282 { return (true, to:[UnicodeScalar(0x4E09)!]) }
    if value == 0x3283 { return (true, to:[UnicodeScalar(0x56DB)!]) }
    if value == 0x3284 { return (true, to:[UnicodeScalar(0x4E94)!]) }
    if value == 0x3285 { return (true, to:[UnicodeScalar(0x516D)!]) }
    if value == 0x3286 { return (true, to:[UnicodeScalar(0x4E03)!]) }
    if value == 0x3287 { return (true, to:[UnicodeScalar(0x516B)!]) }
    if value == 0x3288 { return (true, to:[UnicodeScalar(0x4E5D)!]) }
    if value == 0x3289 { return (true, to:[UnicodeScalar(0x5341)!]) }
    if value == 0x328A { return (true, to:[UnicodeScalar(0x6708)!]) }
    if value == 0x328B { return (true, to:[UnicodeScalar(0x706B)!]) }
    if value == 0x328C { return (true, to:[UnicodeScalar(0x6C34)!]) }
    if value == 0x328D { return (true, to:[UnicodeScalar(0x6728)!]) }
    if value == 0x328E { return (true, to:[UnicodeScalar(0x91D1)!]) }
    if value == 0x328F { return (true, to:[UnicodeScalar(0x571F)!]) }
    if value == 0x3290 { return (true, to:[UnicodeScalar(0x65E5)!]) }
    if value == 0x3291 { return (true, to:[UnicodeScalar(0x682A)!]) }
    if value == 0x3292 { return (true, to:[UnicodeScalar(0x6709)!]) }
    if value == 0x3293 { return (true, to:[UnicodeScalar(0x793E)!]) }
    if value == 0x3294 { return (true, to:[UnicodeScalar(0x540D)!]) }
    if value == 0x3295 { return (true, to:[UnicodeScalar(0x7279)!]) }
    if value == 0x3296 { return (true, to:[UnicodeScalar(0x8CA1)!]) }
    if value == 0x3297 { return (true, to:[UnicodeScalar(0x795D)!]) }
    if value == 0x3298 { return (true, to:[UnicodeScalar(0x52B4)!]) }
    if value == 0x3299 { return (true, to:[UnicodeScalar(0x79D8)!]) }
    if value == 0x329A { return (true, to:[UnicodeScalar(0x7537)!]) }
    if value == 0x329B { return (true, to:[UnicodeScalar(0x5973)!]) }
    if value == 0x329C { return (true, to:[UnicodeScalar(0x9069)!]) }
    if value == 0x329D { return (true, to:[UnicodeScalar(0x512A)!]) }
    if value == 0x329E { return (true, to:[UnicodeScalar(0x5370)!]) }
    if value == 0x329F { return (true, to:[UnicodeScalar(0x6CE8)!]) }
    if value == 0x32A0 { return (true, to:[UnicodeScalar(0x9805)!]) }
    if value == 0x32A1 { return (true, to:[UnicodeScalar(0x4F11)!]) }
    if value == 0x32A2 { return (true, to:[UnicodeScalar(0x5199)!]) }
    if value == 0x32A3 { return (true, to:[UnicodeScalar(0x6B63)!]) }
    if value == 0x32A4 { return (true, to:[UnicodeScalar(0x4E0A)!]) }
    if value == 0x32A5 { return (true, to:[UnicodeScalar(0x4E2D)!]) }
    if value == 0x32A6 { return (true, to:[UnicodeScalar(0x4E0B)!]) }
    if value == 0x32A7 { return (true, to:[UnicodeScalar(0x5DE6)!]) }
    if value == 0x32A8 { return (true, to:[UnicodeScalar(0x53F3)!]) }
    if value == 0x32A9 { return (true, to:[UnicodeScalar(0x533B)!]) }
    if value == 0x32AA { return (true, to:[UnicodeScalar(0x5B97)!]) }
    if value == 0x32AB { return (true, to:[UnicodeScalar(0x5B66)!]) }
    if value == 0x32AC { return (true, to:[UnicodeScalar(0x76E3)!]) }
    if value == 0x32AD { return (true, to:[UnicodeScalar(0x4F01)!]) }
    if value == 0x32AE { return (true, to:[UnicodeScalar(0x8CC7)!]) }
    if value == 0x32AF { return (true, to:[UnicodeScalar(0x5354)!]) }
    if value == 0x32B0 { return (true, to:[UnicodeScalar(0x591C)!]) }
    if value == 0x32B1 { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x0036)!]) }
    if value == 0x32B2 { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x0037)!]) }
    if value == 0x32B3 { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x0038)!]) }
    if value == 0x32B4 { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x0039)!]) }
    if value == 0x32B5 { return (true, to:[UnicodeScalar(0x0034)!, UnicodeScalar(0x0030)!]) }
    if value == 0x32B6 { return (true, to:[UnicodeScalar(0x0034)!, UnicodeScalar(0x0031)!]) }
    if value == 0x32B7 { return (true, to:[UnicodeScalar(0x0034)!, UnicodeScalar(0x0032)!]) }
    if value == 0x32B8 { return (true, to:[UnicodeScalar(0x0034)!, UnicodeScalar(0x0033)!]) }
    if value == 0x32B9 { return (true, to:[UnicodeScalar(0x0034)!, UnicodeScalar(0x0034)!]) }
    if value == 0x32BA { return (true, to:[UnicodeScalar(0x0034)!, UnicodeScalar(0x0035)!]) }
    if value == 0x32BB { return (true, to:[UnicodeScalar(0x0034)!, UnicodeScalar(0x0036)!]) }
    if value == 0x32BC { return (true, to:[UnicodeScalar(0x0034)!, UnicodeScalar(0x0037)!]) }
    if value == 0x32BD { return (true, to:[UnicodeScalar(0x0034)!, UnicodeScalar(0x0038)!]) }
    if value == 0x32BE { return (true, to:[UnicodeScalar(0x0034)!, UnicodeScalar(0x0039)!]) }
    if value == 0x32BF { return (true, to:[UnicodeScalar(0x0035)!, UnicodeScalar(0x0030)!]) }
    if value == 0x32C0 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x6708)!]) }
    if value == 0x32C1 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x6708)!]) }
    if value == 0x32C2 { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x6708)!]) }
    if value == 0x32C3 { return (true, to:[UnicodeScalar(0x0034)!, UnicodeScalar(0x6708)!]) }
    if value == 0x32C4 { return (true, to:[UnicodeScalar(0x0035)!, UnicodeScalar(0x6708)!]) }
    if value == 0x32C5 { return (true, to:[UnicodeScalar(0x0036)!, UnicodeScalar(0x6708)!]) }
    if value == 0x32C6 { return (true, to:[UnicodeScalar(0x0037)!, UnicodeScalar(0x6708)!]) }
    if value == 0x32C7 { return (true, to:[UnicodeScalar(0x0038)!, UnicodeScalar(0x6708)!]) }
    if value == 0x32C8 { return (true, to:[UnicodeScalar(0x0039)!, UnicodeScalar(0x6708)!]) }
    if value == 0x32C9 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0030)!, UnicodeScalar(0x6708)!]) }
    if value == 0x32CA { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x6708)!]) }
    if value == 0x32CB { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0032)!, UnicodeScalar(0x6708)!]) }
    if value == 0x32CC { return (true, to:[UnicodeScalar(0x0068)!, UnicodeScalar(0x0067)!]) }
    if value == 0x32CD { return (true, to:[UnicodeScalar(0x0065)!, UnicodeScalar(0x0072)!, UnicodeScalar(0x0067)!]) }
    if value == 0x32CE { return (true, to:[UnicodeScalar(0x0065)!, UnicodeScalar(0x0076)!]) }
    if value == 0x32CF { return (true, to:[UnicodeScalar(0x006C)!, UnicodeScalar(0x0074)!, UnicodeScalar(0x0064)!]) }
    if value == 0x32D0 { return (true, to:[UnicodeScalar(0x30A2)!]) }
    if value == 0x32D1 { return (true, to:[UnicodeScalar(0x30A4)!]) }
    if value == 0x32D2 { return (true, to:[UnicodeScalar(0x30A6)!]) }
    if value == 0x32D3 { return (true, to:[UnicodeScalar(0x30A8)!]) }
    if value == 0x32D4 { return (true, to:[UnicodeScalar(0x30AA)!]) }
    if value == 0x32D5 { return (true, to:[UnicodeScalar(0x30AB)!]) }
    if value == 0x32D6 { return (true, to:[UnicodeScalar(0x30AD)!]) }
    if value == 0x32D7 { return (true, to:[UnicodeScalar(0x30AF)!]) }
    if value == 0x32D8 { return (true, to:[UnicodeScalar(0x30B1)!]) }
    if value == 0x32D9 { return (true, to:[UnicodeScalar(0x30B3)!]) }
    if value == 0x32DA { return (true, to:[UnicodeScalar(0x30B5)!]) }
    if value == 0x32DB { return (true, to:[UnicodeScalar(0x30B7)!]) }
    if value == 0x32DC { return (true, to:[UnicodeScalar(0x30B9)!]) }
    if value == 0x32DD { return (true, to:[UnicodeScalar(0x30BB)!]) }
    if value == 0x32DE { return (true, to:[UnicodeScalar(0x30BD)!]) }
    if value == 0x32DF { return (true, to:[UnicodeScalar(0x30BF)!]) }
    if value == 0x32E0 { return (true, to:[UnicodeScalar(0x30C1)!]) }
    if value == 0x32E1 { return (true, to:[UnicodeScalar(0x30C4)!]) }
    if value == 0x32E2 { return (true, to:[UnicodeScalar(0x30C6)!]) }
    if value == 0x32E3 { return (true, to:[UnicodeScalar(0x30C8)!]) }
    if value == 0x32E4 { return (true, to:[UnicodeScalar(0x30CA)!]) }
    if value == 0x32E5 { return (true, to:[UnicodeScalar(0x30CB)!]) }
    if value == 0x32E6 { return (true, to:[UnicodeScalar(0x30CC)!]) }
    if value == 0x32E7 { return (true, to:[UnicodeScalar(0x30CD)!]) }
    if value == 0x32E8 { return (true, to:[UnicodeScalar(0x30CE)!]) }
    if value == 0x32E9 { return (true, to:[UnicodeScalar(0x30CF)!]) }
    if value == 0x32EA { return (true, to:[UnicodeScalar(0x30D2)!]) }
    if value == 0x32EB { return (true, to:[UnicodeScalar(0x30D5)!]) }
    if value == 0x32EC { return (true, to:[UnicodeScalar(0x30D8)!]) }
    if value == 0x32ED { return (true, to:[UnicodeScalar(0x30DB)!]) }
    if value == 0x32EE { return (true, to:[UnicodeScalar(0x30DE)!]) }
    if value == 0x32EF { return (true, to:[UnicodeScalar(0x30DF)!]) }
    if value == 0x32F0 { return (true, to:[UnicodeScalar(0x30E0)!]) }
    if value == 0x32F1 { return (true, to:[UnicodeScalar(0x30E1)!]) }
    if value == 0x32F2 { return (true, to:[UnicodeScalar(0x30E2)!]) }
    if value == 0x32F3 { return (true, to:[UnicodeScalar(0x30E4)!]) }
    if value == 0x32F4 { return (true, to:[UnicodeScalar(0x30E6)!]) }
    if value == 0x32F5 { return (true, to:[UnicodeScalar(0x30E8)!]) }
    if value == 0x32F6 { return (true, to:[UnicodeScalar(0x30E9)!]) }
    if value == 0x32F7 { return (true, to:[UnicodeScalar(0x30EA)!]) }
    if value == 0x32F8 { return (true, to:[UnicodeScalar(0x30EB)!]) }
    if value == 0x32F9 { return (true, to:[UnicodeScalar(0x30EC)!]) }
    if value == 0x32FA { return (true, to:[UnicodeScalar(0x30ED)!]) }
    if value == 0x32FB { return (true, to:[UnicodeScalar(0x30EF)!]) }
    if value == 0x32FC { return (true, to:[UnicodeScalar(0x30F0)!]) }
    if value == 0x32FD { return (true, to:[UnicodeScalar(0x30F1)!]) }
    if value == 0x32FE { return (true, to:[UnicodeScalar(0x30F2)!]) }
    if value == 0x3300 { return (true, to:[UnicodeScalar(0x30A2)!, UnicodeScalar(0x30D1)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30C8)!]) }
    if value == 0x3301 { return (true, to:[UnicodeScalar(0x30A2)!, UnicodeScalar(0x30EB)!, UnicodeScalar(0x30D5)!, UnicodeScalar(0x30A1)!]) }
    if value == 0x3302 { return (true, to:[UnicodeScalar(0x30A2)!, UnicodeScalar(0x30F3)!, UnicodeScalar(0x30DA)!, UnicodeScalar(0x30A2)!]) }
    if value == 0x3303 { return (true, to:[UnicodeScalar(0x30A2)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x3304 { return (true, to:[UnicodeScalar(0x30A4)!, UnicodeScalar(0x30CB)!, UnicodeScalar(0x30F3)!, UnicodeScalar(0x30B0)!]) }
    if value == 0x3305 { return (true, to:[UnicodeScalar(0x30A4)!, UnicodeScalar(0x30F3)!, UnicodeScalar(0x30C1)!]) }
    if value == 0x3306 { return (true, to:[UnicodeScalar(0x30A6)!, UnicodeScalar(0x30A9)!, UnicodeScalar(0x30F3)!]) }
    if value == 0x3307 { return (true, to:[UnicodeScalar(0x30A8)!, UnicodeScalar(0x30B9)!, UnicodeScalar(0x30AF)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30C9)!]) }
    if value == 0x3308 { return (true, to:[UnicodeScalar(0x30A8)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30AB)!, UnicodeScalar(0x30FC)!]) }
    if value == 0x3309 { return (true, to:[UnicodeScalar(0x30AA)!, UnicodeScalar(0x30F3)!, UnicodeScalar(0x30B9)!]) }
    if value == 0x330A { return (true, to:[UnicodeScalar(0x30AA)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30E0)!]) }
    if value == 0x330B { return (true, to:[UnicodeScalar(0x30AB)!, UnicodeScalar(0x30A4)!, UnicodeScalar(0x30EA)!]) }
    if value == 0x330C { return (true, to:[UnicodeScalar(0x30AB)!, UnicodeScalar(0x30E9)!, UnicodeScalar(0x30C3)!, UnicodeScalar(0x30C8)!]) }
    if value == 0x330D { return (true, to:[UnicodeScalar(0x30AB)!, UnicodeScalar(0x30ED)!, UnicodeScalar(0x30EA)!, UnicodeScalar(0x30FC)!]) }
    if value == 0x330E { return (true, to:[UnicodeScalar(0x30AC)!, UnicodeScalar(0x30ED)!, UnicodeScalar(0x30F3)!]) }
    if value == 0x330F { return (true, to:[UnicodeScalar(0x30AC)!, UnicodeScalar(0x30F3)!, UnicodeScalar(0x30DE)!]) }
    if value == 0x3310 { return (true, to:[UnicodeScalar(0x30AE)!, UnicodeScalar(0x30AC)!]) }
    if value == 0x3311 { return (true, to:[UnicodeScalar(0x30AE)!, UnicodeScalar(0x30CB)!, UnicodeScalar(0x30FC)!]) }
    if value == 0x3312 { return (true, to:[UnicodeScalar(0x30AD)!, UnicodeScalar(0x30E5)!, UnicodeScalar(0x30EA)!, UnicodeScalar(0x30FC)!]) }
    if value == 0x3313 { return (true, to:[UnicodeScalar(0x30AE)!, UnicodeScalar(0x30EB)!, UnicodeScalar(0x30C0)!, UnicodeScalar(0x30FC)!]) }
    if value == 0x3314 { return (true, to:[UnicodeScalar(0x30AD)!, UnicodeScalar(0x30ED)!]) }
    if value == 0x3315 { return (true, to:[UnicodeScalar(0x30AD)!, UnicodeScalar(0x30ED)!, UnicodeScalar(0x30B0)!, UnicodeScalar(0x30E9)!, UnicodeScalar(0x30E0)!]) }
    if value == 0x3316 { return (true, to:[UnicodeScalar(0x30AD)!, UnicodeScalar(0x30ED)!, UnicodeScalar(0x30E1)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30C8)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x3317 { return (true, to:[UnicodeScalar(0x30AD)!, UnicodeScalar(0x30ED)!, UnicodeScalar(0x30EF)!, UnicodeScalar(0x30C3)!, UnicodeScalar(0x30C8)!]) }
    if value == 0x3318 { return (true, to:[UnicodeScalar(0x30B0)!, UnicodeScalar(0x30E9)!, UnicodeScalar(0x30E0)!]) }
    if value == 0x3319 { return (true, to:[UnicodeScalar(0x30B0)!, UnicodeScalar(0x30E9)!, UnicodeScalar(0x30E0)!, UnicodeScalar(0x30C8)!, UnicodeScalar(0x30F3)!]) }
    if value == 0x331A { return (true, to:[UnicodeScalar(0x30AF)!, UnicodeScalar(0x30EB)!, UnicodeScalar(0x30BC)!, UnicodeScalar(0x30A4)!, UnicodeScalar(0x30ED)!]) }
    if value == 0x331B { return (true, to:[UnicodeScalar(0x30AF)!, UnicodeScalar(0x30ED)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30CD)!]) }
    if value == 0x331C { return (true, to:[UnicodeScalar(0x30B1)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30B9)!]) }
    if value == 0x331D { return (true, to:[UnicodeScalar(0x30B3)!, UnicodeScalar(0x30EB)!, UnicodeScalar(0x30CA)!]) }
    if value == 0x331E { return (true, to:[UnicodeScalar(0x30B3)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30DD)!]) }
    if value == 0x331F { return (true, to:[UnicodeScalar(0x30B5)!, UnicodeScalar(0x30A4)!, UnicodeScalar(0x30AF)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x3320 { return (true, to:[UnicodeScalar(0x30B5)!, UnicodeScalar(0x30F3)!, UnicodeScalar(0x30C1)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30E0)!]) }
    if value == 0x3321 { return (true, to:[UnicodeScalar(0x30B7)!, UnicodeScalar(0x30EA)!, UnicodeScalar(0x30F3)!, UnicodeScalar(0x30B0)!]) }
    if value == 0x3322 { return (true, to:[UnicodeScalar(0x30BB)!, UnicodeScalar(0x30F3)!, UnicodeScalar(0x30C1)!]) }
    if value == 0x3323 { return (true, to:[UnicodeScalar(0x30BB)!, UnicodeScalar(0x30F3)!, UnicodeScalar(0x30C8)!]) }
    if value == 0x3324 { return (true, to:[UnicodeScalar(0x30C0)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30B9)!]) }
    if value == 0x3325 { return (true, to:[UnicodeScalar(0x30C7)!, UnicodeScalar(0x30B7)!]) }
    if value == 0x3326 { return (true, to:[UnicodeScalar(0x30C9)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x3327 { return (true, to:[UnicodeScalar(0x30C8)!, UnicodeScalar(0x30F3)!]) }
    if value == 0x3328 { return (true, to:[UnicodeScalar(0x30CA)!, UnicodeScalar(0x30CE)!]) }
    if value == 0x3329 { return (true, to:[UnicodeScalar(0x30CE)!, UnicodeScalar(0x30C3)!, UnicodeScalar(0x30C8)!]) }
    if value == 0x332A { return (true, to:[UnicodeScalar(0x30CF)!, UnicodeScalar(0x30A4)!, UnicodeScalar(0x30C4)!]) }
    if value == 0x332B { return (true, to:[UnicodeScalar(0x30D1)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30BB)!, UnicodeScalar(0x30F3)!, UnicodeScalar(0x30C8)!]) }
    if value == 0x332C { return (true, to:[UnicodeScalar(0x30D1)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30C4)!]) }
    if value == 0x332D { return (true, to:[UnicodeScalar(0x30D0)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30EC)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x332E { return (true, to:[UnicodeScalar(0x30D4)!, UnicodeScalar(0x30A2)!, UnicodeScalar(0x30B9)!, UnicodeScalar(0x30C8)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x332F { return (true, to:[UnicodeScalar(0x30D4)!, UnicodeScalar(0x30AF)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x3330 { return (true, to:[UnicodeScalar(0x30D4)!, UnicodeScalar(0x30B3)!]) }
    if value == 0x3331 { return (true, to:[UnicodeScalar(0x30D3)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x3332 { return (true, to:[UnicodeScalar(0x30D5)!, UnicodeScalar(0x30A1)!, UnicodeScalar(0x30E9)!, UnicodeScalar(0x30C3)!, UnicodeScalar(0x30C9)!]) }
    if value == 0x3333 { return (true, to:[UnicodeScalar(0x30D5)!, UnicodeScalar(0x30A3)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30C8)!]) }
    if value == 0x3334 { return (true, to:[UnicodeScalar(0x30D6)!, UnicodeScalar(0x30C3)!, UnicodeScalar(0x30B7)!, UnicodeScalar(0x30A7)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x3335 { return (true, to:[UnicodeScalar(0x30D5)!, UnicodeScalar(0x30E9)!, UnicodeScalar(0x30F3)!]) }
    if value == 0x3336 { return (true, to:[UnicodeScalar(0x30D8)!, UnicodeScalar(0x30AF)!, UnicodeScalar(0x30BF)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x3337 { return (true, to:[UnicodeScalar(0x30DA)!, UnicodeScalar(0x30BD)!]) }
    if value == 0x3338 { return (true, to:[UnicodeScalar(0x30DA)!, UnicodeScalar(0x30CB)!, UnicodeScalar(0x30D2)!]) }
    if value == 0x3339 { return (true, to:[UnicodeScalar(0x30D8)!, UnicodeScalar(0x30EB)!, UnicodeScalar(0x30C4)!]) }
    if value == 0x333A { return (true, to:[UnicodeScalar(0x30DA)!, UnicodeScalar(0x30F3)!, UnicodeScalar(0x30B9)!]) }
    if value == 0x333B { return (true, to:[UnicodeScalar(0x30DA)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30B8)!]) }
    if value == 0x333C { return (true, to:[UnicodeScalar(0x30D9)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30BF)!]) }
    if value == 0x333D { return (true, to:[UnicodeScalar(0x30DD)!, UnicodeScalar(0x30A4)!, UnicodeScalar(0x30F3)!, UnicodeScalar(0x30C8)!]) }
    if value == 0x333E { return (true, to:[UnicodeScalar(0x30DC)!, UnicodeScalar(0x30EB)!, UnicodeScalar(0x30C8)!]) }
    if value == 0x333F { return (true, to:[UnicodeScalar(0x30DB)!, UnicodeScalar(0x30F3)!]) }
    if value == 0x3340 { return (true, to:[UnicodeScalar(0x30DD)!, UnicodeScalar(0x30F3)!, UnicodeScalar(0x30C9)!]) }
    if value == 0x3341 { return (true, to:[UnicodeScalar(0x30DB)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x3342 { return (true, to:[UnicodeScalar(0x30DB)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30F3)!]) }
    if value == 0x3343 { return (true, to:[UnicodeScalar(0x30DE)!, UnicodeScalar(0x30A4)!, UnicodeScalar(0x30AF)!, UnicodeScalar(0x30ED)!]) }
    if value == 0x3344 { return (true, to:[UnicodeScalar(0x30DE)!, UnicodeScalar(0x30A4)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x3345 { return (true, to:[UnicodeScalar(0x30DE)!, UnicodeScalar(0x30C3)!, UnicodeScalar(0x30CF)!]) }
    if value == 0x3346 { return (true, to:[UnicodeScalar(0x30DE)!, UnicodeScalar(0x30EB)!, UnicodeScalar(0x30AF)!]) }
    if value == 0x3347 { return (true, to:[UnicodeScalar(0x30DE)!, UnicodeScalar(0x30F3)!, UnicodeScalar(0x30B7)!, UnicodeScalar(0x30E7)!, UnicodeScalar(0x30F3)!]) }
    if value == 0x3348 { return (true, to:[UnicodeScalar(0x30DF)!, UnicodeScalar(0x30AF)!, UnicodeScalar(0x30ED)!, UnicodeScalar(0x30F3)!]) }
    if value == 0x3349 { return (true, to:[UnicodeScalar(0x30DF)!, UnicodeScalar(0x30EA)!]) }
    if value == 0x334A { return (true, to:[UnicodeScalar(0x30DF)!, UnicodeScalar(0x30EA)!, UnicodeScalar(0x30D0)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x334B { return (true, to:[UnicodeScalar(0x30E1)!, UnicodeScalar(0x30AC)!]) }
    if value == 0x334C { return (true, to:[UnicodeScalar(0x30E1)!, UnicodeScalar(0x30AC)!, UnicodeScalar(0x30C8)!, UnicodeScalar(0x30F3)!]) }
    if value == 0x334D { return (true, to:[UnicodeScalar(0x30E1)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30C8)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x334E { return (true, to:[UnicodeScalar(0x30E4)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30C9)!]) }
    if value == 0x334F { return (true, to:[UnicodeScalar(0x30E4)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x3350 { return (true, to:[UnicodeScalar(0x30E6)!, UnicodeScalar(0x30A2)!, UnicodeScalar(0x30F3)!]) }
    if value == 0x3351 { return (true, to:[UnicodeScalar(0x30EA)!, UnicodeScalar(0x30C3)!, UnicodeScalar(0x30C8)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x3352 { return (true, to:[UnicodeScalar(0x30EA)!, UnicodeScalar(0x30E9)!]) }
    if value == 0x3353 { return (true, to:[UnicodeScalar(0x30EB)!, UnicodeScalar(0x30D4)!, UnicodeScalar(0x30FC)!]) }
    if value == 0x3354 { return (true, to:[UnicodeScalar(0x30EB)!, UnicodeScalar(0x30FC)!, UnicodeScalar(0x30D6)!, UnicodeScalar(0x30EB)!]) }
    if value == 0x3355 { return (true, to:[UnicodeScalar(0x30EC)!, UnicodeScalar(0x30E0)!]) }
    if value == 0x3356 { return (true, to:[UnicodeScalar(0x30EC)!, UnicodeScalar(0x30F3)!, UnicodeScalar(0x30C8)!, UnicodeScalar(0x30B2)!, UnicodeScalar(0x30F3)!]) }
    if value == 0x3357 { return (true, to:[UnicodeScalar(0x30EF)!, UnicodeScalar(0x30C3)!, UnicodeScalar(0x30C8)!]) }
    if value == 0x3358 { return (true, to:[UnicodeScalar(0x0030)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x3359 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x335A { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x335B { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x335C { return (true, to:[UnicodeScalar(0x0034)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x335D { return (true, to:[UnicodeScalar(0x0035)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x335E { return (true, to:[UnicodeScalar(0x0036)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x335F { return (true, to:[UnicodeScalar(0x0037)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x3360 { return (true, to:[UnicodeScalar(0x0038)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x3361 { return (true, to:[UnicodeScalar(0x0039)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x3362 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0030)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x3363 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x3364 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0032)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x3365 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0033)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x3366 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0034)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x3367 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0035)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x3368 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0036)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x3369 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0037)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x336A { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0038)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x336B { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0039)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x336C { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0030)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x336D { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x336E { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0032)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x336F { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0033)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x3370 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0034)!, UnicodeScalar(0x70B9)!]) }
    if value == 0x3371 { return (true, to:[UnicodeScalar(0x0068)!, UnicodeScalar(0x0070)!, UnicodeScalar(0x0061)!]) }
    if value == 0x3372 { return (true, to:[UnicodeScalar(0x0064)!, UnicodeScalar(0x0061)!]) }
    if value == 0x3373 { return (true, to:[UnicodeScalar(0x0061)!, UnicodeScalar(0x0075)!]) }
    if value == 0x3374 { return (true, to:[UnicodeScalar(0x0062)!, UnicodeScalar(0x0061)!, UnicodeScalar(0x0072)!]) }
    if value == 0x3375 { return (true, to:[UnicodeScalar(0x006F)!, UnicodeScalar(0x0076)!]) }
    if value == 0x3376 { return (true, to:[UnicodeScalar(0x0070)!, UnicodeScalar(0x0063)!]) }
    if value == 0x3377 { return (true, to:[UnicodeScalar(0x0064)!, UnicodeScalar(0x006D)!]) }
    if value == 0x3378 { return (true, to:[UnicodeScalar(0x0064)!, UnicodeScalar(0x006D)!, UnicodeScalar(0x0032)!]) }
    if value == 0x3379 { return (true, to:[UnicodeScalar(0x0064)!, UnicodeScalar(0x006D)!, UnicodeScalar(0x0033)!]) }
    if value == 0x337A { return (true, to:[UnicodeScalar(0x0069)!, UnicodeScalar(0x0075)!]) }
    if value == 0x337B { return (true, to:[UnicodeScalar(0x5E73)!, UnicodeScalar(0x6210)!]) }
    if value == 0x337C { return (true, to:[UnicodeScalar(0x662D)!, UnicodeScalar(0x548C)!]) }
    if value == 0x337D { return (true, to:[UnicodeScalar(0x5927)!, UnicodeScalar(0x6B63)!]) }
    if value == 0x337E { return (true, to:[UnicodeScalar(0x660E)!, UnicodeScalar(0x6CBB)!]) }
    if value == 0x337F { return (true, to:[UnicodeScalar(0x682A)!, UnicodeScalar(0x5F0F)!, UnicodeScalar(0x4F1A)!, UnicodeScalar(0x793E)!]) }
    if value == 0x3380 { return (true, to:[UnicodeScalar(0x0070)!, UnicodeScalar(0x0061)!]) }
    if value == 0x3381 { return (true, to:[UnicodeScalar(0x006E)!, UnicodeScalar(0x0061)!]) }
    if value == 0x3382 { return (true, to:[UnicodeScalar(0x03BC)!, UnicodeScalar(0x0061)!]) }
    if value == 0x3383 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0061)!]) }
    if value == 0x3384 { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x0061)!]) }
    if value == 0x3385 { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x0062)!]) }
    if value == 0x3386 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0062)!]) }
    if value == 0x3387 { return (true, to:[UnicodeScalar(0x0067)!, UnicodeScalar(0x0062)!]) }
    if value == 0x3388 { return (true, to:[UnicodeScalar(0x0063)!, UnicodeScalar(0x0061)!, UnicodeScalar(0x006C)!]) }
    if value == 0x3389 { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x0063)!, UnicodeScalar(0x0061)!, UnicodeScalar(0x006C)!]) }
    if value == 0x338A { return (true, to:[UnicodeScalar(0x0070)!, UnicodeScalar(0x0066)!]) }
    if value == 0x338B { return (true, to:[UnicodeScalar(0x006E)!, UnicodeScalar(0x0066)!]) }
    if value == 0x338C { return (true, to:[UnicodeScalar(0x03BC)!, UnicodeScalar(0x0066)!]) }
    if value == 0x338D { return (true, to:[UnicodeScalar(0x03BC)!, UnicodeScalar(0x0067)!]) }
    if value == 0x338E { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0067)!]) }
    if value == 0x338F { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x0067)!]) }
    if value == 0x3390 { return (true, to:[UnicodeScalar(0x0068)!, UnicodeScalar(0x007A)!]) }
    if value == 0x3391 { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x0068)!, UnicodeScalar(0x007A)!]) }
    if value == 0x3392 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0068)!, UnicodeScalar(0x007A)!]) }
    if value == 0x3393 { return (true, to:[UnicodeScalar(0x0067)!, UnicodeScalar(0x0068)!, UnicodeScalar(0x007A)!]) }
    if value == 0x3394 { return (true, to:[UnicodeScalar(0x0074)!, UnicodeScalar(0x0068)!, UnicodeScalar(0x007A)!]) }
    if value == 0x3395 { return (true, to:[UnicodeScalar(0x03BC)!, UnicodeScalar(0x006C)!]) }
    if value == 0x3396 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x006C)!]) }
    if value == 0x3397 { return (true, to:[UnicodeScalar(0x0064)!, UnicodeScalar(0x006C)!]) }
    if value == 0x3398 { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x006C)!]) }
    if value == 0x3399 { return (true, to:[UnicodeScalar(0x0066)!, UnicodeScalar(0x006D)!]) }
    if value == 0x339A { return (true, to:[UnicodeScalar(0x006E)!, UnicodeScalar(0x006D)!]) }
    if value == 0x339B { return (true, to:[UnicodeScalar(0x03BC)!, UnicodeScalar(0x006D)!]) }
    if value == 0x339C { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x006D)!]) }
    if value == 0x339D { return (true, to:[UnicodeScalar(0x0063)!, UnicodeScalar(0x006D)!]) }
    if value == 0x339E { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x006D)!]) }
    if value == 0x339F { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x006D)!, UnicodeScalar(0x0032)!]) }
    if value == 0x33A0 { return (true, to:[UnicodeScalar(0x0063)!, UnicodeScalar(0x006D)!, UnicodeScalar(0x0032)!]) }
    if value == 0x33A1 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0032)!]) }
    if value == 0x33A2 { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x006D)!, UnicodeScalar(0x0032)!]) }
    if value == 0x33A3 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x006D)!, UnicodeScalar(0x0033)!]) }
    if value == 0x33A4 { return (true, to:[UnicodeScalar(0x0063)!, UnicodeScalar(0x006D)!, UnicodeScalar(0x0033)!]) }
    if value == 0x33A5 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0033)!]) }
    if value == 0x33A6 { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x006D)!, UnicodeScalar(0x0033)!]) }
    if value == 0x33A7 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x2215)!, UnicodeScalar(0x0073)!]) }
    if value == 0x33A8 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x2215)!, UnicodeScalar(0x0073)!, UnicodeScalar(0x0032)!]) }
    if value == 0x33A9 { return (true, to:[UnicodeScalar(0x0070)!, UnicodeScalar(0x0061)!]) }
    if value == 0x33AA { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x0070)!, UnicodeScalar(0x0061)!]) }
    if value == 0x33AB { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0070)!, UnicodeScalar(0x0061)!]) }
    if value == 0x33AC { return (true, to:[UnicodeScalar(0x0067)!, UnicodeScalar(0x0070)!, UnicodeScalar(0x0061)!]) }
    if value == 0x33AD { return (true, to:[UnicodeScalar(0x0072)!, UnicodeScalar(0x0061)!, UnicodeScalar(0x0064)!]) }
    if value == 0x33AE { return (true, to:[UnicodeScalar(0x0072)!, UnicodeScalar(0x0061)!, UnicodeScalar(0x0064)!, UnicodeScalar(0x2215)!, UnicodeScalar(0x0073)!]) }
    if value == 0x33AF { return (true, to:[UnicodeScalar(0x0072)!, UnicodeScalar(0x0061)!, UnicodeScalar(0x0064)!, UnicodeScalar(0x2215)!, UnicodeScalar(0x0073)!, UnicodeScalar(0x0032)!]) }
    if value == 0x33B0 { return (true, to:[UnicodeScalar(0x0070)!, UnicodeScalar(0x0073)!]) }
    if value == 0x33B1 { return (true, to:[UnicodeScalar(0x006E)!, UnicodeScalar(0x0073)!]) }
    if value == 0x33B2 { return (true, to:[UnicodeScalar(0x03BC)!, UnicodeScalar(0x0073)!]) }
    if value == 0x33B3 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0073)!]) }
    if value == 0x33B4 { return (true, to:[UnicodeScalar(0x0070)!, UnicodeScalar(0x0076)!]) }
    if value == 0x33B5 { return (true, to:[UnicodeScalar(0x006E)!, UnicodeScalar(0x0076)!]) }
    if value == 0x33B6 { return (true, to:[UnicodeScalar(0x03BC)!, UnicodeScalar(0x0076)!]) }
    if value == 0x33B7 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0076)!]) }
    if value == 0x33B8 { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x0076)!]) }
    if value == 0x33B9 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0076)!]) }
    if value == 0x33BA { return (true, to:[UnicodeScalar(0x0070)!, UnicodeScalar(0x0077)!]) }
    if value == 0x33BB { return (true, to:[UnicodeScalar(0x006E)!, UnicodeScalar(0x0077)!]) }
    if value == 0x33BC { return (true, to:[UnicodeScalar(0x03BC)!, UnicodeScalar(0x0077)!]) }
    if value == 0x33BD { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0077)!]) }
    if value == 0x33BE { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x0077)!]) }
    if value == 0x33BF { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0077)!]) }
    if value == 0x33C0 { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x03C9)!]) }
    if value == 0x33C1 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x03C9)!]) }
    if value == 0x33C3 { return (true, to:[UnicodeScalar(0x0062)!, UnicodeScalar(0x0071)!]) }
    if value == 0x33C4 { return (true, to:[UnicodeScalar(0x0063)!, UnicodeScalar(0x0063)!]) }
    if value == 0x33C5 { return (true, to:[UnicodeScalar(0x0063)!, UnicodeScalar(0x0064)!]) }
    if value == 0x33C6 { return (true, to:[UnicodeScalar(0x0063)!, UnicodeScalar(0x2215)!, UnicodeScalar(0x006B)!, UnicodeScalar(0x0067)!]) }
    if value == 0x33C8 { return (true, to:[UnicodeScalar(0x0064)!, UnicodeScalar(0x0062)!]) }
    if value == 0x33C9 { return (true, to:[UnicodeScalar(0x0067)!, UnicodeScalar(0x0079)!]) }
    if value == 0x33CA { return (true, to:[UnicodeScalar(0x0068)!, UnicodeScalar(0x0061)!]) }
    if value == 0x33CB { return (true, to:[UnicodeScalar(0x0068)!, UnicodeScalar(0x0070)!]) }
    if value == 0x33CC { return (true, to:[UnicodeScalar(0x0069)!, UnicodeScalar(0x006E)!]) }
    if value == 0x33CD { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x006B)!]) }
    if value == 0x33CE { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x006D)!]) }
    if value == 0x33CF { return (true, to:[UnicodeScalar(0x006B)!, UnicodeScalar(0x0074)!]) }
    if value == 0x33D0 { return (true, to:[UnicodeScalar(0x006C)!, UnicodeScalar(0x006D)!]) }
    if value == 0x33D1 { return (true, to:[UnicodeScalar(0x006C)!, UnicodeScalar(0x006E)!]) }
    if value == 0x33D2 { return (true, to:[UnicodeScalar(0x006C)!, UnicodeScalar(0x006F)!, UnicodeScalar(0x0067)!]) }
    if value == 0x33D3 { return (true, to:[UnicodeScalar(0x006C)!, UnicodeScalar(0x0078)!]) }
    if value == 0x33D4 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0062)!]) }
    if value == 0x33D5 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0069)!, UnicodeScalar(0x006C)!]) }
    if value == 0x33D6 { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x006F)!, UnicodeScalar(0x006C)!]) }
    if value == 0x33D7 { return (true, to:[UnicodeScalar(0x0070)!, UnicodeScalar(0x0068)!]) }
    if value == 0x33D9 { return (true, to:[UnicodeScalar(0x0070)!, UnicodeScalar(0x0070)!, UnicodeScalar(0x006D)!]) }
    if value == 0x33DA { return (true, to:[UnicodeScalar(0x0070)!, UnicodeScalar(0x0072)!]) }
    if value == 0x33DB { return (true, to:[UnicodeScalar(0x0073)!, UnicodeScalar(0x0072)!]) }
    if value == 0x33DC { return (true, to:[UnicodeScalar(0x0073)!, UnicodeScalar(0x0076)!]) }
    if value == 0x33DD { return (true, to:[UnicodeScalar(0x0077)!, UnicodeScalar(0x0062)!]) }
    if value == 0x33DE { return (true, to:[UnicodeScalar(0x0076)!, UnicodeScalar(0x2215)!, UnicodeScalar(0x006D)!]) }
    if value == 0x33DF { return (true, to:[UnicodeScalar(0x0061)!, UnicodeScalar(0x2215)!, UnicodeScalar(0x006D)!]) }
    if value == 0x33E0 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33E1 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33E2 { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33E3 { return (true, to:[UnicodeScalar(0x0034)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33E4 { return (true, to:[UnicodeScalar(0x0035)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33E5 { return (true, to:[UnicodeScalar(0x0036)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33E6 { return (true, to:[UnicodeScalar(0x0037)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33E7 { return (true, to:[UnicodeScalar(0x0038)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33E8 { return (true, to:[UnicodeScalar(0x0039)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33E9 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0030)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33EA { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33EB { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0032)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33EC { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0033)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33ED { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0034)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33EE { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0035)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33EF { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0036)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33F0 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0037)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33F1 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0038)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33F2 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x0039)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33F3 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0030)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33F4 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33F5 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0032)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33F6 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0033)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33F7 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0034)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33F8 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0035)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33F9 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0036)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33FA { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0037)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33FB { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0038)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33FC { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x0039)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33FD { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x0030)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33FE { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x65E5)!]) }
    if value == 0x33FF { return (true, to:[UnicodeScalar(0x0067)!, UnicodeScalar(0x0061)!, UnicodeScalar(0x006C)!]) }
    if value == 0xA640 { return (true, to:[UnicodeScalar(0xA641)!]) }
    if value == 0xA642 { return (true, to:[UnicodeScalar(0xA643)!]) }
    if value == 0xA644 { return (true, to:[UnicodeScalar(0xA645)!]) }
    if value == 0xA646 { return (true, to:[UnicodeScalar(0xA647)!]) }
    if value == 0xA648 { return (true, to:[UnicodeScalar(0xA649)!]) }
    if value == 0xA64A { return (true, to:[UnicodeScalar(0xA64B)!]) }
    if value == 0xA64C { return (true, to:[UnicodeScalar(0xA64D)!]) }
    if value == 0xA64E { return (true, to:[UnicodeScalar(0xA64F)!]) }
    if value == 0xA650 { return (true, to:[UnicodeScalar(0xA651)!]) }
    if value == 0xA652 { return (true, to:[UnicodeScalar(0xA653)!]) }
    if value == 0xA654 { return (true, to:[UnicodeScalar(0xA655)!]) }
    if value == 0xA656 { return (true, to:[UnicodeScalar(0xA657)!]) }
    if value == 0xA658 { return (true, to:[UnicodeScalar(0xA659)!]) }
    if value == 0xA65A { return (true, to:[UnicodeScalar(0xA65B)!]) }
    if value == 0xA65C { return (true, to:[UnicodeScalar(0xA65D)!]) }
    if value == 0xA65E { return (true, to:[UnicodeScalar(0xA65F)!]) }
    if value == 0xA660 { return (true, to:[UnicodeScalar(0xA661)!]) }
    if value == 0xA662 { return (true, to:[UnicodeScalar(0xA663)!]) }
    if value == 0xA664 { return (true, to:[UnicodeScalar(0xA665)!]) }
    if value == 0xA666 { return (true, to:[UnicodeScalar(0xA667)!]) }
    if value == 0xA668 { return (true, to:[UnicodeScalar(0xA669)!]) }
    if value == 0xA66A { return (true, to:[UnicodeScalar(0xA66B)!]) }
    if value == 0xA66C { return (true, to:[UnicodeScalar(0xA66D)!]) }
    if value == 0xA680 { return (true, to:[UnicodeScalar(0xA681)!]) }
    if value == 0xA682 { return (true, to:[UnicodeScalar(0xA683)!]) }
    if value == 0xA684 { return (true, to:[UnicodeScalar(0xA685)!]) }
    if value == 0xA686 { return (true, to:[UnicodeScalar(0xA687)!]) }
    if value == 0xA688 { return (true, to:[UnicodeScalar(0xA689)!]) }
    if value == 0xA68A { return (true, to:[UnicodeScalar(0xA68B)!]) }
    if value == 0xA68C { return (true, to:[UnicodeScalar(0xA68D)!]) }
    if value == 0xA68E { return (true, to:[UnicodeScalar(0xA68F)!]) }
    if value == 0xA690 { return (true, to:[UnicodeScalar(0xA691)!]) }
    if value == 0xA692 { return (true, to:[UnicodeScalar(0xA693)!]) }
    if value == 0xA694 { return (true, to:[UnicodeScalar(0xA695)!]) }
    if value == 0xA696 { return (true, to:[UnicodeScalar(0xA697)!]) }
    if value == 0xA698 { return (true, to:[UnicodeScalar(0xA699)!]) }
    if value == 0xA69A { return (true, to:[UnicodeScalar(0xA69B)!]) }
    if value == 0xA69C { return (true, to:[UnicodeScalar(0x044A)!]) }
    if value == 0xA69D { return (true, to:[UnicodeScalar(0x044C)!]) }
    if value == 0xA722 { return (true, to:[UnicodeScalar(0xA723)!]) }
    if value == 0xA724 { return (true, to:[UnicodeScalar(0xA725)!]) }
    if value == 0xA726 { return (true, to:[UnicodeScalar(0xA727)!]) }
    if value == 0xA728 { return (true, to:[UnicodeScalar(0xA729)!]) }
    if value == 0xA72A { return (true, to:[UnicodeScalar(0xA72B)!]) }
    if value == 0xA72C { return (true, to:[UnicodeScalar(0xA72D)!]) }
    if value == 0xA72E { return (true, to:[UnicodeScalar(0xA72F)!]) }
    if value == 0xA732 { return (true, to:[UnicodeScalar(0xA733)!]) }
    if value == 0xA734 { return (true, to:[UnicodeScalar(0xA735)!]) }
    if value == 0xA736 { return (true, to:[UnicodeScalar(0xA737)!]) }
    if value == 0xA738 { return (true, to:[UnicodeScalar(0xA739)!]) }
    if value == 0xA73A { return (true, to:[UnicodeScalar(0xA73B)!]) }
    if value == 0xA73C { return (true, to:[UnicodeScalar(0xA73D)!]) }
    if value == 0xA73E { return (true, to:[UnicodeScalar(0xA73F)!]) }
    if value == 0xA740 { return (true, to:[UnicodeScalar(0xA741)!]) }
    if value == 0xA742 { return (true, to:[UnicodeScalar(0xA743)!]) }
    if value == 0xA744 { return (true, to:[UnicodeScalar(0xA745)!]) }
    if value == 0xA746 { return (true, to:[UnicodeScalar(0xA747)!]) }
    if value == 0xA748 { return (true, to:[UnicodeScalar(0xA749)!]) }
    if value == 0xA74A { return (true, to:[UnicodeScalar(0xA74B)!]) }
    if value == 0xA74C { return (true, to:[UnicodeScalar(0xA74D)!]) }
    if value == 0xA74E { return (true, to:[UnicodeScalar(0xA74F)!]) }
    if value == 0xA750 { return (true, to:[UnicodeScalar(0xA751)!]) }
    if value == 0xA752 { return (true, to:[UnicodeScalar(0xA753)!]) }
    if value == 0xA754 { return (true, to:[UnicodeScalar(0xA755)!]) }
    if value == 0xA756 { return (true, to:[UnicodeScalar(0xA757)!]) }
    if value == 0xA758 { return (true, to:[UnicodeScalar(0xA759)!]) }
    if value == 0xA75A { return (true, to:[UnicodeScalar(0xA75B)!]) }
    if value == 0xA75C { return (true, to:[UnicodeScalar(0xA75D)!]) }
    if value == 0xA75E { return (true, to:[UnicodeScalar(0xA75F)!]) }
    if value == 0xA760 { return (true, to:[UnicodeScalar(0xA761)!]) }
    if value == 0xA762 { return (true, to:[UnicodeScalar(0xA763)!]) }
    if value == 0xA764 { return (true, to:[UnicodeScalar(0xA765)!]) }
    if value == 0xA766 { return (true, to:[UnicodeScalar(0xA767)!]) }
    if value == 0xA768 { return (true, to:[UnicodeScalar(0xA769)!]) }
    if value == 0xA76A { return (true, to:[UnicodeScalar(0xA76B)!]) }
    if value == 0xA76C { return (true, to:[UnicodeScalar(0xA76D)!]) }
    if value == 0xA76E { return (true, to:[UnicodeScalar(0xA76F)!]) }
    if value == 0xA770 { return (true, to:[UnicodeScalar(0xA76F)!]) }
    if value == 0xA779 { return (true, to:[UnicodeScalar(0xA77A)!]) }
    if value == 0xA77B { return (true, to:[UnicodeScalar(0xA77C)!]) }
    if value == 0xA77D { return (true, to:[UnicodeScalar(0x1D79)!]) }
    if value == 0xA77E { return (true, to:[UnicodeScalar(0xA77F)!]) }
    if value == 0xA780 { return (true, to:[UnicodeScalar(0xA781)!]) }
    if value == 0xA782 { return (true, to:[UnicodeScalar(0xA783)!]) }
    if value == 0xA784 { return (true, to:[UnicodeScalar(0xA785)!]) }
    if value == 0xA786 { return (true, to:[UnicodeScalar(0xA787)!]) }
    if value == 0xA78B { return (true, to:[UnicodeScalar(0xA78C)!]) }
    if value == 0xA78D { return (true, to:[UnicodeScalar(0x0265)!]) }
    if value == 0xA790 { return (true, to:[UnicodeScalar(0xA791)!]) }
    if value == 0xA792 { return (true, to:[UnicodeScalar(0xA793)!]) }
    if value == 0xA796 { return (true, to:[UnicodeScalar(0xA797)!]) }
    if value == 0xA798 { return (true, to:[UnicodeScalar(0xA799)!]) }
    if value == 0xA79A { return (true, to:[UnicodeScalar(0xA79B)!]) }
    if value == 0xA79C { return (true, to:[UnicodeScalar(0xA79D)!]) }
    if value == 0xA79E { return (true, to:[UnicodeScalar(0xA79F)!]) }
    if value == 0xA7A0 { return (true, to:[UnicodeScalar(0xA7A1)!]) }
    if value == 0xA7A2 { return (true, to:[UnicodeScalar(0xA7A3)!]) }
    if value == 0xA7A4 { return (true, to:[UnicodeScalar(0xA7A5)!]) }
    if value == 0xA7A6 { return (true, to:[UnicodeScalar(0xA7A7)!]) }
    if value == 0xA7A8 { return (true, to:[UnicodeScalar(0xA7A9)!]) }
    if value == 0xA7AA { return (true, to:[UnicodeScalar(0x0266)!]) }
    if value == 0xA7AB { return (true, to:[UnicodeScalar(0x025C)!]) }
    if value == 0xA7AC { return (true, to:[UnicodeScalar(0x0261)!]) }
    if value == 0xA7AD { return (true, to:[UnicodeScalar(0x026C)!]) }
    if value == 0xA7AE { return (true, to:[UnicodeScalar(0x026A)!]) }
    if value == 0xA7B0 { return (true, to:[UnicodeScalar(0x029E)!]) }
    if value == 0xA7B1 { return (true, to:[UnicodeScalar(0x0287)!]) }
    if value == 0xA7B2 { return (true, to:[UnicodeScalar(0x029D)!]) }
    if value == 0xA7B3 { return (true, to:[UnicodeScalar(0xAB53)!]) }
    if value == 0xA7B4 { return (true, to:[UnicodeScalar(0xA7B5)!]) }
    if value == 0xA7B6 { return (true, to:[UnicodeScalar(0xA7B7)!]) }
    if value == 0xA7F8 { return (true, to:[UnicodeScalar(0x0127)!]) }
    if value == 0xA7F9 { return (true, to:[UnicodeScalar(0x0153)!]) }
    if value == 0xAB5C { return (true, to:[UnicodeScalar(0xA727)!]) }
    if value == 0xAB5D { return (true, to:[UnicodeScalar(0xAB37)!]) }
    if value == 0xAB5E { return (true, to:[UnicodeScalar(0x026B)!]) }
    if value == 0xAB5F { return (true, to:[UnicodeScalar(0xAB52)!]) }
    if value == 0xAB70 { return (true, to:[UnicodeScalar(0x13A0)!]) }
    if value == 0xAB71 { return (true, to:[UnicodeScalar(0x13A1)!]) }
    if value == 0xAB72 { return (true, to:[UnicodeScalar(0x13A2)!]) }
    if value == 0xAB73 { return (true, to:[UnicodeScalar(0x13A3)!]) }
    if value == 0xAB74 { return (true, to:[UnicodeScalar(0x13A4)!]) }
    if value == 0xAB75 { return (true, to:[UnicodeScalar(0x13A5)!]) }
    if value == 0xAB76 { return (true, to:[UnicodeScalar(0x13A6)!]) }
    if value == 0xAB77 { return (true, to:[UnicodeScalar(0x13A7)!]) }
    if value == 0xAB78 { return (true, to:[UnicodeScalar(0x13A8)!]) }
    if value == 0xAB79 { return (true, to:[UnicodeScalar(0x13A9)!]) }
    if value == 0xAB7A { return (true, to:[UnicodeScalar(0x13AA)!]) }
    if value == 0xAB7B { return (true, to:[UnicodeScalar(0x13AB)!]) }
    if value == 0xAB7C { return (true, to:[UnicodeScalar(0x13AC)!]) }
    if value == 0xAB7D { return (true, to:[UnicodeScalar(0x13AD)!]) }
    if value == 0xAB7E { return (true, to:[UnicodeScalar(0x13AE)!]) }
    if value == 0xAB7F { return (true, to:[UnicodeScalar(0x13AF)!]) }
    if value == 0xAB80 { return (true, to:[UnicodeScalar(0x13B0)!]) }
    if value == 0xAB81 { return (true, to:[UnicodeScalar(0x13B1)!]) }
    if value == 0xAB82 { return (true, to:[UnicodeScalar(0x13B2)!]) }
    if value == 0xAB83 { return (true, to:[UnicodeScalar(0x13B3)!]) }
    if value == 0xAB84 { return (true, to:[UnicodeScalar(0x13B4)!]) }
    if value == 0xAB85 { return (true, to:[UnicodeScalar(0x13B5)!]) }
    if value == 0xAB86 { return (true, to:[UnicodeScalar(0x13B6)!]) }
    if value == 0xAB87 { return (true, to:[UnicodeScalar(0x13B7)!]) }
    if value == 0xAB88 { return (true, to:[UnicodeScalar(0x13B8)!]) }
    if value == 0xAB89 { return (true, to:[UnicodeScalar(0x13B9)!]) }
    if value == 0xAB8A { return (true, to:[UnicodeScalar(0x13BA)!]) }
    if value == 0xAB8B { return (true, to:[UnicodeScalar(0x13BB)!]) }
    if value == 0xAB8C { return (true, to:[UnicodeScalar(0x13BC)!]) }
    if value == 0xAB8D { return (true, to:[UnicodeScalar(0x13BD)!]) }
    if value == 0xAB8E { return (true, to:[UnicodeScalar(0x13BE)!]) }
    if value == 0xAB8F { return (true, to:[UnicodeScalar(0x13BF)!]) }
    if value == 0xAB90 { return (true, to:[UnicodeScalar(0x13C0)!]) }
    if value == 0xAB91 { return (true, to:[UnicodeScalar(0x13C1)!]) }
    if value == 0xAB92 { return (true, to:[UnicodeScalar(0x13C2)!]) }
    if value == 0xAB93 { return (true, to:[UnicodeScalar(0x13C3)!]) }
    if value == 0xAB94 { return (true, to:[UnicodeScalar(0x13C4)!]) }
    if value == 0xAB95 { return (true, to:[UnicodeScalar(0x13C5)!]) }
    if value == 0xAB96 { return (true, to:[UnicodeScalar(0x13C6)!]) }
    if value == 0xAB97 { return (true, to:[UnicodeScalar(0x13C7)!]) }
    if value == 0xAB98 { return (true, to:[UnicodeScalar(0x13C8)!]) }
    if value == 0xAB99 { return (true, to:[UnicodeScalar(0x13C9)!]) }
    if value == 0xAB9A { return (true, to:[UnicodeScalar(0x13CA)!]) }
    if value == 0xAB9B { return (true, to:[UnicodeScalar(0x13CB)!]) }
    if value == 0xAB9C { return (true, to:[UnicodeScalar(0x13CC)!]) }
    if value == 0xAB9D { return (true, to:[UnicodeScalar(0x13CD)!]) }
    if value == 0xAB9E { return (true, to:[UnicodeScalar(0x13CE)!]) }
    if value == 0xAB9F { return (true, to:[UnicodeScalar(0x13CF)!]) }
    if value == 0xABA0 { return (true, to:[UnicodeScalar(0x13D0)!]) }
    if value == 0xABA1 { return (true, to:[UnicodeScalar(0x13D1)!]) }
    if value == 0xABA2 { return (true, to:[UnicodeScalar(0x13D2)!]) }
    if value == 0xABA3 { return (true, to:[UnicodeScalar(0x13D3)!]) }
    if value == 0xABA4 { return (true, to:[UnicodeScalar(0x13D4)!]) }
    if value == 0xABA5 { return (true, to:[UnicodeScalar(0x13D5)!]) }
    if value == 0xABA6 { return (true, to:[UnicodeScalar(0x13D6)!]) }
    if value == 0xABA7 { return (true, to:[UnicodeScalar(0x13D7)!]) }
    if value == 0xABA8 { return (true, to:[UnicodeScalar(0x13D8)!]) }
    if value == 0xABA9 { return (true, to:[UnicodeScalar(0x13D9)!]) }
    if value == 0xABAA { return (true, to:[UnicodeScalar(0x13DA)!]) }
    if value == 0xABAB { return (true, to:[UnicodeScalar(0x13DB)!]) }
    if value == 0xABAC { return (true, to:[UnicodeScalar(0x13DC)!]) }
    if value == 0xABAD { return (true, to:[UnicodeScalar(0x13DD)!]) }
    if value == 0xABAE { return (true, to:[UnicodeScalar(0x13DE)!]) }
    if value == 0xABAF { return (true, to:[UnicodeScalar(0x13DF)!]) }
    if value == 0xABB0 { return (true, to:[UnicodeScalar(0x13E0)!]) }
    if value == 0xABB1 { return (true, to:[UnicodeScalar(0x13E1)!]) }
    if value == 0xABB2 { return (true, to:[UnicodeScalar(0x13E2)!]) }
    if value == 0xABB3 { return (true, to:[UnicodeScalar(0x13E3)!]) }
    if value == 0xABB4 { return (true, to:[UnicodeScalar(0x13E4)!]) }
    if value == 0xABB5 { return (true, to:[UnicodeScalar(0x13E5)!]) }
    if value == 0xABB6 { return (true, to:[UnicodeScalar(0x13E6)!]) }
    if value == 0xABB7 { return (true, to:[UnicodeScalar(0x13E7)!]) }
    if value == 0xABB8 { return (true, to:[UnicodeScalar(0x13E8)!]) }
    if value == 0xABB9 { return (true, to:[UnicodeScalar(0x13E9)!]) }
    if value == 0xABBA { return (true, to:[UnicodeScalar(0x13EA)!]) }
    if value == 0xABBB { return (true, to:[UnicodeScalar(0x13EB)!]) }
    if value == 0xABBC { return (true, to:[UnicodeScalar(0x13EC)!]) }
    if value == 0xABBD { return (true, to:[UnicodeScalar(0x13ED)!]) }
    if value == 0xABBE { return (true, to:[UnicodeScalar(0x13EE)!]) }
    if value == 0xABBF { return (true, to:[UnicodeScalar(0x13EF)!]) }
    if value == 0xF900 { return (true, to:[UnicodeScalar(0x8C48)!]) }
    if value == 0xF901 { return (true, to:[UnicodeScalar(0x66F4)!]) }
    if value == 0xF902 { return (true, to:[UnicodeScalar(0x8ECA)!]) }
    if value == 0xF903 { return (true, to:[UnicodeScalar(0x8CC8)!]) }
    if value == 0xF904 { return (true, to:[UnicodeScalar(0x6ED1)!]) }
    if value == 0xF905 { return (true, to:[UnicodeScalar(0x4E32)!]) }
    if value == 0xF906 { return (true, to:[UnicodeScalar(0x53E5)!]) }
    if (0xF907 <= value && value <= 0xF908) { return (true, to:[UnicodeScalar(0x9F9C)!]) }
    if value == 0xF909 { return (true, to:[UnicodeScalar(0x5951)!]) }
    if value == 0xF90A { return (true, to:[UnicodeScalar(0x91D1)!]) }
    if value == 0xF90B { return (true, to:[UnicodeScalar(0x5587)!]) }
    if value == 0xF90C { return (true, to:[UnicodeScalar(0x5948)!]) }
    if value == 0xF90D { return (true, to:[UnicodeScalar(0x61F6)!]) }
    if value == 0xF90E { return (true, to:[UnicodeScalar(0x7669)!]) }
    if value == 0xF90F { return (true, to:[UnicodeScalar(0x7F85)!]) }
    if value == 0xF910 { return (true, to:[UnicodeScalar(0x863F)!]) }
    if value == 0xF911 { return (true, to:[UnicodeScalar(0x87BA)!]) }
    if value == 0xF912 { return (true, to:[UnicodeScalar(0x88F8)!]) }
    if value == 0xF913 { return (true, to:[UnicodeScalar(0x908F)!]) }
    if value == 0xF914 { return (true, to:[UnicodeScalar(0x6A02)!]) }
    if value == 0xF915 { return (true, to:[UnicodeScalar(0x6D1B)!]) }
    if value == 0xF916 { return (true, to:[UnicodeScalar(0x70D9)!]) }
    if value == 0xF917 { return (true, to:[UnicodeScalar(0x73DE)!]) }
    if value == 0xF918 { return (true, to:[UnicodeScalar(0x843D)!]) }
    if value == 0xF919 { return (true, to:[UnicodeScalar(0x916A)!]) }
    if value == 0xF91A { return (true, to:[UnicodeScalar(0x99F1)!]) }
    if value == 0xF91B { return (true, to:[UnicodeScalar(0x4E82)!]) }
    if value == 0xF91C { return (true, to:[UnicodeScalar(0x5375)!]) }
    if value == 0xF91D { return (true, to:[UnicodeScalar(0x6B04)!]) }
    if value == 0xF91E { return (true, to:[UnicodeScalar(0x721B)!]) }
    if value == 0xF91F { return (true, to:[UnicodeScalar(0x862D)!]) }
    if value == 0xF920 { return (true, to:[UnicodeScalar(0x9E1E)!]) }
    if value == 0xF921 { return (true, to:[UnicodeScalar(0x5D50)!]) }
    if value == 0xF922 { return (true, to:[UnicodeScalar(0x6FEB)!]) }
    if value == 0xF923 { return (true, to:[UnicodeScalar(0x85CD)!]) }
    if value == 0xF924 { return (true, to:[UnicodeScalar(0x8964)!]) }
    if value == 0xF925 { return (true, to:[UnicodeScalar(0x62C9)!]) }
    if value == 0xF926 { return (true, to:[UnicodeScalar(0x81D8)!]) }
    if value == 0xF927 { return (true, to:[UnicodeScalar(0x881F)!]) }
    if value == 0xF928 { return (true, to:[UnicodeScalar(0x5ECA)!]) }
    if value == 0xF929 { return (true, to:[UnicodeScalar(0x6717)!]) }
    if value == 0xF92A { return (true, to:[UnicodeScalar(0x6D6A)!]) }
    if value == 0xF92B { return (true, to:[UnicodeScalar(0x72FC)!]) }
    if value == 0xF92C { return (true, to:[UnicodeScalar(0x90CE)!]) }
    if value == 0xF92D { return (true, to:[UnicodeScalar(0x4F86)!]) }
    if value == 0xF92E { return (true, to:[UnicodeScalar(0x51B7)!]) }
    if value == 0xF92F { return (true, to:[UnicodeScalar(0x52DE)!]) }
    if value == 0xF930 { return (true, to:[UnicodeScalar(0x64C4)!]) }
    if value == 0xF931 { return (true, to:[UnicodeScalar(0x6AD3)!]) }
    if value == 0xF932 { return (true, to:[UnicodeScalar(0x7210)!]) }
    if value == 0xF933 { return (true, to:[UnicodeScalar(0x76E7)!]) }
    if value == 0xF934 { return (true, to:[UnicodeScalar(0x8001)!]) }
    if value == 0xF935 { return (true, to:[UnicodeScalar(0x8606)!]) }
    if value == 0xF936 { return (true, to:[UnicodeScalar(0x865C)!]) }
    if value == 0xF937 { return (true, to:[UnicodeScalar(0x8DEF)!]) }
    if value == 0xF938 { return (true, to:[UnicodeScalar(0x9732)!]) }
    if value == 0xF939 { return (true, to:[UnicodeScalar(0x9B6F)!]) }
    if value == 0xF93A { return (true, to:[UnicodeScalar(0x9DFA)!]) }
    if value == 0xF93B { return (true, to:[UnicodeScalar(0x788C)!]) }
    if value == 0xF93C { return (true, to:[UnicodeScalar(0x797F)!]) }
    if value == 0xF93D { return (true, to:[UnicodeScalar(0x7DA0)!]) }
    if value == 0xF93E { return (true, to:[UnicodeScalar(0x83C9)!]) }
    if value == 0xF93F { return (true, to:[UnicodeScalar(0x9304)!]) }
    if value == 0xF940 { return (true, to:[UnicodeScalar(0x9E7F)!]) }
    if value == 0xF941 { return (true, to:[UnicodeScalar(0x8AD6)!]) }
    if value == 0xF942 { return (true, to:[UnicodeScalar(0x58DF)!]) }
    if value == 0xF943 { return (true, to:[UnicodeScalar(0x5F04)!]) }
    if value == 0xF944 { return (true, to:[UnicodeScalar(0x7C60)!]) }
    if value == 0xF945 { return (true, to:[UnicodeScalar(0x807E)!]) }
    if value == 0xF946 { return (true, to:[UnicodeScalar(0x7262)!]) }
    if value == 0xF947 { return (true, to:[UnicodeScalar(0x78CA)!]) }
    if value == 0xF948 { return (true, to:[UnicodeScalar(0x8CC2)!]) }
    if value == 0xF949 { return (true, to:[UnicodeScalar(0x96F7)!]) }
    if value == 0xF94A { return (true, to:[UnicodeScalar(0x58D8)!]) }
    if value == 0xF94B { return (true, to:[UnicodeScalar(0x5C62)!]) }
    if value == 0xF94C { return (true, to:[UnicodeScalar(0x6A13)!]) }
    if value == 0xF94D { return (true, to:[UnicodeScalar(0x6DDA)!]) }
    if value == 0xF94E { return (true, to:[UnicodeScalar(0x6F0F)!]) }
    if value == 0xF94F { return (true, to:[UnicodeScalar(0x7D2F)!]) }
    if value == 0xF950 { return (true, to:[UnicodeScalar(0x7E37)!]) }
    if value == 0xF951 { return (true, to:[UnicodeScalar(0x964B)!]) }
    if value == 0xF952 { return (true, to:[UnicodeScalar(0x52D2)!]) }
    if value == 0xF953 { return (true, to:[UnicodeScalar(0x808B)!]) }
    if value == 0xF954 { return (true, to:[UnicodeScalar(0x51DC)!]) }
    if value == 0xF955 { return (true, to:[UnicodeScalar(0x51CC)!]) }
    if value == 0xF956 { return (true, to:[UnicodeScalar(0x7A1C)!]) }
    if value == 0xF957 { return (true, to:[UnicodeScalar(0x7DBE)!]) }
    if value == 0xF958 { return (true, to:[UnicodeScalar(0x83F1)!]) }
    if value == 0xF959 { return (true, to:[UnicodeScalar(0x9675)!]) }
    if value == 0xF95A { return (true, to:[UnicodeScalar(0x8B80)!]) }
    if value == 0xF95B { return (true, to:[UnicodeScalar(0x62CF)!]) }
    if value == 0xF95C { return (true, to:[UnicodeScalar(0x6A02)!]) }
    if value == 0xF95D { return (true, to:[UnicodeScalar(0x8AFE)!]) }
    if value == 0xF95E { return (true, to:[UnicodeScalar(0x4E39)!]) }
    if value == 0xF95F { return (true, to:[UnicodeScalar(0x5BE7)!]) }
    if value == 0xF960 { return (true, to:[UnicodeScalar(0x6012)!]) }
    if value == 0xF961 { return (true, to:[UnicodeScalar(0x7387)!]) }
    if value == 0xF962 { return (true, to:[UnicodeScalar(0x7570)!]) }
    if value == 0xF963 { return (true, to:[UnicodeScalar(0x5317)!]) }
    if value == 0xF964 { return (true, to:[UnicodeScalar(0x78FB)!]) }
    if value == 0xF965 { return (true, to:[UnicodeScalar(0x4FBF)!]) }
    if value == 0xF966 { return (true, to:[UnicodeScalar(0x5FA9)!]) }
    if value == 0xF967 { return (true, to:[UnicodeScalar(0x4E0D)!]) }
    if value == 0xF968 { return (true, to:[UnicodeScalar(0x6CCC)!]) }
    if value == 0xF969 { return (true, to:[UnicodeScalar(0x6578)!]) }
    if value == 0xF96A { return (true, to:[UnicodeScalar(0x7D22)!]) }
    if value == 0xF96B { return (true, to:[UnicodeScalar(0x53C3)!]) }
    if value == 0xF96C { return (true, to:[UnicodeScalar(0x585E)!]) }
    if value == 0xF96D { return (true, to:[UnicodeScalar(0x7701)!]) }
    if value == 0xF96E { return (true, to:[UnicodeScalar(0x8449)!]) }
    if value == 0xF96F { return (true, to:[UnicodeScalar(0x8AAA)!]) }
    if value == 0xF970 { return (true, to:[UnicodeScalar(0x6BBA)!]) }
    if value == 0xF971 { return (true, to:[UnicodeScalar(0x8FB0)!]) }
    if value == 0xF972 { return (true, to:[UnicodeScalar(0x6C88)!]) }
    if value == 0xF973 { return (true, to:[UnicodeScalar(0x62FE)!]) }
    if value == 0xF974 { return (true, to:[UnicodeScalar(0x82E5)!]) }
    if value == 0xF975 { return (true, to:[UnicodeScalar(0x63A0)!]) }
    if value == 0xF976 { return (true, to:[UnicodeScalar(0x7565)!]) }
    if value == 0xF977 { return (true, to:[UnicodeScalar(0x4EAE)!]) }
    if value == 0xF978 { return (true, to:[UnicodeScalar(0x5169)!]) }
    if value == 0xF979 { return (true, to:[UnicodeScalar(0x51C9)!]) }
    if value == 0xF97A { return (true, to:[UnicodeScalar(0x6881)!]) }
    if value == 0xF97B { return (true, to:[UnicodeScalar(0x7CE7)!]) }
    if value == 0xF97C { return (true, to:[UnicodeScalar(0x826F)!]) }
    if value == 0xF97D { return (true, to:[UnicodeScalar(0x8AD2)!]) }
    if value == 0xF97E { return (true, to:[UnicodeScalar(0x91CF)!]) }
    if value == 0xF97F { return (true, to:[UnicodeScalar(0x52F5)!]) }
    if value == 0xF980 { return (true, to:[UnicodeScalar(0x5442)!]) }
    if value == 0xF981 { return (true, to:[UnicodeScalar(0x5973)!]) }
    if value == 0xF982 { return (true, to:[UnicodeScalar(0x5EEC)!]) }
    if value == 0xF983 { return (true, to:[UnicodeScalar(0x65C5)!]) }
    if value == 0xF984 { return (true, to:[UnicodeScalar(0x6FFE)!]) }
    if value == 0xF985 { return (true, to:[UnicodeScalar(0x792A)!]) }
    if value == 0xF986 { return (true, to:[UnicodeScalar(0x95AD)!]) }
    if value == 0xF987 { return (true, to:[UnicodeScalar(0x9A6A)!]) }
    if value == 0xF988 { return (true, to:[UnicodeScalar(0x9E97)!]) }
    if value == 0xF989 { return (true, to:[UnicodeScalar(0x9ECE)!]) }
    if value == 0xF98A { return (true, to:[UnicodeScalar(0x529B)!]) }
    if value == 0xF98B { return (true, to:[UnicodeScalar(0x66C6)!]) }
    if value == 0xF98C { return (true, to:[UnicodeScalar(0x6B77)!]) }
    if value == 0xF98D { return (true, to:[UnicodeScalar(0x8F62)!]) }
    if value == 0xF98E { return (true, to:[UnicodeScalar(0x5E74)!]) }
    if value == 0xF98F { return (true, to:[UnicodeScalar(0x6190)!]) }
    if value == 0xF990 { return (true, to:[UnicodeScalar(0x6200)!]) }
    if value == 0xF991 { return (true, to:[UnicodeScalar(0x649A)!]) }
    if value == 0xF992 { return (true, to:[UnicodeScalar(0x6F23)!]) }
    if value == 0xF993 { return (true, to:[UnicodeScalar(0x7149)!]) }
    if value == 0xF994 { return (true, to:[UnicodeScalar(0x7489)!]) }
    if value == 0xF995 { return (true, to:[UnicodeScalar(0x79CA)!]) }
    if value == 0xF996 { return (true, to:[UnicodeScalar(0x7DF4)!]) }
    if value == 0xF997 { return (true, to:[UnicodeScalar(0x806F)!]) }
    if value == 0xF998 { return (true, to:[UnicodeScalar(0x8F26)!]) }
    if value == 0xF999 { return (true, to:[UnicodeScalar(0x84EE)!]) }
    if value == 0xF99A { return (true, to:[UnicodeScalar(0x9023)!]) }
    if value == 0xF99B { return (true, to:[UnicodeScalar(0x934A)!]) }
    if value == 0xF99C { return (true, to:[UnicodeScalar(0x5217)!]) }
    if value == 0xF99D { return (true, to:[UnicodeScalar(0x52A3)!]) }
    if value == 0xF99E { return (true, to:[UnicodeScalar(0x54BD)!]) }
    if value == 0xF99F { return (true, to:[UnicodeScalar(0x70C8)!]) }
    if value == 0xF9A0 { return (true, to:[UnicodeScalar(0x88C2)!]) }
    if value == 0xF9A1 { return (true, to:[UnicodeScalar(0x8AAA)!]) }
    if value == 0xF9A2 { return (true, to:[UnicodeScalar(0x5EC9)!]) }
    if value == 0xF9A3 { return (true, to:[UnicodeScalar(0x5FF5)!]) }
    if value == 0xF9A4 { return (true, to:[UnicodeScalar(0x637B)!]) }
    if value == 0xF9A5 { return (true, to:[UnicodeScalar(0x6BAE)!]) }
    if value == 0xF9A6 { return (true, to:[UnicodeScalar(0x7C3E)!]) }
    if value == 0xF9A7 { return (true, to:[UnicodeScalar(0x7375)!]) }
    if value == 0xF9A8 { return (true, to:[UnicodeScalar(0x4EE4)!]) }
    if value == 0xF9A9 { return (true, to:[UnicodeScalar(0x56F9)!]) }
    if value == 0xF9AA { return (true, to:[UnicodeScalar(0x5BE7)!]) }
    if value == 0xF9AB { return (true, to:[UnicodeScalar(0x5DBA)!]) }
    if value == 0xF9AC { return (true, to:[UnicodeScalar(0x601C)!]) }
    if value == 0xF9AD { return (true, to:[UnicodeScalar(0x73B2)!]) }
    if value == 0xF9AE { return (true, to:[UnicodeScalar(0x7469)!]) }
    if value == 0xF9AF { return (true, to:[UnicodeScalar(0x7F9A)!]) }
    if value == 0xF9B0 { return (true, to:[UnicodeScalar(0x8046)!]) }
    if value == 0xF9B1 { return (true, to:[UnicodeScalar(0x9234)!]) }
    if value == 0xF9B2 { return (true, to:[UnicodeScalar(0x96F6)!]) }
    if value == 0xF9B3 { return (true, to:[UnicodeScalar(0x9748)!]) }
    if value == 0xF9B4 { return (true, to:[UnicodeScalar(0x9818)!]) }
    if value == 0xF9B5 { return (true, to:[UnicodeScalar(0x4F8B)!]) }
    if value == 0xF9B6 { return (true, to:[UnicodeScalar(0x79AE)!]) }
    if value == 0xF9B7 { return (true, to:[UnicodeScalar(0x91B4)!]) }
    if value == 0xF9B8 { return (true, to:[UnicodeScalar(0x96B8)!]) }
    if value == 0xF9B9 { return (true, to:[UnicodeScalar(0x60E1)!]) }
    if value == 0xF9BA { return (true, to:[UnicodeScalar(0x4E86)!]) }
    if value == 0xF9BB { return (true, to:[UnicodeScalar(0x50DA)!]) }
    if value == 0xF9BC { return (true, to:[UnicodeScalar(0x5BEE)!]) }
    if value == 0xF9BD { return (true, to:[UnicodeScalar(0x5C3F)!]) }
    if value == 0xF9BE { return (true, to:[UnicodeScalar(0x6599)!]) }
    if value == 0xF9BF { return (true, to:[UnicodeScalar(0x6A02)!]) }
    if value == 0xF9C0 { return (true, to:[UnicodeScalar(0x71CE)!]) }
    if value == 0xF9C1 { return (true, to:[UnicodeScalar(0x7642)!]) }
    if value == 0xF9C2 { return (true, to:[UnicodeScalar(0x84FC)!]) }
    if value == 0xF9C3 { return (true, to:[UnicodeScalar(0x907C)!]) }
    if value == 0xF9C4 { return (true, to:[UnicodeScalar(0x9F8D)!]) }
    if value == 0xF9C5 { return (true, to:[UnicodeScalar(0x6688)!]) }
    if value == 0xF9C6 { return (true, to:[UnicodeScalar(0x962E)!]) }
    if value == 0xF9C7 { return (true, to:[UnicodeScalar(0x5289)!]) }
    if value == 0xF9C8 { return (true, to:[UnicodeScalar(0x677B)!]) }
    if value == 0xF9C9 { return (true, to:[UnicodeScalar(0x67F3)!]) }
    if value == 0xF9CA { return (true, to:[UnicodeScalar(0x6D41)!]) }
    if value == 0xF9CB { return (true, to:[UnicodeScalar(0x6E9C)!]) }
    if value == 0xF9CC { return (true, to:[UnicodeScalar(0x7409)!]) }
    if value == 0xF9CD { return (true, to:[UnicodeScalar(0x7559)!]) }
    if value == 0xF9CE { return (true, to:[UnicodeScalar(0x786B)!]) }
    if value == 0xF9CF { return (true, to:[UnicodeScalar(0x7D10)!]) }
    if value == 0xF9D0 { return (true, to:[UnicodeScalar(0x985E)!]) }
    if value == 0xF9D1 { return (true, to:[UnicodeScalar(0x516D)!]) }
    if value == 0xF9D2 { return (true, to:[UnicodeScalar(0x622E)!]) }
    if value == 0xF9D3 { return (true, to:[UnicodeScalar(0x9678)!]) }
    if value == 0xF9D4 { return (true, to:[UnicodeScalar(0x502B)!]) }
    if value == 0xF9D5 { return (true, to:[UnicodeScalar(0x5D19)!]) }
    if value == 0xF9D6 { return (true, to:[UnicodeScalar(0x6DEA)!]) }
    if value == 0xF9D7 { return (true, to:[UnicodeScalar(0x8F2A)!]) }
    if value == 0xF9D8 { return (true, to:[UnicodeScalar(0x5F8B)!]) }
    if value == 0xF9D9 { return (true, to:[UnicodeScalar(0x6144)!]) }
    if value == 0xF9DA { return (true, to:[UnicodeScalar(0x6817)!]) }
    if value == 0xF9DB { return (true, to:[UnicodeScalar(0x7387)!]) }
    if value == 0xF9DC { return (true, to:[UnicodeScalar(0x9686)!]) }
    if value == 0xF9DD { return (true, to:[UnicodeScalar(0x5229)!]) }
    if value == 0xF9DE { return (true, to:[UnicodeScalar(0x540F)!]) }
    if value == 0xF9DF { return (true, to:[UnicodeScalar(0x5C65)!]) }
    if value == 0xF9E0 { return (true, to:[UnicodeScalar(0x6613)!]) }
    if value == 0xF9E1 { return (true, to:[UnicodeScalar(0x674E)!]) }
    if value == 0xF9E2 { return (true, to:[UnicodeScalar(0x68A8)!]) }
    if value == 0xF9E3 { return (true, to:[UnicodeScalar(0x6CE5)!]) }
    if value == 0xF9E4 { return (true, to:[UnicodeScalar(0x7406)!]) }
    if value == 0xF9E5 { return (true, to:[UnicodeScalar(0x75E2)!]) }
    if value == 0xF9E6 { return (true, to:[UnicodeScalar(0x7F79)!]) }
    if value == 0xF9E7 { return (true, to:[UnicodeScalar(0x88CF)!]) }
    if value == 0xF9E8 { return (true, to:[UnicodeScalar(0x88E1)!]) }
    if value == 0xF9E9 { return (true, to:[UnicodeScalar(0x91CC)!]) }
    if value == 0xF9EA { return (true, to:[UnicodeScalar(0x96E2)!]) }
    if value == 0xF9EB { return (true, to:[UnicodeScalar(0x533F)!]) }
    if value == 0xF9EC { return (true, to:[UnicodeScalar(0x6EBA)!]) }
    if value == 0xF9ED { return (true, to:[UnicodeScalar(0x541D)!]) }
    if value == 0xF9EE { return (true, to:[UnicodeScalar(0x71D0)!]) }
    if value == 0xF9EF { return (true, to:[UnicodeScalar(0x7498)!]) }
    if value == 0xF9F0 { return (true, to:[UnicodeScalar(0x85FA)!]) }
    if value == 0xF9F1 { return (true, to:[UnicodeScalar(0x96A3)!]) }
    if value == 0xF9F2 { return (true, to:[UnicodeScalar(0x9C57)!]) }
    if value == 0xF9F3 { return (true, to:[UnicodeScalar(0x9E9F)!]) }
    if value == 0xF9F4 { return (true, to:[UnicodeScalar(0x6797)!]) }
    if value == 0xF9F5 { return (true, to:[UnicodeScalar(0x6DCB)!]) }
    if value == 0xF9F6 { return (true, to:[UnicodeScalar(0x81E8)!]) }
    if value == 0xF9F7 { return (true, to:[UnicodeScalar(0x7ACB)!]) }
    if value == 0xF9F8 { return (true, to:[UnicodeScalar(0x7B20)!]) }
    if value == 0xF9F9 { return (true, to:[UnicodeScalar(0x7C92)!]) }
    if value == 0xF9FA { return (true, to:[UnicodeScalar(0x72C0)!]) }
    if value == 0xF9FB { return (true, to:[UnicodeScalar(0x7099)!]) }
    if value == 0xF9FC { return (true, to:[UnicodeScalar(0x8B58)!]) }
    if value == 0xF9FD { return (true, to:[UnicodeScalar(0x4EC0)!]) }
    if value == 0xF9FE { return (true, to:[UnicodeScalar(0x8336)!]) }
    if value == 0xF9FF { return (true, to:[UnicodeScalar(0x523A)!]) }
    if value == 0xFA00 { return (true, to:[UnicodeScalar(0x5207)!]) }
    if value == 0xFA01 { return (true, to:[UnicodeScalar(0x5EA6)!]) }
    if value == 0xFA02 { return (true, to:[UnicodeScalar(0x62D3)!]) }
    if value == 0xFA03 { return (true, to:[UnicodeScalar(0x7CD6)!]) }
    if value == 0xFA04 { return (true, to:[UnicodeScalar(0x5B85)!]) }
    if value == 0xFA05 { return (true, to:[UnicodeScalar(0x6D1E)!]) }
    if value == 0xFA06 { return (true, to:[UnicodeScalar(0x66B4)!]) }
    if value == 0xFA07 { return (true, to:[UnicodeScalar(0x8F3B)!]) }
    if value == 0xFA08 { return (true, to:[UnicodeScalar(0x884C)!]) }
    if value == 0xFA09 { return (true, to:[UnicodeScalar(0x964D)!]) }
    if value == 0xFA0A { return (true, to:[UnicodeScalar(0x898B)!]) }
    if value == 0xFA0B { return (true, to:[UnicodeScalar(0x5ED3)!]) }
    if value == 0xFA0C { return (true, to:[UnicodeScalar(0x5140)!]) }
    if value == 0xFA0D { return (true, to:[UnicodeScalar(0x55C0)!]) }
    if value == 0xFA10 { return (true, to:[UnicodeScalar(0x585A)!]) }
    if value == 0xFA12 { return (true, to:[UnicodeScalar(0x6674)!]) }
    if value == 0xFA15 { return (true, to:[UnicodeScalar(0x51DE)!]) }
    if value == 0xFA16 { return (true, to:[UnicodeScalar(0x732A)!]) }
    if value == 0xFA17 { return (true, to:[UnicodeScalar(0x76CA)!]) }
    if value == 0xFA18 { return (true, to:[UnicodeScalar(0x793C)!]) }
    if value == 0xFA19 { return (true, to:[UnicodeScalar(0x795E)!]) }
    if value == 0xFA1A { return (true, to:[UnicodeScalar(0x7965)!]) }
    if value == 0xFA1B { return (true, to:[UnicodeScalar(0x798F)!]) }
    if value == 0xFA1C { return (true, to:[UnicodeScalar(0x9756)!]) }
    if value == 0xFA1D { return (true, to:[UnicodeScalar(0x7CBE)!]) }
    if value == 0xFA1E { return (true, to:[UnicodeScalar(0x7FBD)!]) }
    if value == 0xFA20 { return (true, to:[UnicodeScalar(0x8612)!]) }
    if value == 0xFA22 { return (true, to:[UnicodeScalar(0x8AF8)!]) }
    if value == 0xFA25 { return (true, to:[UnicodeScalar(0x9038)!]) }
    if value == 0xFA26 { return (true, to:[UnicodeScalar(0x90FD)!]) }
    if value == 0xFA2A { return (true, to:[UnicodeScalar(0x98EF)!]) }
    if value == 0xFA2B { return (true, to:[UnicodeScalar(0x98FC)!]) }
    if value == 0xFA2C { return (true, to:[UnicodeScalar(0x9928)!]) }
    if value == 0xFA2D { return (true, to:[UnicodeScalar(0x9DB4)!]) }
    if value == 0xFA2E { return (true, to:[UnicodeScalar(0x90DE)!]) }
    if value == 0xFA2F { return (true, to:[UnicodeScalar(0x96B7)!]) }
    if value == 0xFA30 { return (true, to:[UnicodeScalar(0x4FAE)!]) }
    if value == 0xFA31 { return (true, to:[UnicodeScalar(0x50E7)!]) }
    if value == 0xFA32 { return (true, to:[UnicodeScalar(0x514D)!]) }
    if value == 0xFA33 { return (true, to:[UnicodeScalar(0x52C9)!]) }
    if value == 0xFA34 { return (true, to:[UnicodeScalar(0x52E4)!]) }
    if value == 0xFA35 { return (true, to:[UnicodeScalar(0x5351)!]) }
    if value == 0xFA36 { return (true, to:[UnicodeScalar(0x559D)!]) }
    if value == 0xFA37 { return (true, to:[UnicodeScalar(0x5606)!]) }
    if value == 0xFA38 { return (true, to:[UnicodeScalar(0x5668)!]) }
    if value == 0xFA39 { return (true, to:[UnicodeScalar(0x5840)!]) }
    if value == 0xFA3A { return (true, to:[UnicodeScalar(0x58A8)!]) }
    if value == 0xFA3B { return (true, to:[UnicodeScalar(0x5C64)!]) }
    if value == 0xFA3C { return (true, to:[UnicodeScalar(0x5C6E)!]) }
    if value == 0xFA3D { return (true, to:[UnicodeScalar(0x6094)!]) }
    if value == 0xFA3E { return (true, to:[UnicodeScalar(0x6168)!]) }
    if value == 0xFA3F { return (true, to:[UnicodeScalar(0x618E)!]) }
    if value == 0xFA40 { return (true, to:[UnicodeScalar(0x61F2)!]) }
    if value == 0xFA41 { return (true, to:[UnicodeScalar(0x654F)!]) }
    if value == 0xFA42 { return (true, to:[UnicodeScalar(0x65E2)!]) }
    if value == 0xFA43 { return (true, to:[UnicodeScalar(0x6691)!]) }
    if value == 0xFA44 { return (true, to:[UnicodeScalar(0x6885)!]) }
    if value == 0xFA45 { return (true, to:[UnicodeScalar(0x6D77)!]) }
    if value == 0xFA46 { return (true, to:[UnicodeScalar(0x6E1A)!]) }
    if value == 0xFA47 { return (true, to:[UnicodeScalar(0x6F22)!]) }
    if value == 0xFA48 { return (true, to:[UnicodeScalar(0x716E)!]) }
    if value == 0xFA49 { return (true, to:[UnicodeScalar(0x722B)!]) }
    if value == 0xFA4A { return (true, to:[UnicodeScalar(0x7422)!]) }
    if value == 0xFA4B { return (true, to:[UnicodeScalar(0x7891)!]) }
    if value == 0xFA4C { return (true, to:[UnicodeScalar(0x793E)!]) }
    if value == 0xFA4D { return (true, to:[UnicodeScalar(0x7949)!]) }
    if value == 0xFA4E { return (true, to:[UnicodeScalar(0x7948)!]) }
    if value == 0xFA4F { return (true, to:[UnicodeScalar(0x7950)!]) }
    if value == 0xFA50 { return (true, to:[UnicodeScalar(0x7956)!]) }
    if value == 0xFA51 { return (true, to:[UnicodeScalar(0x795D)!]) }
    if value == 0xFA52 { return (true, to:[UnicodeScalar(0x798D)!]) }
    if value == 0xFA53 { return (true, to:[UnicodeScalar(0x798E)!]) }
    if value == 0xFA54 { return (true, to:[UnicodeScalar(0x7A40)!]) }
    if value == 0xFA55 { return (true, to:[UnicodeScalar(0x7A81)!]) }
    if value == 0xFA56 { return (true, to:[UnicodeScalar(0x7BC0)!]) }
    if value == 0xFA57 { return (true, to:[UnicodeScalar(0x7DF4)!]) }
    if value == 0xFA58 { return (true, to:[UnicodeScalar(0x7E09)!]) }
    if value == 0xFA59 { return (true, to:[UnicodeScalar(0x7E41)!]) }
    if value == 0xFA5A { return (true, to:[UnicodeScalar(0x7F72)!]) }
    if value == 0xFA5B { return (true, to:[UnicodeScalar(0x8005)!]) }
    if value == 0xFA5C { return (true, to:[UnicodeScalar(0x81ED)!]) }
    if (0xFA5D <= value && value <= 0xFA5E) { return (true, to:[UnicodeScalar(0x8279)!]) }
    if value == 0xFA5F { return (true, to:[UnicodeScalar(0x8457)!]) }
    if value == 0xFA60 { return (true, to:[UnicodeScalar(0x8910)!]) }
    if value == 0xFA61 { return (true, to:[UnicodeScalar(0x8996)!]) }
    if value == 0xFA62 { return (true, to:[UnicodeScalar(0x8B01)!]) }
    if value == 0xFA63 { return (true, to:[UnicodeScalar(0x8B39)!]) }
    if value == 0xFA64 { return (true, to:[UnicodeScalar(0x8CD3)!]) }
    if value == 0xFA65 { return (true, to:[UnicodeScalar(0x8D08)!]) }
    if value == 0xFA66 { return (true, to:[UnicodeScalar(0x8FB6)!]) }
    if value == 0xFA67 { return (true, to:[UnicodeScalar(0x9038)!]) }
    if value == 0xFA68 { return (true, to:[UnicodeScalar(0x96E3)!]) }
    if value == 0xFA69 { return (true, to:[UnicodeScalar(0x97FF)!]) }
    if value == 0xFA6A { return (true, to:[UnicodeScalar(0x983B)!]) }
    if value == 0xFA6B { return (true, to:[UnicodeScalar(0x6075)!]) }
    if value == 0xFA6C { return (true, to:[UnicodeScalar(0x242EE)!]) }
    if value == 0xFA6D { return (true, to:[UnicodeScalar(0x8218)!]) }
    if value == 0xFA70 { return (true, to:[UnicodeScalar(0x4E26)!]) }
    if value == 0xFA71 { return (true, to:[UnicodeScalar(0x51B5)!]) }
    if value == 0xFA72 { return (true, to:[UnicodeScalar(0x5168)!]) }
    if value == 0xFA73 { return (true, to:[UnicodeScalar(0x4F80)!]) }
    if value == 0xFA74 { return (true, to:[UnicodeScalar(0x5145)!]) }
    if value == 0xFA75 { return (true, to:[UnicodeScalar(0x5180)!]) }
    if value == 0xFA76 { return (true, to:[UnicodeScalar(0x52C7)!]) }
    if value == 0xFA77 { return (true, to:[UnicodeScalar(0x52FA)!]) }
    if value == 0xFA78 { return (true, to:[UnicodeScalar(0x559D)!]) }
    if value == 0xFA79 { return (true, to:[UnicodeScalar(0x5555)!]) }
    if value == 0xFA7A { return (true, to:[UnicodeScalar(0x5599)!]) }
    if value == 0xFA7B { return (true, to:[UnicodeScalar(0x55E2)!]) }
    if value == 0xFA7C { return (true, to:[UnicodeScalar(0x585A)!]) }
    if value == 0xFA7D { return (true, to:[UnicodeScalar(0x58B3)!]) }
    if value == 0xFA7E { return (true, to:[UnicodeScalar(0x5944)!]) }
    if value == 0xFA7F { return (true, to:[UnicodeScalar(0x5954)!]) }
    if value == 0xFA80 { return (true, to:[UnicodeScalar(0x5A62)!]) }
    if value == 0xFA81 { return (true, to:[UnicodeScalar(0x5B28)!]) }
    if value == 0xFA82 { return (true, to:[UnicodeScalar(0x5ED2)!]) }
    if value == 0xFA83 { return (true, to:[UnicodeScalar(0x5ED9)!]) }
    if value == 0xFA84 { return (true, to:[UnicodeScalar(0x5F69)!]) }
    if value == 0xFA85 { return (true, to:[UnicodeScalar(0x5FAD)!]) }
    if value == 0xFA86 { return (true, to:[UnicodeScalar(0x60D8)!]) }
    if value == 0xFA87 { return (true, to:[UnicodeScalar(0x614E)!]) }
    if value == 0xFA88 { return (true, to:[UnicodeScalar(0x6108)!]) }
    if value == 0xFA89 { return (true, to:[UnicodeScalar(0x618E)!]) }
    if value == 0xFA8A { return (true, to:[UnicodeScalar(0x6160)!]) }
    if value == 0xFA8B { return (true, to:[UnicodeScalar(0x61F2)!]) }
    if value == 0xFA8C { return (true, to:[UnicodeScalar(0x6234)!]) }
    if value == 0xFA8D { return (true, to:[UnicodeScalar(0x63C4)!]) }
    if value == 0xFA8E { return (true, to:[UnicodeScalar(0x641C)!]) }
    if value == 0xFA8F { return (true, to:[UnicodeScalar(0x6452)!]) }
    if value == 0xFA90 { return (true, to:[UnicodeScalar(0x6556)!]) }
    if value == 0xFA91 { return (true, to:[UnicodeScalar(0x6674)!]) }
    if value == 0xFA92 { return (true, to:[UnicodeScalar(0x6717)!]) }
    if value == 0xFA93 { return (true, to:[UnicodeScalar(0x671B)!]) }
    if value == 0xFA94 { return (true, to:[UnicodeScalar(0x6756)!]) }
    if value == 0xFA95 { return (true, to:[UnicodeScalar(0x6B79)!]) }
    if value == 0xFA96 { return (true, to:[UnicodeScalar(0x6BBA)!]) }
    if value == 0xFA97 { return (true, to:[UnicodeScalar(0x6D41)!]) }
    if value == 0xFA98 { return (true, to:[UnicodeScalar(0x6EDB)!]) }
    if value == 0xFA99 { return (true, to:[UnicodeScalar(0x6ECB)!]) }
    if value == 0xFA9A { return (true, to:[UnicodeScalar(0x6F22)!]) }
    if value == 0xFA9B { return (true, to:[UnicodeScalar(0x701E)!]) }
    if value == 0xFA9C { return (true, to:[UnicodeScalar(0x716E)!]) }
    if value == 0xFA9D { return (true, to:[UnicodeScalar(0x77A7)!]) }
    if value == 0xFA9E { return (true, to:[UnicodeScalar(0x7235)!]) }
    if value == 0xFA9F { return (true, to:[UnicodeScalar(0x72AF)!]) }
    if value == 0xFAA0 { return (true, to:[UnicodeScalar(0x732A)!]) }
    if value == 0xFAA1 { return (true, to:[UnicodeScalar(0x7471)!]) }
    if value == 0xFAA2 { return (true, to:[UnicodeScalar(0x7506)!]) }
    if value == 0xFAA3 { return (true, to:[UnicodeScalar(0x753B)!]) }
    if value == 0xFAA4 { return (true, to:[UnicodeScalar(0x761D)!]) }
    if value == 0xFAA5 { return (true, to:[UnicodeScalar(0x761F)!]) }
    if value == 0xFAA6 { return (true, to:[UnicodeScalar(0x76CA)!]) }
    if value == 0xFAA7 { return (true, to:[UnicodeScalar(0x76DB)!]) }
    if value == 0xFAA8 { return (true, to:[UnicodeScalar(0x76F4)!]) }
    if value == 0xFAA9 { return (true, to:[UnicodeScalar(0x774A)!]) }
    if value == 0xFAAA { return (true, to:[UnicodeScalar(0x7740)!]) }
    if value == 0xFAAB { return (true, to:[UnicodeScalar(0x78CC)!]) }
    if value == 0xFAAC { return (true, to:[UnicodeScalar(0x7AB1)!]) }
    if value == 0xFAAD { return (true, to:[UnicodeScalar(0x7BC0)!]) }
    if value == 0xFAAE { return (true, to:[UnicodeScalar(0x7C7B)!]) }
    if value == 0xFAAF { return (true, to:[UnicodeScalar(0x7D5B)!]) }
    if value == 0xFAB0 { return (true, to:[UnicodeScalar(0x7DF4)!]) }
    if value == 0xFAB1 { return (true, to:[UnicodeScalar(0x7F3E)!]) }
    if value == 0xFAB2 { return (true, to:[UnicodeScalar(0x8005)!]) }
    if value == 0xFAB3 { return (true, to:[UnicodeScalar(0x8352)!]) }
    if value == 0xFAB4 { return (true, to:[UnicodeScalar(0x83EF)!]) }
    if value == 0xFAB5 { return (true, to:[UnicodeScalar(0x8779)!]) }
    if value == 0xFAB6 { return (true, to:[UnicodeScalar(0x8941)!]) }
    if value == 0xFAB7 { return (true, to:[UnicodeScalar(0x8986)!]) }
    if value == 0xFAB8 { return (true, to:[UnicodeScalar(0x8996)!]) }
    if value == 0xFAB9 { return (true, to:[UnicodeScalar(0x8ABF)!]) }
    if value == 0xFABA { return (true, to:[UnicodeScalar(0x8AF8)!]) }
    if value == 0xFABB { return (true, to:[UnicodeScalar(0x8ACB)!]) }
    if value == 0xFABC { return (true, to:[UnicodeScalar(0x8B01)!]) }
    if value == 0xFABD { return (true, to:[UnicodeScalar(0x8AFE)!]) }
    if value == 0xFABE { return (true, to:[UnicodeScalar(0x8AED)!]) }
    if value == 0xFABF { return (true, to:[UnicodeScalar(0x8B39)!]) }
    if value == 0xFAC0 { return (true, to:[UnicodeScalar(0x8B8A)!]) }
    if value == 0xFAC1 { return (true, to:[UnicodeScalar(0x8D08)!]) }
    if value == 0xFAC2 { return (true, to:[UnicodeScalar(0x8F38)!]) }
    if value == 0xFAC3 { return (true, to:[UnicodeScalar(0x9072)!]) }
    if value == 0xFAC4 { return (true, to:[UnicodeScalar(0x9199)!]) }
    if value == 0xFAC5 { return (true, to:[UnicodeScalar(0x9276)!]) }
    if value == 0xFAC6 { return (true, to:[UnicodeScalar(0x967C)!]) }
    if value == 0xFAC7 { return (true, to:[UnicodeScalar(0x96E3)!]) }
    if value == 0xFAC8 { return (true, to:[UnicodeScalar(0x9756)!]) }
    if value == 0xFAC9 { return (true, to:[UnicodeScalar(0x97DB)!]) }
    if value == 0xFACA { return (true, to:[UnicodeScalar(0x97FF)!]) }
    if value == 0xFACB { return (true, to:[UnicodeScalar(0x980B)!]) }
    if value == 0xFACC { return (true, to:[UnicodeScalar(0x983B)!]) }
    if value == 0xFACD { return (true, to:[UnicodeScalar(0x9B12)!]) }
    if value == 0xFACE { return (true, to:[UnicodeScalar(0x9F9C)!]) }
    if value == 0xFACF { return (true, to:[UnicodeScalar(0x2284A)!]) }
    if value == 0xFAD0 { return (true, to:[UnicodeScalar(0x22844)!]) }
    if value == 0xFAD1 { return (true, to:[UnicodeScalar(0x233D5)!]) }
    if value == 0xFAD2 { return (true, to:[UnicodeScalar(0x3B9D)!]) }
    if value == 0xFAD3 { return (true, to:[UnicodeScalar(0x4018)!]) }
    if value == 0xFAD4 { return (true, to:[UnicodeScalar(0x4039)!]) }
    if value == 0xFAD5 { return (true, to:[UnicodeScalar(0x25249)!]) }
    if value == 0xFAD6 { return (true, to:[UnicodeScalar(0x25CD0)!]) }
    if value == 0xFAD7 { return (true, to:[UnicodeScalar(0x27ED3)!]) }
    if value == 0xFAD8 { return (true, to:[UnicodeScalar(0x9F43)!]) }
    if value == 0xFAD9 { return (true, to:[UnicodeScalar(0x9F8E)!]) }
    if value == 0xFB00 { return (true, to:[UnicodeScalar(0x0066)!, UnicodeScalar(0x0066)!]) }
    if value == 0xFB01 { return (true, to:[UnicodeScalar(0x0066)!, UnicodeScalar(0x0069)!]) }
    if value == 0xFB02 { return (true, to:[UnicodeScalar(0x0066)!, UnicodeScalar(0x006C)!]) }
    if value == 0xFB03 { return (true, to:[UnicodeScalar(0x0066)!, UnicodeScalar(0x0066)!, UnicodeScalar(0x0069)!]) }
    if value == 0xFB04 { return (true, to:[UnicodeScalar(0x0066)!, UnicodeScalar(0x0066)!, UnicodeScalar(0x006C)!]) }
    if (0xFB05 <= value && value <= 0xFB06) { return (true, to:[UnicodeScalar(0x0073)!, UnicodeScalar(0x0074)!]) }
    if value == 0xFB13 { return (true, to:[UnicodeScalar(0x0574)!, UnicodeScalar(0x0576)!]) }
    if value == 0xFB14 { return (true, to:[UnicodeScalar(0x0574)!, UnicodeScalar(0x0565)!]) }
    if value == 0xFB15 { return (true, to:[UnicodeScalar(0x0574)!, UnicodeScalar(0x056B)!]) }
    if value == 0xFB16 { return (true, to:[UnicodeScalar(0x057E)!, UnicodeScalar(0x0576)!]) }
    if value == 0xFB17 { return (true, to:[UnicodeScalar(0x0574)!, UnicodeScalar(0x056D)!]) }
    if value == 0xFB1D { return (true, to:[UnicodeScalar(0x05D9)!, UnicodeScalar(0x05B4)!]) }
    if value == 0xFB1F { return (true, to:[UnicodeScalar(0x05F2)!, UnicodeScalar(0x05B7)!]) }
    if value == 0xFB20 { return (true, to:[UnicodeScalar(0x05E2)!]) }
    if value == 0xFB21 { return (true, to:[UnicodeScalar(0x05D0)!]) }
    if value == 0xFB22 { return (true, to:[UnicodeScalar(0x05D3)!]) }
    if value == 0xFB23 { return (true, to:[UnicodeScalar(0x05D4)!]) }
    if value == 0xFB24 { return (true, to:[UnicodeScalar(0x05DB)!]) }
    if value == 0xFB25 { return (true, to:[UnicodeScalar(0x05DC)!]) }
    if value == 0xFB26 { return (true, to:[UnicodeScalar(0x05DD)!]) }
    if value == 0xFB27 { return (true, to:[UnicodeScalar(0x05E8)!]) }
    if value == 0xFB28 { return (true, to:[UnicodeScalar(0x05EA)!]) }
    if value == 0xFB2A { return (true, to:[UnicodeScalar(0x05E9)!, UnicodeScalar(0x05C1)!]) }
    if value == 0xFB2B { return (true, to:[UnicodeScalar(0x05E9)!, UnicodeScalar(0x05C2)!]) }
    if value == 0xFB2C { return (true, to:[UnicodeScalar(0x05E9)!, UnicodeScalar(0x05BC)!, UnicodeScalar(0x05C1)!]) }
    if value == 0xFB2D { return (true, to:[UnicodeScalar(0x05E9)!, UnicodeScalar(0x05BC)!, UnicodeScalar(0x05C2)!]) }
    if value == 0xFB2E { return (true, to:[UnicodeScalar(0x05D0)!, UnicodeScalar(0x05B7)!]) }
    if value == 0xFB2F { return (true, to:[UnicodeScalar(0x05D0)!, UnicodeScalar(0x05B8)!]) }
    if value == 0xFB30 { return (true, to:[UnicodeScalar(0x05D0)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB31 { return (true, to:[UnicodeScalar(0x05D1)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB32 { return (true, to:[UnicodeScalar(0x05D2)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB33 { return (true, to:[UnicodeScalar(0x05D3)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB34 { return (true, to:[UnicodeScalar(0x05D4)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB35 { return (true, to:[UnicodeScalar(0x05D5)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB36 { return (true, to:[UnicodeScalar(0x05D6)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB38 { return (true, to:[UnicodeScalar(0x05D8)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB39 { return (true, to:[UnicodeScalar(0x05D9)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB3A { return (true, to:[UnicodeScalar(0x05DA)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB3B { return (true, to:[UnicodeScalar(0x05DB)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB3C { return (true, to:[UnicodeScalar(0x05DC)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB3E { return (true, to:[UnicodeScalar(0x05DE)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB40 { return (true, to:[UnicodeScalar(0x05E0)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB41 { return (true, to:[UnicodeScalar(0x05E1)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB43 { return (true, to:[UnicodeScalar(0x05E3)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB44 { return (true, to:[UnicodeScalar(0x05E4)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB46 { return (true, to:[UnicodeScalar(0x05E6)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB47 { return (true, to:[UnicodeScalar(0x05E7)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB48 { return (true, to:[UnicodeScalar(0x05E8)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB49 { return (true, to:[UnicodeScalar(0x05E9)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB4A { return (true, to:[UnicodeScalar(0x05EA)!, UnicodeScalar(0x05BC)!]) }
    if value == 0xFB4B { return (true, to:[UnicodeScalar(0x05D5)!, UnicodeScalar(0x05B9)!]) }
    if value == 0xFB4C { return (true, to:[UnicodeScalar(0x05D1)!, UnicodeScalar(0x05BF)!]) }
    if value == 0xFB4D { return (true, to:[UnicodeScalar(0x05DB)!, UnicodeScalar(0x05BF)!]) }
    if value == 0xFB4E { return (true, to:[UnicodeScalar(0x05E4)!, UnicodeScalar(0x05BF)!]) }
    if value == 0xFB4F { return (true, to:[UnicodeScalar(0x05D0)!, UnicodeScalar(0x05DC)!]) }
    if (0xFB50 <= value && value <= 0xFB51) { return (true, to:[UnicodeScalar(0x0671)!]) }
    if (0xFB52 <= value && value <= 0xFB55) { return (true, to:[UnicodeScalar(0x067B)!]) }
    if (0xFB56 <= value && value <= 0xFB59) { return (true, to:[UnicodeScalar(0x067E)!]) }
    if (0xFB5A <= value && value <= 0xFB5D) { return (true, to:[UnicodeScalar(0x0680)!]) }
    if (0xFB5E <= value && value <= 0xFB61) { return (true, to:[UnicodeScalar(0x067A)!]) }
    if (0xFB62 <= value && value <= 0xFB65) { return (true, to:[UnicodeScalar(0x067F)!]) }
    if (0xFB66 <= value && value <= 0xFB69) { return (true, to:[UnicodeScalar(0x0679)!]) }
    if (0xFB6A <= value && value <= 0xFB6D) { return (true, to:[UnicodeScalar(0x06A4)!]) }
    if (0xFB6E <= value && value <= 0xFB71) { return (true, to:[UnicodeScalar(0x06A6)!]) }
    if (0xFB72 <= value && value <= 0xFB75) { return (true, to:[UnicodeScalar(0x0684)!]) }
    if (0xFB76 <= value && value <= 0xFB79) { return (true, to:[UnicodeScalar(0x0683)!]) }
    if (0xFB7A <= value && value <= 0xFB7D) { return (true, to:[UnicodeScalar(0x0686)!]) }
    if (0xFB7E <= value && value <= 0xFB81) { return (true, to:[UnicodeScalar(0x0687)!]) }
    if (0xFB82 <= value && value <= 0xFB83) { return (true, to:[UnicodeScalar(0x068D)!]) }
    if (0xFB84 <= value && value <= 0xFB85) { return (true, to:[UnicodeScalar(0x068C)!]) }
    if (0xFB86 <= value && value <= 0xFB87) { return (true, to:[UnicodeScalar(0x068E)!]) }
    if (0xFB88 <= value && value <= 0xFB89) { return (true, to:[UnicodeScalar(0x0688)!]) }
    if (0xFB8A <= value && value <= 0xFB8B) { return (true, to:[UnicodeScalar(0x0698)!]) }
    if (0xFB8C <= value && value <= 0xFB8D) { return (true, to:[UnicodeScalar(0x0691)!]) }
    if (0xFB8E <= value && value <= 0xFB91) { return (true, to:[UnicodeScalar(0x06A9)!]) }
    if (0xFB92 <= value && value <= 0xFB95) { return (true, to:[UnicodeScalar(0x06AF)!]) }
    if (0xFB96 <= value && value <= 0xFB99) { return (true, to:[UnicodeScalar(0x06B3)!]) }
    if (0xFB9A <= value && value <= 0xFB9D) { return (true, to:[UnicodeScalar(0x06B1)!]) }
    if (0xFB9E <= value && value <= 0xFB9F) { return (true, to:[UnicodeScalar(0x06BA)!]) }
    if (0xFBA0 <= value && value <= 0xFBA3) { return (true, to:[UnicodeScalar(0x06BB)!]) }
    if (0xFBA4 <= value && value <= 0xFBA5) { return (true, to:[UnicodeScalar(0x06C0)!]) }
    if (0xFBA6 <= value && value <= 0xFBA9) { return (true, to:[UnicodeScalar(0x06C1)!]) }
    if (0xFBAA <= value && value <= 0xFBAD) { return (true, to:[UnicodeScalar(0x06BE)!]) }
    if (0xFBAE <= value && value <= 0xFBAF) { return (true, to:[UnicodeScalar(0x06D2)!]) }
    if (0xFBB0 <= value && value <= 0xFBB1) { return (true, to:[UnicodeScalar(0x06D3)!]) }
    if (0xFBD3 <= value && value <= 0xFBD6) { return (true, to:[UnicodeScalar(0x06AD)!]) }
    if (0xFBD7 <= value && value <= 0xFBD8) { return (true, to:[UnicodeScalar(0x06C7)!]) }
    if (0xFBD9 <= value && value <= 0xFBDA) { return (true, to:[UnicodeScalar(0x06C6)!]) }
    if (0xFBDB <= value && value <= 0xFBDC) { return (true, to:[UnicodeScalar(0x06C8)!]) }
    if value == 0xFBDD { return (true, to:[UnicodeScalar(0x06C7)!, UnicodeScalar(0x0674)!]) }
    if (0xFBDE <= value && value <= 0xFBDF) { return (true, to:[UnicodeScalar(0x06CB)!]) }
    if (0xFBE0 <= value && value <= 0xFBE1) { return (true, to:[UnicodeScalar(0x06C5)!]) }
    if (0xFBE2 <= value && value <= 0xFBE3) { return (true, to:[UnicodeScalar(0x06C9)!]) }
    if (0xFBE4 <= value && value <= 0xFBE7) { return (true, to:[UnicodeScalar(0x06D0)!]) }
    if (0xFBE8 <= value && value <= 0xFBE9) { return (true, to:[UnicodeScalar(0x0649)!]) }
    if (0xFBEA <= value && value <= 0xFBEB) { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x0627)!]) }
    if (0xFBEC <= value && value <= 0xFBED) { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x06D5)!]) }
    if (0xFBEE <= value && value <= 0xFBEF) { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x0648)!]) }
    if (0xFBF0 <= value && value <= 0xFBF1) { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x06C7)!]) }
    if (0xFBF2 <= value && value <= 0xFBF3) { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x06C6)!]) }
    if (0xFBF4 <= value && value <= 0xFBF5) { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x06C8)!]) }
    if (0xFBF6 <= value && value <= 0xFBF8) { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x06D0)!]) }
    if (0xFBF9 <= value && value <= 0xFBFB) { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x0649)!]) }
    if (0xFBFC <= value && value <= 0xFBFF) { return (true, to:[UnicodeScalar(0x06CC)!]) }
    if value == 0xFC00 { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC01 { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC02 { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC03 { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC04 { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC05 { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC06 { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC07 { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFC08 { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC09 { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC0A { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC0B { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC0C { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC0D { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFC0E { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC0F { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC10 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC11 { return (true, to:[UnicodeScalar(0x062B)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC12 { return (true, to:[UnicodeScalar(0x062B)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC13 { return (true, to:[UnicodeScalar(0x062B)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC14 { return (true, to:[UnicodeScalar(0x062B)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC15 { return (true, to:[UnicodeScalar(0x062C)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC16 { return (true, to:[UnicodeScalar(0x062C)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC17 { return (true, to:[UnicodeScalar(0x062D)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC18 { return (true, to:[UnicodeScalar(0x062D)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC19 { return (true, to:[UnicodeScalar(0x062E)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC1A { return (true, to:[UnicodeScalar(0x062E)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC1B { return (true, to:[UnicodeScalar(0x062E)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC1C { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC1D { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC1E { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFC1F { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC20 { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC21 { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC22 { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC23 { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC24 { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFC25 { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC26 { return (true, to:[UnicodeScalar(0x0637)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC27 { return (true, to:[UnicodeScalar(0x0637)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC28 { return (true, to:[UnicodeScalar(0x0638)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC29 { return (true, to:[UnicodeScalar(0x0639)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC2A { return (true, to:[UnicodeScalar(0x0639)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC2B { return (true, to:[UnicodeScalar(0x063A)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC2C { return (true, to:[UnicodeScalar(0x063A)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC2D { return (true, to:[UnicodeScalar(0x0641)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC2E { return (true, to:[UnicodeScalar(0x0641)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC2F { return (true, to:[UnicodeScalar(0x0641)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFC30 { return (true, to:[UnicodeScalar(0x0641)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC31 { return (true, to:[UnicodeScalar(0x0641)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC32 { return (true, to:[UnicodeScalar(0x0641)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC33 { return (true, to:[UnicodeScalar(0x0642)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC34 { return (true, to:[UnicodeScalar(0x0642)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC35 { return (true, to:[UnicodeScalar(0x0642)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC36 { return (true, to:[UnicodeScalar(0x0642)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC37 { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x0627)!]) }
    if value == 0xFC38 { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC39 { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC3A { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFC3B { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x0644)!]) }
    if value == 0xFC3C { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC3D { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC3E { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC3F { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC40 { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC41 { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFC42 { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC43 { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC44 { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC45 { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC46 { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC47 { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFC48 { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC49 { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC4A { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC4B { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC4C { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC4D { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFC4E { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC4F { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC50 { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC51 { return (true, to:[UnicodeScalar(0x0647)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC52 { return (true, to:[UnicodeScalar(0x0647)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC53 { return (true, to:[UnicodeScalar(0x0647)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC54 { return (true, to:[UnicodeScalar(0x0647)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC55 { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC56 { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC57 { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFC58 { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC59 { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC5A { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC5B { return (true, to:[UnicodeScalar(0x0630)!, UnicodeScalar(0x0670)!]) }
    if value == 0xFC5C { return (true, to:[UnicodeScalar(0x0631)!, UnicodeScalar(0x0670)!]) }
    if value == 0xFC5D { return (true, to:[UnicodeScalar(0x0649)!, UnicodeScalar(0x0670)!]) }
    if value == 0xFC64 { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x0631)!]) }
    if value == 0xFC65 { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x0632)!]) }
    if value == 0xFC66 { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC67 { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x0646)!]) }
    if value == 0xFC68 { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC69 { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC6A { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x0631)!]) }
    if value == 0xFC6B { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x0632)!]) }
    if value == 0xFC6C { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC6D { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x0646)!]) }
    if value == 0xFC6E { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC6F { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC70 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0631)!]) }
    if value == 0xFC71 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0632)!]) }
    if value == 0xFC72 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC73 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0646)!]) }
    if value == 0xFC74 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC75 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC76 { return (true, to:[UnicodeScalar(0x062B)!, UnicodeScalar(0x0631)!]) }
    if value == 0xFC77 { return (true, to:[UnicodeScalar(0x062B)!, UnicodeScalar(0x0632)!]) }
    if value == 0xFC78 { return (true, to:[UnicodeScalar(0x062B)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC79 { return (true, to:[UnicodeScalar(0x062B)!, UnicodeScalar(0x0646)!]) }
    if value == 0xFC7A { return (true, to:[UnicodeScalar(0x062B)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC7B { return (true, to:[UnicodeScalar(0x062B)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC7C { return (true, to:[UnicodeScalar(0x0641)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC7D { return (true, to:[UnicodeScalar(0x0641)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC7E { return (true, to:[UnicodeScalar(0x0642)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC7F { return (true, to:[UnicodeScalar(0x0642)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC80 { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x0627)!]) }
    if value == 0xFC81 { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x0644)!]) }
    if value == 0xFC82 { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC83 { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC84 { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC85 { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC86 { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC87 { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC88 { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x0627)!]) }
    if value == 0xFC89 { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC8A { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x0631)!]) }
    if value == 0xFC8B { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x0632)!]) }
    if value == 0xFC8C { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC8D { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x0646)!]) }
    if value == 0xFC8E { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC8F { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC90 { return (true, to:[UnicodeScalar(0x0649)!, UnicodeScalar(0x0670)!]) }
    if value == 0xFC91 { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x0631)!]) }
    if value == 0xFC92 { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x0632)!]) }
    if value == 0xFC93 { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC94 { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x0646)!]) }
    if value == 0xFC95 { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFC96 { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFC97 { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC98 { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC99 { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFC9A { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFC9B { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFC9C { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFC9D { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFC9E { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFC9F { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCA0 { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFCA1 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFCA2 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFCA3 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFCA4 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCA5 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFCA6 { return (true, to:[UnicodeScalar(0x062B)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCA7 { return (true, to:[UnicodeScalar(0x062C)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFCA8 { return (true, to:[UnicodeScalar(0x062C)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCA9 { return (true, to:[UnicodeScalar(0x062D)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFCAA { return (true, to:[UnicodeScalar(0x062D)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCAB { return (true, to:[UnicodeScalar(0x062E)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFCAC { return (true, to:[UnicodeScalar(0x062E)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCAD { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFCAE { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFCAF { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFCB0 { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCB1 { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFCB2 { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFCB3 { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCB4 { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFCB5 { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFCB6 { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFCB7 { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCB8 { return (true, to:[UnicodeScalar(0x0637)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFCB9 { return (true, to:[UnicodeScalar(0x0638)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCBA { return (true, to:[UnicodeScalar(0x0639)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFCBB { return (true, to:[UnicodeScalar(0x0639)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCBC { return (true, to:[UnicodeScalar(0x063A)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFCBD { return (true, to:[UnicodeScalar(0x063A)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCBE { return (true, to:[UnicodeScalar(0x0641)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFCBF { return (true, to:[UnicodeScalar(0x0641)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFCC0 { return (true, to:[UnicodeScalar(0x0641)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFCC1 { return (true, to:[UnicodeScalar(0x0641)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCC2 { return (true, to:[UnicodeScalar(0x0642)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFCC3 { return (true, to:[UnicodeScalar(0x0642)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCC4 { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFCC5 { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFCC6 { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFCC7 { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x0644)!]) }
    if value == 0xFCC8 { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCC9 { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFCCA { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFCCB { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFCCC { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCCD { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFCCE { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFCCF { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFCD0 { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFCD1 { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCD2 { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFCD3 { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFCD4 { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFCD5 { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCD6 { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFCD7 { return (true, to:[UnicodeScalar(0x0647)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFCD8 { return (true, to:[UnicodeScalar(0x0647)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCD9 { return (true, to:[UnicodeScalar(0x0647)!, UnicodeScalar(0x0670)!]) }
    if value == 0xFCDA { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFCDB { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFCDC { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFCDD { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCDE { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFCDF { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCE0 { return (true, to:[UnicodeScalar(0x0626)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFCE1 { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCE2 { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFCE3 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCE4 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFCE5 { return (true, to:[UnicodeScalar(0x062B)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCE6 { return (true, to:[UnicodeScalar(0x062B)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFCE7 { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCE8 { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFCE9 { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCEA { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFCEB { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x0644)!]) }
    if value == 0xFCEC { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCED { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCEE { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCEF { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFCF0 { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFCF1 { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFCF2 { return (true, to:[UnicodeScalar(0x0640)!, UnicodeScalar(0x064E)!, UnicodeScalar(0x0651)!]) }
    if value == 0xFCF3 { return (true, to:[UnicodeScalar(0x0640)!, UnicodeScalar(0x064F)!, UnicodeScalar(0x0651)!]) }
    if value == 0xFCF4 { return (true, to:[UnicodeScalar(0x0640)!, UnicodeScalar(0x0650)!, UnicodeScalar(0x0651)!]) }
    if value == 0xFCF5 { return (true, to:[UnicodeScalar(0x0637)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFCF6 { return (true, to:[UnicodeScalar(0x0637)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFCF7 { return (true, to:[UnicodeScalar(0x0639)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFCF8 { return (true, to:[UnicodeScalar(0x0639)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFCF9 { return (true, to:[UnicodeScalar(0x063A)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFCFA { return (true, to:[UnicodeScalar(0x063A)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFCFB { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFCFC { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFCFD { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFCFE { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFCFF { return (true, to:[UnicodeScalar(0x062D)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD00 { return (true, to:[UnicodeScalar(0x062D)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD01 { return (true, to:[UnicodeScalar(0x062C)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD02 { return (true, to:[UnicodeScalar(0x062C)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD03 { return (true, to:[UnicodeScalar(0x062E)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD04 { return (true, to:[UnicodeScalar(0x062E)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD05 { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD06 { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD07 { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD08 { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD09 { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFD0A { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFD0B { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFD0C { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD0D { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x0631)!]) }
    if value == 0xFD0E { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x0631)!]) }
    if value == 0xFD0F { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x0631)!]) }
    if value == 0xFD10 { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x0631)!]) }
    if value == 0xFD11 { return (true, to:[UnicodeScalar(0x0637)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD12 { return (true, to:[UnicodeScalar(0x0637)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD13 { return (true, to:[UnicodeScalar(0x0639)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD14 { return (true, to:[UnicodeScalar(0x0639)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD15 { return (true, to:[UnicodeScalar(0x063A)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD16 { return (true, to:[UnicodeScalar(0x063A)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD17 { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD18 { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD19 { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD1A { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD1B { return (true, to:[UnicodeScalar(0x062D)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD1C { return (true, to:[UnicodeScalar(0x062D)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD1D { return (true, to:[UnicodeScalar(0x062C)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD1E { return (true, to:[UnicodeScalar(0x062C)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD1F { return (true, to:[UnicodeScalar(0x062E)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD20 { return (true, to:[UnicodeScalar(0x062E)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD21 { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD22 { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD23 { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD24 { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD25 { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFD26 { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFD27 { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFD28 { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD29 { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x0631)!]) }
    if value == 0xFD2A { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x0631)!]) }
    if value == 0xFD2B { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x0631)!]) }
    if value == 0xFD2C { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x0631)!]) }
    if value == 0xFD2D { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFD2E { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFD2F { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFD30 { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD31 { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFD32 { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFD33 { return (true, to:[UnicodeScalar(0x0637)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD34 { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFD35 { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFD36 { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFD37 { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFD38 { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFD39 { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFD3A { return (true, to:[UnicodeScalar(0x0637)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD3B { return (true, to:[UnicodeScalar(0x0638)!, UnicodeScalar(0x0645)!]) }
    if (0xFD3C <= value && value <= 0xFD3D) { return (true, to:[UnicodeScalar(0x0627)!, UnicodeScalar(0x064B)!]) }
    if value == 0xFD50 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x0645)!]) }
    if (0xFD51 <= value && value <= 0xFD52) { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFD53 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD54 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x062E)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD55 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFD56 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFD57 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x062E)!]) }
    if (0xFD58 <= value && value <= 0xFD59) { return (true, to:[UnicodeScalar(0x062C)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFD5A { return (true, to:[UnicodeScalar(0x062D)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD5B { return (true, to:[UnicodeScalar(0x062D)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD5C { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFD5D { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFD5E { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x0649)!]) }
    if (0xFD5F <= value && value <= 0xFD60) { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFD61 { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x062C)!]) }
    if (0xFD62 <= value && value <= 0xFD63) { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!]) }
    if (0xFD64 <= value && value <= 0xFD65) { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFD66 { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!]) }
    if (0xFD67 <= value && value <= 0xFD68) { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD69 { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x064A)!]) }
    if (0xFD6A <= value && value <= 0xFD6B) { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x062E)!]) }
    if (0xFD6C <= value && value <= 0xFD6D) { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD6E { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x0649)!]) }
    if (0xFD6F <= value && value <= 0xFD70) { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x062E)!, UnicodeScalar(0x0645)!]) }
    if (0xFD71 <= value && value <= 0xFD72) { return (true, to:[UnicodeScalar(0x0637)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFD73 { return (true, to:[UnicodeScalar(0x0637)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD74 { return (true, to:[UnicodeScalar(0x0637)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD75 { return (true, to:[UnicodeScalar(0x0639)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x0645)!]) }
    if (0xFD76 <= value && value <= 0xFD77) { return (true, to:[UnicodeScalar(0x0639)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD78 { return (true, to:[UnicodeScalar(0x0639)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD79 { return (true, to:[UnicodeScalar(0x063A)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD7A { return (true, to:[UnicodeScalar(0x063A)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD7B { return (true, to:[UnicodeScalar(0x063A)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0649)!]) }
    if (0xFD7C <= value && value <= 0xFD7D) { return (true, to:[UnicodeScalar(0x0641)!, UnicodeScalar(0x062E)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD7E { return (true, to:[UnicodeScalar(0x0642)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFD7F { return (true, to:[UnicodeScalar(0x0642)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD80 { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD81 { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD82 { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x0649)!]) }
    if (0xFD83 <= value && value <= 0xFD84) { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x062C)!]) }
    if (0xFD85 <= value && value <= 0xFD86) { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x062E)!, UnicodeScalar(0x0645)!]) }
    if (0xFD87 <= value && value <= 0xFD88) { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFD89 { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFD8A { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD8B { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD8C { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFD8D { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD8E { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062E)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFD8F { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062E)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD92 { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x062E)!]) }
    if value == 0xFD93 { return (true, to:[UnicodeScalar(0x0647)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x062C)!]) }
    if value == 0xFD94 { return (true, to:[UnicodeScalar(0x0647)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD95 { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD96 { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x0649)!]) }
    if (0xFD97 <= value && value <= 0xFD98) { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD99 { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFD9A { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD9B { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0649)!]) }
    if (0xFD9C <= value && value <= 0xFD9D) { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFD9E { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x062E)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFD9F { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDA0 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFDA1 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x062E)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDA2 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x062E)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFDA3 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDA4 { return (true, to:[UnicodeScalar(0x062A)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFDA5 { return (true, to:[UnicodeScalar(0x062C)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDA6 { return (true, to:[UnicodeScalar(0x062C)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFDA7 { return (true, to:[UnicodeScalar(0x062C)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFDA8 { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x062E)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFDA9 { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDAA { return (true, to:[UnicodeScalar(0x0634)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDAB { return (true, to:[UnicodeScalar(0x0636)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDAC { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDAD { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDAE { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDAF { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDB0 { return (true, to:[UnicodeScalar(0x064A)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDB1 { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDB2 { return (true, to:[UnicodeScalar(0x0642)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDB3 { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDB4 { return (true, to:[UnicodeScalar(0x0642)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFDB5 { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFDB6 { return (true, to:[UnicodeScalar(0x0639)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDB7 { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDB8 { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFDB9 { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062E)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDBA { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFDBB { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFDBC { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFDBD { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x062D)!]) }
    if value == 0xFDBE { return (true, to:[UnicodeScalar(0x062C)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDBF { return (true, to:[UnicodeScalar(0x062D)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDC0 { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDC1 { return (true, to:[UnicodeScalar(0x0641)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDC2 { return (true, to:[UnicodeScalar(0x0628)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDC3 { return (true, to:[UnicodeScalar(0x0643)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFDC4 { return (true, to:[UnicodeScalar(0x0639)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFDC5 { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFDC6 { return (true, to:[UnicodeScalar(0x0633)!, UnicodeScalar(0x062E)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDC7 { return (true, to:[UnicodeScalar(0x0646)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x064A)!]) }
    if value == 0xFDF0 { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x06D2)!]) }
    if value == 0xFDF1 { return (true, to:[UnicodeScalar(0x0642)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x06D2)!]) }
    if value == 0xFDF2 { return (true, to:[UnicodeScalar(0x0627)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFDF3 { return (true, to:[UnicodeScalar(0x0627)!, UnicodeScalar(0x0643)!, UnicodeScalar(0x0628)!, UnicodeScalar(0x0631)!]) }
    if value == 0xFDF4 { return (true, to:[UnicodeScalar(0x0645)!, UnicodeScalar(0x062D)!, UnicodeScalar(0x0645)!, UnicodeScalar(0x062F)!]) }
    if value == 0xFDF5 { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x0639)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFDF6 { return (true, to:[UnicodeScalar(0x0631)!, UnicodeScalar(0x0633)!, UnicodeScalar(0x0648)!, UnicodeScalar(0x0644)!]) }
    if value == 0xFDF7 { return (true, to:[UnicodeScalar(0x0639)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x064A)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFDF8 { return (true, to:[UnicodeScalar(0x0648)!, UnicodeScalar(0x0633)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFDF9 { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x0649)!]) }
    if value == 0xFDFC { return (true, to:[UnicodeScalar(0x0631)!, UnicodeScalar(0x06CC)!, UnicodeScalar(0x0627)!, UnicodeScalar(0x0644)!]) }
    if value == 0xFE11 { return (true, to:[UnicodeScalar(0x3001)!]) }
    if value == 0xFE17 { return (true, to:[UnicodeScalar(0x3016)!]) }
    if value == 0xFE18 { return (true, to:[UnicodeScalar(0x3017)!]) }
    if value == 0xFE31 { return (true, to:[UnicodeScalar(0x2014)!]) }
    if value == 0xFE32 { return (true, to:[UnicodeScalar(0x2013)!]) }
    if value == 0xFE39 { return (true, to:[UnicodeScalar(0x3014)!]) }
    if value == 0xFE3A { return (true, to:[UnicodeScalar(0x3015)!]) }
    if value == 0xFE3B { return (true, to:[UnicodeScalar(0x3010)!]) }
    if value == 0xFE3C { return (true, to:[UnicodeScalar(0x3011)!]) }
    if value == 0xFE3D { return (true, to:[UnicodeScalar(0x300A)!]) }
    if value == 0xFE3E { return (true, to:[UnicodeScalar(0x300B)!]) }
    if value == 0xFE3F { return (true, to:[UnicodeScalar(0x3008)!]) }
    if value == 0xFE40 { return (true, to:[UnicodeScalar(0x3009)!]) }
    if value == 0xFE41 { return (true, to:[UnicodeScalar(0x300C)!]) }
    if value == 0xFE42 { return (true, to:[UnicodeScalar(0x300D)!]) }
    if value == 0xFE43 { return (true, to:[UnicodeScalar(0x300E)!]) }
    if value == 0xFE44 { return (true, to:[UnicodeScalar(0x300F)!]) }
    if value == 0xFE51 { return (true, to:[UnicodeScalar(0x3001)!]) }
    if value == 0xFE58 { return (true, to:[UnicodeScalar(0x2014)!]) }
    if value == 0xFE5D { return (true, to:[UnicodeScalar(0x3014)!]) }
    if value == 0xFE5E { return (true, to:[UnicodeScalar(0x3015)!]) }
    if value == 0xFE63 { return (true, to:[UnicodeScalar(0x002D)!]) }
    if value == 0xFE71 { return (true, to:[UnicodeScalar(0x0640)!, UnicodeScalar(0x064B)!]) }
    if value == 0xFE77 { return (true, to:[UnicodeScalar(0x0640)!, UnicodeScalar(0x064E)!]) }
    if value == 0xFE79 { return (true, to:[UnicodeScalar(0x0640)!, UnicodeScalar(0x064F)!]) }
    if value == 0xFE7B { return (true, to:[UnicodeScalar(0x0640)!, UnicodeScalar(0x0650)!]) }
    if value == 0xFE7D { return (true, to:[UnicodeScalar(0x0640)!, UnicodeScalar(0x0651)!]) }
    if value == 0xFE7F { return (true, to:[UnicodeScalar(0x0640)!, UnicodeScalar(0x0652)!]) }
    if value == 0xFE80 { return (true, to:[UnicodeScalar(0x0621)!]) }
    if (0xFE81 <= value && value <= 0xFE82) { return (true, to:[UnicodeScalar(0x0622)!]) }
    if (0xFE83 <= value && value <= 0xFE84) { return (true, to:[UnicodeScalar(0x0623)!]) }
    if (0xFE85 <= value && value <= 0xFE86) { return (true, to:[UnicodeScalar(0x0624)!]) }
    if (0xFE87 <= value && value <= 0xFE88) { return (true, to:[UnicodeScalar(0x0625)!]) }
    if (0xFE89 <= value && value <= 0xFE8C) { return (true, to:[UnicodeScalar(0x0626)!]) }
    if (0xFE8D <= value && value <= 0xFE8E) { return (true, to:[UnicodeScalar(0x0627)!]) }
    if (0xFE8F <= value && value <= 0xFE92) { return (true, to:[UnicodeScalar(0x0628)!]) }
    if (0xFE93 <= value && value <= 0xFE94) { return (true, to:[UnicodeScalar(0x0629)!]) }
    if (0xFE95 <= value && value <= 0xFE98) { return (true, to:[UnicodeScalar(0x062A)!]) }
    if (0xFE99 <= value && value <= 0xFE9C) { return (true, to:[UnicodeScalar(0x062B)!]) }
    if (0xFE9D <= value && value <= 0xFEA0) { return (true, to:[UnicodeScalar(0x062C)!]) }
    if (0xFEA1 <= value && value <= 0xFEA4) { return (true, to:[UnicodeScalar(0x062D)!]) }
    if (0xFEA5 <= value && value <= 0xFEA8) { return (true, to:[UnicodeScalar(0x062E)!]) }
    if (0xFEA9 <= value && value <= 0xFEAA) { return (true, to:[UnicodeScalar(0x062F)!]) }
    if (0xFEAB <= value && value <= 0xFEAC) { return (true, to:[UnicodeScalar(0x0630)!]) }
    if (0xFEAD <= value && value <= 0xFEAE) { return (true, to:[UnicodeScalar(0x0631)!]) }
    if (0xFEAF <= value && value <= 0xFEB0) { return (true, to:[UnicodeScalar(0x0632)!]) }
    if (0xFEB1 <= value && value <= 0xFEB4) { return (true, to:[UnicodeScalar(0x0633)!]) }
    if (0xFEB5 <= value && value <= 0xFEB8) { return (true, to:[UnicodeScalar(0x0634)!]) }
    if (0xFEB9 <= value && value <= 0xFEBC) { return (true, to:[UnicodeScalar(0x0635)!]) }
    if (0xFEBD <= value && value <= 0xFEC0) { return (true, to:[UnicodeScalar(0x0636)!]) }
    if (0xFEC1 <= value && value <= 0xFEC4) { return (true, to:[UnicodeScalar(0x0637)!]) }
    if (0xFEC5 <= value && value <= 0xFEC8) { return (true, to:[UnicodeScalar(0x0638)!]) }
    if (0xFEC9 <= value && value <= 0xFECC) { return (true, to:[UnicodeScalar(0x0639)!]) }
    if (0xFECD <= value && value <= 0xFED0) { return (true, to:[UnicodeScalar(0x063A)!]) }
    if (0xFED1 <= value && value <= 0xFED4) { return (true, to:[UnicodeScalar(0x0641)!]) }
    if (0xFED5 <= value && value <= 0xFED8) { return (true, to:[UnicodeScalar(0x0642)!]) }
    if (0xFED9 <= value && value <= 0xFEDC) { return (true, to:[UnicodeScalar(0x0643)!]) }
    if (0xFEDD <= value && value <= 0xFEE0) { return (true, to:[UnicodeScalar(0x0644)!]) }
    if (0xFEE1 <= value && value <= 0xFEE4) { return (true, to:[UnicodeScalar(0x0645)!]) }
    if (0xFEE5 <= value && value <= 0xFEE8) { return (true, to:[UnicodeScalar(0x0646)!]) }
    if (0xFEE9 <= value && value <= 0xFEEC) { return (true, to:[UnicodeScalar(0x0647)!]) }
    if (0xFEED <= value && value <= 0xFEEE) { return (true, to:[UnicodeScalar(0x0648)!]) }
    if (0xFEEF <= value && value <= 0xFEF0) { return (true, to:[UnicodeScalar(0x0649)!]) }
    if (0xFEF1 <= value && value <= 0xFEF4) { return (true, to:[UnicodeScalar(0x064A)!]) }
    if (0xFEF5 <= value && value <= 0xFEF6) { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x0622)!]) }
    if (0xFEF7 <= value && value <= 0xFEF8) { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x0623)!]) }
    if (0xFEF9 <= value && value <= 0xFEFA) { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x0625)!]) }
    if (0xFEFB <= value && value <= 0xFEFC) { return (true, to:[UnicodeScalar(0x0644)!, UnicodeScalar(0x0627)!]) }
    if value == 0xFF0D { return (true, to:[UnicodeScalar(0x002D)!]) }
    if value == 0xFF0E { return (true, to:[UnicodeScalar(0x002E)!]) }
    if value == 0xFF10 { return (true, to:[UnicodeScalar(0x0030)!]) }
    if value == 0xFF11 { return (true, to:[UnicodeScalar(0x0031)!]) }
    if value == 0xFF12 { return (true, to:[UnicodeScalar(0x0032)!]) }
    if value == 0xFF13 { return (true, to:[UnicodeScalar(0x0033)!]) }
    if value == 0xFF14 { return (true, to:[UnicodeScalar(0x0034)!]) }
    if value == 0xFF15 { return (true, to:[UnicodeScalar(0x0035)!]) }
    if value == 0xFF16 { return (true, to:[UnicodeScalar(0x0036)!]) }
    if value == 0xFF17 { return (true, to:[UnicodeScalar(0x0037)!]) }
    if value == 0xFF18 { return (true, to:[UnicodeScalar(0x0038)!]) }
    if value == 0xFF19 { return (true, to:[UnicodeScalar(0x0039)!]) }
    if value == 0xFF21 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0xFF22 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0xFF23 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0xFF24 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0xFF25 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0xFF26 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0xFF27 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0xFF28 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0xFF29 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0xFF2A { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0xFF2B { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0xFF2C { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0xFF2D { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0xFF2E { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0xFF2F { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0xFF30 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0xFF31 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0xFF32 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0xFF33 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0xFF34 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0xFF35 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0xFF36 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0xFF37 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0xFF38 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0xFF39 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0xFF3A { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0xFF41 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0xFF42 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0xFF43 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0xFF44 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0xFF45 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0xFF46 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0xFF47 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0xFF48 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0xFF49 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0xFF4A { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0xFF4B { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0xFF4C { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0xFF4D { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0xFF4E { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0xFF4F { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0xFF50 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0xFF51 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0xFF52 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0xFF53 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0xFF54 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0xFF55 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0xFF56 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0xFF57 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0xFF58 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0xFF59 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0xFF5A { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0xFF5F { return (true, to:[UnicodeScalar(0x2985)!]) }
    if value == 0xFF60 { return (true, to:[UnicodeScalar(0x2986)!]) }
    if value == 0xFF61 { return (true, to:[UnicodeScalar(0x002E)!]) }
    if value == 0xFF62 { return (true, to:[UnicodeScalar(0x300C)!]) }
    if value == 0xFF63 { return (true, to:[UnicodeScalar(0x300D)!]) }
    if value == 0xFF64 { return (true, to:[UnicodeScalar(0x3001)!]) }
    if value == 0xFF65 { return (true, to:[UnicodeScalar(0x30FB)!]) }
    if value == 0xFF66 { return (true, to:[UnicodeScalar(0x30F2)!]) }
    if value == 0xFF67 { return (true, to:[UnicodeScalar(0x30A1)!]) }
    if value == 0xFF68 { return (true, to:[UnicodeScalar(0x30A3)!]) }
    if value == 0xFF69 { return (true, to:[UnicodeScalar(0x30A5)!]) }
    if value == 0xFF6A { return (true, to:[UnicodeScalar(0x30A7)!]) }
    if value == 0xFF6B { return (true, to:[UnicodeScalar(0x30A9)!]) }
    if value == 0xFF6C { return (true, to:[UnicodeScalar(0x30E3)!]) }
    if value == 0xFF6D { return (true, to:[UnicodeScalar(0x30E5)!]) }
    if value == 0xFF6E { return (true, to:[UnicodeScalar(0x30E7)!]) }
    if value == 0xFF6F { return (true, to:[UnicodeScalar(0x30C3)!]) }
    if value == 0xFF70 { return (true, to:[UnicodeScalar(0x30FC)!]) }
    if value == 0xFF71 { return (true, to:[UnicodeScalar(0x30A2)!]) }
    if value == 0xFF72 { return (true, to:[UnicodeScalar(0x30A4)!]) }
    if value == 0xFF73 { return (true, to:[UnicodeScalar(0x30A6)!]) }
    if value == 0xFF74 { return (true, to:[UnicodeScalar(0x30A8)!]) }
    if value == 0xFF75 { return (true, to:[UnicodeScalar(0x30AA)!]) }
    if value == 0xFF76 { return (true, to:[UnicodeScalar(0x30AB)!]) }
    if value == 0xFF77 { return (true, to:[UnicodeScalar(0x30AD)!]) }
    if value == 0xFF78 { return (true, to:[UnicodeScalar(0x30AF)!]) }
    if value == 0xFF79 { return (true, to:[UnicodeScalar(0x30B1)!]) }
    if value == 0xFF7A { return (true, to:[UnicodeScalar(0x30B3)!]) }
    if value == 0xFF7B { return (true, to:[UnicodeScalar(0x30B5)!]) }
    if value == 0xFF7C { return (true, to:[UnicodeScalar(0x30B7)!]) }
    if value == 0xFF7D { return (true, to:[UnicodeScalar(0x30B9)!]) }
    if value == 0xFF7E { return (true, to:[UnicodeScalar(0x30BB)!]) }
    if value == 0xFF7F { return (true, to:[UnicodeScalar(0x30BD)!]) }
    if value == 0xFF80 { return (true, to:[UnicodeScalar(0x30BF)!]) }
    if value == 0xFF81 { return (true, to:[UnicodeScalar(0x30C1)!]) }
    if value == 0xFF82 { return (true, to:[UnicodeScalar(0x30C4)!]) }
    if value == 0xFF83 { return (true, to:[UnicodeScalar(0x30C6)!]) }
    if value == 0xFF84 { return (true, to:[UnicodeScalar(0x30C8)!]) }
    if value == 0xFF85 { return (true, to:[UnicodeScalar(0x30CA)!]) }
    if value == 0xFF86 { return (true, to:[UnicodeScalar(0x30CB)!]) }
    if value == 0xFF87 { return (true, to:[UnicodeScalar(0x30CC)!]) }
    if value == 0xFF88 { return (true, to:[UnicodeScalar(0x30CD)!]) }
    if value == 0xFF89 { return (true, to:[UnicodeScalar(0x30CE)!]) }
    if value == 0xFF8A { return (true, to:[UnicodeScalar(0x30CF)!]) }
    if value == 0xFF8B { return (true, to:[UnicodeScalar(0x30D2)!]) }
    if value == 0xFF8C { return (true, to:[UnicodeScalar(0x30D5)!]) }
    if value == 0xFF8D { return (true, to:[UnicodeScalar(0x30D8)!]) }
    if value == 0xFF8E { return (true, to:[UnicodeScalar(0x30DB)!]) }
    if value == 0xFF8F { return (true, to:[UnicodeScalar(0x30DE)!]) }
    if value == 0xFF90 { return (true, to:[UnicodeScalar(0x30DF)!]) }
    if value == 0xFF91 { return (true, to:[UnicodeScalar(0x30E0)!]) }
    if value == 0xFF92 { return (true, to:[UnicodeScalar(0x30E1)!]) }
    if value == 0xFF93 { return (true, to:[UnicodeScalar(0x30E2)!]) }
    if value == 0xFF94 { return (true, to:[UnicodeScalar(0x30E4)!]) }
    if value == 0xFF95 { return (true, to:[UnicodeScalar(0x30E6)!]) }
    if value == 0xFF96 { return (true, to:[UnicodeScalar(0x30E8)!]) }
    if value == 0xFF97 { return (true, to:[UnicodeScalar(0x30E9)!]) }
    if value == 0xFF98 { return (true, to:[UnicodeScalar(0x30EA)!]) }
    if value == 0xFF99 { return (true, to:[UnicodeScalar(0x30EB)!]) }
    if value == 0xFF9A { return (true, to:[UnicodeScalar(0x30EC)!]) }
    if value == 0xFF9B { return (true, to:[UnicodeScalar(0x30ED)!]) }
    if value == 0xFF9C { return (true, to:[UnicodeScalar(0x30EF)!]) }
    if value == 0xFF9D { return (true, to:[UnicodeScalar(0x30F3)!]) }
    if value == 0xFF9E { return (true, to:[UnicodeScalar(0x3099)!]) }
    if value == 0xFF9F { return (true, to:[UnicodeScalar(0x309A)!]) }
    if value == 0xFFA1 { return (true, to:[UnicodeScalar(0x1100)!]) }
    if value == 0xFFA2 { return (true, to:[UnicodeScalar(0x1101)!]) }
    if value == 0xFFA3 { return (true, to:[UnicodeScalar(0x11AA)!]) }
    if value == 0xFFA4 { return (true, to:[UnicodeScalar(0x1102)!]) }
    if value == 0xFFA5 { return (true, to:[UnicodeScalar(0x11AC)!]) }
    if value == 0xFFA6 { return (true, to:[UnicodeScalar(0x11AD)!]) }
    if value == 0xFFA7 { return (true, to:[UnicodeScalar(0x1103)!]) }
    if value == 0xFFA8 { return (true, to:[UnicodeScalar(0x1104)!]) }
    if value == 0xFFA9 { return (true, to:[UnicodeScalar(0x1105)!]) }
    if value == 0xFFAA { return (true, to:[UnicodeScalar(0x11B0)!]) }
    if value == 0xFFAB { return (true, to:[UnicodeScalar(0x11B1)!]) }
    if value == 0xFFAC { return (true, to:[UnicodeScalar(0x11B2)!]) }
    if value == 0xFFAD { return (true, to:[UnicodeScalar(0x11B3)!]) }
    if value == 0xFFAE { return (true, to:[UnicodeScalar(0x11B4)!]) }
    if value == 0xFFAF { return (true, to:[UnicodeScalar(0x11B5)!]) }
    if value == 0xFFB0 { return (true, to:[UnicodeScalar(0x111A)!]) }
    if value == 0xFFB1 { return (true, to:[UnicodeScalar(0x1106)!]) }
    if value == 0xFFB2 { return (true, to:[UnicodeScalar(0x1107)!]) }
    if value == 0xFFB3 { return (true, to:[UnicodeScalar(0x1108)!]) }
    if value == 0xFFB4 { return (true, to:[UnicodeScalar(0x1121)!]) }
    if value == 0xFFB5 { return (true, to:[UnicodeScalar(0x1109)!]) }
    if value == 0xFFB6 { return (true, to:[UnicodeScalar(0x110A)!]) }
    if value == 0xFFB7 { return (true, to:[UnicodeScalar(0x110B)!]) }
    if value == 0xFFB8 { return (true, to:[UnicodeScalar(0x110C)!]) }
    if value == 0xFFB9 { return (true, to:[UnicodeScalar(0x110D)!]) }
    if value == 0xFFBA { return (true, to:[UnicodeScalar(0x110E)!]) }
    if value == 0xFFBB { return (true, to:[UnicodeScalar(0x110F)!]) }
    if value == 0xFFBC { return (true, to:[UnicodeScalar(0x1110)!]) }
    if value == 0xFFBD { return (true, to:[UnicodeScalar(0x1111)!]) }
    if value == 0xFFBE { return (true, to:[UnicodeScalar(0x1112)!]) }
    if value == 0xFFC2 { return (true, to:[UnicodeScalar(0x1161)!]) }
    if value == 0xFFC3 { return (true, to:[UnicodeScalar(0x1162)!]) }
    if value == 0xFFC4 { return (true, to:[UnicodeScalar(0x1163)!]) }
    if value == 0xFFC5 { return (true, to:[UnicodeScalar(0x1164)!]) }
    if value == 0xFFC6 { return (true, to:[UnicodeScalar(0x1165)!]) }
    if value == 0xFFC7 { return (true, to:[UnicodeScalar(0x1166)!]) }
    if value == 0xFFCA { return (true, to:[UnicodeScalar(0x1167)!]) }
    if value == 0xFFCB { return (true, to:[UnicodeScalar(0x1168)!]) }
    if value == 0xFFCC { return (true, to:[UnicodeScalar(0x1169)!]) }
    if value == 0xFFCD { return (true, to:[UnicodeScalar(0x116A)!]) }
    if value == 0xFFCE { return (true, to:[UnicodeScalar(0x116B)!]) }
    if value == 0xFFCF { return (true, to:[UnicodeScalar(0x116C)!]) }
    if value == 0xFFD2 { return (true, to:[UnicodeScalar(0x116D)!]) }
    if value == 0xFFD3 { return (true, to:[UnicodeScalar(0x116E)!]) }
    if value == 0xFFD4 { return (true, to:[UnicodeScalar(0x116F)!]) }
    if value == 0xFFD5 { return (true, to:[UnicodeScalar(0x1170)!]) }
    if value == 0xFFD6 { return (true, to:[UnicodeScalar(0x1171)!]) }
    if value == 0xFFD7 { return (true, to:[UnicodeScalar(0x1172)!]) }
    if value == 0xFFDA { return (true, to:[UnicodeScalar(0x1173)!]) }
    if value == 0xFFDB { return (true, to:[UnicodeScalar(0x1174)!]) }
    if value == 0xFFDC { return (true, to:[UnicodeScalar(0x1175)!]) }
    if value == 0xFFE0 { return (true, to:[UnicodeScalar(0x00A2)!]) }
    if value == 0xFFE1 { return (true, to:[UnicodeScalar(0x00A3)!]) }
    if value == 0xFFE2 { return (true, to:[UnicodeScalar(0x00AC)!]) }
    if value == 0xFFE4 { return (true, to:[UnicodeScalar(0x00A6)!]) }
    if value == 0xFFE5 { return (true, to:[UnicodeScalar(0x00A5)!]) }
    if value == 0xFFE6 { return (true, to:[UnicodeScalar(0x20A9)!]) }
    if value == 0xFFE8 { return (true, to:[UnicodeScalar(0x2502)!]) }
    if value == 0xFFE9 { return (true, to:[UnicodeScalar(0x2190)!]) }
    if value == 0xFFEA { return (true, to:[UnicodeScalar(0x2191)!]) }
    if value == 0xFFEB { return (true, to:[UnicodeScalar(0x2192)!]) }
    if value == 0xFFEC { return (true, to:[UnicodeScalar(0x2193)!]) }
    if value == 0xFFED { return (true, to:[UnicodeScalar(0x25A0)!]) }
    if value == 0xFFEE { return (true, to:[UnicodeScalar(0x25CB)!]) }
    if value == 0x10400 { return (true, to:[UnicodeScalar(0x10428)!]) }
    if value == 0x10401 { return (true, to:[UnicodeScalar(0x10429)!]) }
    if value == 0x10402 { return (true, to:[UnicodeScalar(0x1042A)!]) }
    if value == 0x10403 { return (true, to:[UnicodeScalar(0x1042B)!]) }
    if value == 0x10404 { return (true, to:[UnicodeScalar(0x1042C)!]) }
    if value == 0x10405 { return (true, to:[UnicodeScalar(0x1042D)!]) }
    if value == 0x10406 { return (true, to:[UnicodeScalar(0x1042E)!]) }
    if value == 0x10407 { return (true, to:[UnicodeScalar(0x1042F)!]) }
    if value == 0x10408 { return (true, to:[UnicodeScalar(0x10430)!]) }
    if value == 0x10409 { return (true, to:[UnicodeScalar(0x10431)!]) }
    if value == 0x1040A { return (true, to:[UnicodeScalar(0x10432)!]) }
    if value == 0x1040B { return (true, to:[UnicodeScalar(0x10433)!]) }
    if value == 0x1040C { return (true, to:[UnicodeScalar(0x10434)!]) }
    if value == 0x1040D { return (true, to:[UnicodeScalar(0x10435)!]) }
    if value == 0x1040E { return (true, to:[UnicodeScalar(0x10436)!]) }
    if value == 0x1040F { return (true, to:[UnicodeScalar(0x10437)!]) }
    if value == 0x10410 { return (true, to:[UnicodeScalar(0x10438)!]) }
    if value == 0x10411 { return (true, to:[UnicodeScalar(0x10439)!]) }
    if value == 0x10412 { return (true, to:[UnicodeScalar(0x1043A)!]) }
    if value == 0x10413 { return (true, to:[UnicodeScalar(0x1043B)!]) }
    if value == 0x10414 { return (true, to:[UnicodeScalar(0x1043C)!]) }
    if value == 0x10415 { return (true, to:[UnicodeScalar(0x1043D)!]) }
    if value == 0x10416 { return (true, to:[UnicodeScalar(0x1043E)!]) }
    if value == 0x10417 { return (true, to:[UnicodeScalar(0x1043F)!]) }
    if value == 0x10418 { return (true, to:[UnicodeScalar(0x10440)!]) }
    if value == 0x10419 { return (true, to:[UnicodeScalar(0x10441)!]) }
    if value == 0x1041A { return (true, to:[UnicodeScalar(0x10442)!]) }
    if value == 0x1041B { return (true, to:[UnicodeScalar(0x10443)!]) }
    if value == 0x1041C { return (true, to:[UnicodeScalar(0x10444)!]) }
    if value == 0x1041D { return (true, to:[UnicodeScalar(0x10445)!]) }
    if value == 0x1041E { return (true, to:[UnicodeScalar(0x10446)!]) }
    if value == 0x1041F { return (true, to:[UnicodeScalar(0x10447)!]) }
    if value == 0x10420 { return (true, to:[UnicodeScalar(0x10448)!]) }
    if value == 0x10421 { return (true, to:[UnicodeScalar(0x10449)!]) }
    if value == 0x10422 { return (true, to:[UnicodeScalar(0x1044A)!]) }
    if value == 0x10423 { return (true, to:[UnicodeScalar(0x1044B)!]) }
    if value == 0x10424 { return (true, to:[UnicodeScalar(0x1044C)!]) }
    if value == 0x10425 { return (true, to:[UnicodeScalar(0x1044D)!]) }
    if value == 0x10426 { return (true, to:[UnicodeScalar(0x1044E)!]) }
    if value == 0x10427 { return (true, to:[UnicodeScalar(0x1044F)!]) }
    if value == 0x104B0 { return (true, to:[UnicodeScalar(0x104D8)!]) }
    if value == 0x104B1 { return (true, to:[UnicodeScalar(0x104D9)!]) }
    if value == 0x104B2 { return (true, to:[UnicodeScalar(0x104DA)!]) }
    if value == 0x104B3 { return (true, to:[UnicodeScalar(0x104DB)!]) }
    if value == 0x104B4 { return (true, to:[UnicodeScalar(0x104DC)!]) }
    if value == 0x104B5 { return (true, to:[UnicodeScalar(0x104DD)!]) }
    if value == 0x104B6 { return (true, to:[UnicodeScalar(0x104DE)!]) }
    if value == 0x104B7 { return (true, to:[UnicodeScalar(0x104DF)!]) }
    if value == 0x104B8 { return (true, to:[UnicodeScalar(0x104E0)!]) }
    if value == 0x104B9 { return (true, to:[UnicodeScalar(0x104E1)!]) }
    if value == 0x104BA { return (true, to:[UnicodeScalar(0x104E2)!]) }
    if value == 0x104BB { return (true, to:[UnicodeScalar(0x104E3)!]) }
    if value == 0x104BC { return (true, to:[UnicodeScalar(0x104E4)!]) }
    if value == 0x104BD { return (true, to:[UnicodeScalar(0x104E5)!]) }
    if value == 0x104BE { return (true, to:[UnicodeScalar(0x104E6)!]) }
    if value == 0x104BF { return (true, to:[UnicodeScalar(0x104E7)!]) }
    if value == 0x104C0 { return (true, to:[UnicodeScalar(0x104E8)!]) }
    if value == 0x104C1 { return (true, to:[UnicodeScalar(0x104E9)!]) }
    if value == 0x104C2 { return (true, to:[UnicodeScalar(0x104EA)!]) }
    if value == 0x104C3 { return (true, to:[UnicodeScalar(0x104EB)!]) }
    if value == 0x104C4 { return (true, to:[UnicodeScalar(0x104EC)!]) }
    if value == 0x104C5 { return (true, to:[UnicodeScalar(0x104ED)!]) }
    if value == 0x104C6 { return (true, to:[UnicodeScalar(0x104EE)!]) }
    if value == 0x104C7 { return (true, to:[UnicodeScalar(0x104EF)!]) }
    if value == 0x104C8 { return (true, to:[UnicodeScalar(0x104F0)!]) }
    if value == 0x104C9 { return (true, to:[UnicodeScalar(0x104F1)!]) }
    if value == 0x104CA { return (true, to:[UnicodeScalar(0x104F2)!]) }
    if value == 0x104CB { return (true, to:[UnicodeScalar(0x104F3)!]) }
    if value == 0x104CC { return (true, to:[UnicodeScalar(0x104F4)!]) }
    if value == 0x104CD { return (true, to:[UnicodeScalar(0x104F5)!]) }
    if value == 0x104CE { return (true, to:[UnicodeScalar(0x104F6)!]) }
    if value == 0x104CF { return (true, to:[UnicodeScalar(0x104F7)!]) }
    if value == 0x104D0 { return (true, to:[UnicodeScalar(0x104F8)!]) }
    if value == 0x104D1 { return (true, to:[UnicodeScalar(0x104F9)!]) }
    if value == 0x104D2 { return (true, to:[UnicodeScalar(0x104FA)!]) }
    if value == 0x104D3 { return (true, to:[UnicodeScalar(0x104FB)!]) }
    if value == 0x10C80 { return (true, to:[UnicodeScalar(0x10CC0)!]) }
    if value == 0x10C81 { return (true, to:[UnicodeScalar(0x10CC1)!]) }
    if value == 0x10C82 { return (true, to:[UnicodeScalar(0x10CC2)!]) }
    if value == 0x10C83 { return (true, to:[UnicodeScalar(0x10CC3)!]) }
    if value == 0x10C84 { return (true, to:[UnicodeScalar(0x10CC4)!]) }
    if value == 0x10C85 { return (true, to:[UnicodeScalar(0x10CC5)!]) }
    if value == 0x10C86 { return (true, to:[UnicodeScalar(0x10CC6)!]) }
    if value == 0x10C87 { return (true, to:[UnicodeScalar(0x10CC7)!]) }
    if value == 0x10C88 { return (true, to:[UnicodeScalar(0x10CC8)!]) }
    if value == 0x10C89 { return (true, to:[UnicodeScalar(0x10CC9)!]) }
    if value == 0x10C8A { return (true, to:[UnicodeScalar(0x10CCA)!]) }
    if value == 0x10C8B { return (true, to:[UnicodeScalar(0x10CCB)!]) }
    if value == 0x10C8C { return (true, to:[UnicodeScalar(0x10CCC)!]) }
    if value == 0x10C8D { return (true, to:[UnicodeScalar(0x10CCD)!]) }
    if value == 0x10C8E { return (true, to:[UnicodeScalar(0x10CCE)!]) }
    if value == 0x10C8F { return (true, to:[UnicodeScalar(0x10CCF)!]) }
    if value == 0x10C90 { return (true, to:[UnicodeScalar(0x10CD0)!]) }
    if value == 0x10C91 { return (true, to:[UnicodeScalar(0x10CD1)!]) }
    if value == 0x10C92 { return (true, to:[UnicodeScalar(0x10CD2)!]) }
    if value == 0x10C93 { return (true, to:[UnicodeScalar(0x10CD3)!]) }
    if value == 0x10C94 { return (true, to:[UnicodeScalar(0x10CD4)!]) }
    if value == 0x10C95 { return (true, to:[UnicodeScalar(0x10CD5)!]) }
    if value == 0x10C96 { return (true, to:[UnicodeScalar(0x10CD6)!]) }
    if value == 0x10C97 { return (true, to:[UnicodeScalar(0x10CD7)!]) }
    if value == 0x10C98 { return (true, to:[UnicodeScalar(0x10CD8)!]) }
    if value == 0x10C99 { return (true, to:[UnicodeScalar(0x10CD9)!]) }
    if value == 0x10C9A { return (true, to:[UnicodeScalar(0x10CDA)!]) }
    if value == 0x10C9B { return (true, to:[UnicodeScalar(0x10CDB)!]) }
    if value == 0x10C9C { return (true, to:[UnicodeScalar(0x10CDC)!]) }
    if value == 0x10C9D { return (true, to:[UnicodeScalar(0x10CDD)!]) }
    if value == 0x10C9E { return (true, to:[UnicodeScalar(0x10CDE)!]) }
    if value == 0x10C9F { return (true, to:[UnicodeScalar(0x10CDF)!]) }
    if value == 0x10CA0 { return (true, to:[UnicodeScalar(0x10CE0)!]) }
    if value == 0x10CA1 { return (true, to:[UnicodeScalar(0x10CE1)!]) }
    if value == 0x10CA2 { return (true, to:[UnicodeScalar(0x10CE2)!]) }
    if value == 0x10CA3 { return (true, to:[UnicodeScalar(0x10CE3)!]) }
    if value == 0x10CA4 { return (true, to:[UnicodeScalar(0x10CE4)!]) }
    if value == 0x10CA5 { return (true, to:[UnicodeScalar(0x10CE5)!]) }
    if value == 0x10CA6 { return (true, to:[UnicodeScalar(0x10CE6)!]) }
    if value == 0x10CA7 { return (true, to:[UnicodeScalar(0x10CE7)!]) }
    if value == 0x10CA8 { return (true, to:[UnicodeScalar(0x10CE8)!]) }
    if value == 0x10CA9 { return (true, to:[UnicodeScalar(0x10CE9)!]) }
    if value == 0x10CAA { return (true, to:[UnicodeScalar(0x10CEA)!]) }
    if value == 0x10CAB { return (true, to:[UnicodeScalar(0x10CEB)!]) }
    if value == 0x10CAC { return (true, to:[UnicodeScalar(0x10CEC)!]) }
    if value == 0x10CAD { return (true, to:[UnicodeScalar(0x10CED)!]) }
    if value == 0x10CAE { return (true, to:[UnicodeScalar(0x10CEE)!]) }
    if value == 0x10CAF { return (true, to:[UnicodeScalar(0x10CEF)!]) }
    if value == 0x10CB0 { return (true, to:[UnicodeScalar(0x10CF0)!]) }
    if value == 0x10CB1 { return (true, to:[UnicodeScalar(0x10CF1)!]) }
    if value == 0x10CB2 { return (true, to:[UnicodeScalar(0x10CF2)!]) }
    if value == 0x118A0 { return (true, to:[UnicodeScalar(0x118C0)!]) }
    if value == 0x118A1 { return (true, to:[UnicodeScalar(0x118C1)!]) }
    if value == 0x118A2 { return (true, to:[UnicodeScalar(0x118C2)!]) }
    if value == 0x118A3 { return (true, to:[UnicodeScalar(0x118C3)!]) }
    if value == 0x118A4 { return (true, to:[UnicodeScalar(0x118C4)!]) }
    if value == 0x118A5 { return (true, to:[UnicodeScalar(0x118C5)!]) }
    if value == 0x118A6 { return (true, to:[UnicodeScalar(0x118C6)!]) }
    if value == 0x118A7 { return (true, to:[UnicodeScalar(0x118C7)!]) }
    if value == 0x118A8 { return (true, to:[UnicodeScalar(0x118C8)!]) }
    if value == 0x118A9 { return (true, to:[UnicodeScalar(0x118C9)!]) }
    if value == 0x118AA { return (true, to:[UnicodeScalar(0x118CA)!]) }
    if value == 0x118AB { return (true, to:[UnicodeScalar(0x118CB)!]) }
    if value == 0x118AC { return (true, to:[UnicodeScalar(0x118CC)!]) }
    if value == 0x118AD { return (true, to:[UnicodeScalar(0x118CD)!]) }
    if value == 0x118AE { return (true, to:[UnicodeScalar(0x118CE)!]) }
    if value == 0x118AF { return (true, to:[UnicodeScalar(0x118CF)!]) }
    if value == 0x118B0 { return (true, to:[UnicodeScalar(0x118D0)!]) }
    if value == 0x118B1 { return (true, to:[UnicodeScalar(0x118D1)!]) }
    if value == 0x118B2 { return (true, to:[UnicodeScalar(0x118D2)!]) }
    if value == 0x118B3 { return (true, to:[UnicodeScalar(0x118D3)!]) }
    if value == 0x118B4 { return (true, to:[UnicodeScalar(0x118D4)!]) }
    if value == 0x118B5 { return (true, to:[UnicodeScalar(0x118D5)!]) }
    if value == 0x118B6 { return (true, to:[UnicodeScalar(0x118D6)!]) }
    if value == 0x118B7 { return (true, to:[UnicodeScalar(0x118D7)!]) }
    if value == 0x118B8 { return (true, to:[UnicodeScalar(0x118D8)!]) }
    if value == 0x118B9 { return (true, to:[UnicodeScalar(0x118D9)!]) }
    if value == 0x118BA { return (true, to:[UnicodeScalar(0x118DA)!]) }
    if value == 0x118BB { return (true, to:[UnicodeScalar(0x118DB)!]) }
    if value == 0x118BC { return (true, to:[UnicodeScalar(0x118DC)!]) }
    if value == 0x118BD { return (true, to:[UnicodeScalar(0x118DD)!]) }
    if value == 0x118BE { return (true, to:[UnicodeScalar(0x118DE)!]) }
    if value == 0x118BF { return (true, to:[UnicodeScalar(0x118DF)!]) }
    if value == 0x1D15E { return (true, to:[UnicodeScalar(0x1D157)!, UnicodeScalar(0x1D165)!]) }
    if value == 0x1D15F { return (true, to:[UnicodeScalar(0x1D158)!, UnicodeScalar(0x1D165)!]) }
    if value == 0x1D160 { return (true, to:[UnicodeScalar(0x1D158)!, UnicodeScalar(0x1D165)!, UnicodeScalar(0x1D16E)!]) }
    if value == 0x1D161 { return (true, to:[UnicodeScalar(0x1D158)!, UnicodeScalar(0x1D165)!, UnicodeScalar(0x1D16F)!]) }
    if value == 0x1D162 { return (true, to:[UnicodeScalar(0x1D158)!, UnicodeScalar(0x1D165)!, UnicodeScalar(0x1D170)!]) }
    if value == 0x1D163 { return (true, to:[UnicodeScalar(0x1D158)!, UnicodeScalar(0x1D165)!, UnicodeScalar(0x1D171)!]) }
    if value == 0x1D164 { return (true, to:[UnicodeScalar(0x1D158)!, UnicodeScalar(0x1D165)!, UnicodeScalar(0x1D172)!]) }
    if value == 0x1D1BB { return (true, to:[UnicodeScalar(0x1D1B9)!, UnicodeScalar(0x1D165)!]) }
    if value == 0x1D1BC { return (true, to:[UnicodeScalar(0x1D1BA)!, UnicodeScalar(0x1D165)!]) }
    if value == 0x1D1BD { return (true, to:[UnicodeScalar(0x1D1B9)!, UnicodeScalar(0x1D165)!, UnicodeScalar(0x1D16E)!]) }
    if value == 0x1D1BE { return (true, to:[UnicodeScalar(0x1D1BA)!, UnicodeScalar(0x1D165)!, UnicodeScalar(0x1D16E)!]) }
    if value == 0x1D1BF { return (true, to:[UnicodeScalar(0x1D1B9)!, UnicodeScalar(0x1D165)!, UnicodeScalar(0x1D16F)!]) }
    if value == 0x1D1C0 { return (true, to:[UnicodeScalar(0x1D1BA)!, UnicodeScalar(0x1D165)!, UnicodeScalar(0x1D16F)!]) }
    if value == 0x1D400 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D401 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D402 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D403 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D404 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D405 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D406 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D407 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D408 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D409 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D40A { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D40B { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D40C { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D40D { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D40E { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D40F { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D410 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D411 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D412 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D413 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D414 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D415 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D416 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D417 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D418 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D419 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D41A { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D41B { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D41C { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D41D { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D41E { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D41F { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D420 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D421 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D422 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D423 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D424 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D425 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D426 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D427 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D428 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D429 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D42A { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D42B { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D42C { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D42D { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D42E { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D42F { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D430 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D431 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D432 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D433 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D434 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D435 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D436 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D437 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D438 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D439 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D43A { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D43B { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D43C { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D43D { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D43E { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D43F { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D440 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D441 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D442 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D443 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D444 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D445 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D446 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D447 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D448 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D449 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D44A { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D44B { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D44C { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D44D { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D44E { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D44F { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D450 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D451 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D452 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D453 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D454 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D456 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D457 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D458 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D459 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D45A { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D45B { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D45C { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D45D { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D45E { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D45F { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D460 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D461 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D462 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D463 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D464 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D465 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D466 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D467 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D468 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D469 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D46A { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D46B { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D46C { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D46D { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D46E { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D46F { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D470 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D471 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D472 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D473 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D474 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D475 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D476 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D477 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D478 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D479 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D47A { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D47B { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D47C { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D47D { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D47E { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D47F { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D480 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D481 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D482 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D483 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D484 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D485 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D486 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D487 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D488 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D489 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D48A { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D48B { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D48C { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D48D { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D48E { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D48F { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D490 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D491 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D492 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D493 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D494 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D495 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D496 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D497 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D498 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D499 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D49A { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D49B { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D49C { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D49E { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D49F { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D4A2 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D4A5 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D4A6 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D4A9 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D4AA { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D4AB { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D4AC { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D4AE { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D4AF { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D4B0 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D4B1 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D4B2 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D4B3 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D4B4 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D4B5 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D4B6 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D4B7 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D4B8 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D4B9 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D4BB { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D4BD { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D4BE { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D4BF { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D4C0 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D4C1 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D4C2 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D4C3 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D4C5 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D4C6 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D4C7 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D4C8 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D4C9 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D4CA { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D4CB { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D4CC { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D4CD { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D4CE { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D4CF { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D4D0 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D4D1 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D4D2 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D4D3 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D4D4 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D4D5 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D4D6 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D4D7 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D4D8 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D4D9 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D4DA { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D4DB { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D4DC { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D4DD { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D4DE { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D4DF { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D4E0 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D4E1 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D4E2 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D4E3 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D4E4 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D4E5 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D4E6 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D4E7 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D4E8 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D4E9 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D4EA { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D4EB { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D4EC { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D4ED { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D4EE { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D4EF { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D4F0 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D4F1 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D4F2 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D4F3 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D4F4 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D4F5 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D4F6 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D4F7 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D4F8 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D4F9 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D4FA { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D4FB { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D4FC { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D4FD { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D4FE { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D4FF { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D500 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D501 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D502 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D503 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D504 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D505 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D507 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D508 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D509 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D50A { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D50D { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D50E { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D50F { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D510 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D511 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D512 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D513 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D514 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D516 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D517 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D518 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D519 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D51A { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D51B { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D51C { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D51E { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D51F { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D520 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D521 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D522 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D523 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D524 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D525 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D526 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D527 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D528 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D529 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D52A { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D52B { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D52C { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D52D { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D52E { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D52F { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D530 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D531 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D532 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D533 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D534 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D535 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D536 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D537 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D538 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D539 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D53B { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D53C { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D53D { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D53E { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D540 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D541 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D542 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D543 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D544 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D546 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D54A { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D54B { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D54C { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D54D { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D54E { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D54F { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D550 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D552 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D553 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D554 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D555 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D556 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D557 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D558 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D559 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D55A { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D55B { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D55C { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D55D { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D55E { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D55F { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D560 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D561 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D562 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D563 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D564 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D565 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D566 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D567 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D568 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D569 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D56A { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D56B { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D56C { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D56D { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D56E { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D56F { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D570 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D571 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D572 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D573 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D574 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D575 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D576 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D577 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D578 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D579 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D57A { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D57B { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D57C { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D57D { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D57E { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D57F { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D580 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D581 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D582 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D583 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D584 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D585 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D586 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D587 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D588 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D589 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D58A { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D58B { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D58C { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D58D { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D58E { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D58F { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D590 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D591 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D592 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D593 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D594 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D595 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D596 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D597 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D598 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D599 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D59A { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D59B { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D59C { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D59D { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D59E { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D59F { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D5A0 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D5A1 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D5A2 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D5A3 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D5A4 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D5A5 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D5A6 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D5A7 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D5A8 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D5A9 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D5AA { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D5AB { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D5AC { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D5AD { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D5AE { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D5AF { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D5B0 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D5B1 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D5B2 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D5B3 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D5B4 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D5B5 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D5B6 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D5B7 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D5B8 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D5B9 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D5BA { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D5BB { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D5BC { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D5BD { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D5BE { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D5BF { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D5C0 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D5C1 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D5C2 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D5C3 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D5C4 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D5C5 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D5C6 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D5C7 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D5C8 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D5C9 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D5CA { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D5CB { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D5CC { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D5CD { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D5CE { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D5CF { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D5D0 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D5D1 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D5D2 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D5D3 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D5D4 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D5D5 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D5D6 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D5D7 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D5D8 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D5D9 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D5DA { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D5DB { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D5DC { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D5DD { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D5DE { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D5DF { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D5E0 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D5E1 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D5E2 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D5E3 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D5E4 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D5E5 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D5E6 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D5E7 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D5E8 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D5E9 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D5EA { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D5EB { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D5EC { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D5ED { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D5EE { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D5EF { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D5F0 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D5F1 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D5F2 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D5F3 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D5F4 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D5F5 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D5F6 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D5F7 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D5F8 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D5F9 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D5FA { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D5FB { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D5FC { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D5FD { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D5FE { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D5FF { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D600 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D601 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D602 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D603 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D604 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D605 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D606 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D607 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D608 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D609 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D60A { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D60B { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D60C { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D60D { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D60E { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D60F { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D610 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D611 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D612 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D613 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D614 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D615 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D616 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D617 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D618 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D619 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D61A { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D61B { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D61C { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D61D { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D61E { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D61F { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D620 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D621 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D622 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D623 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D624 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D625 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D626 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D627 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D628 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D629 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D62A { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D62B { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D62C { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D62D { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D62E { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D62F { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D630 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D631 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D632 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D633 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D634 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D635 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D636 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D637 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D638 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D639 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D63A { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D63B { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D63C { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D63D { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D63E { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D63F { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D640 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D641 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D642 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D643 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D644 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D645 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D646 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D647 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D648 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D649 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D64A { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D64B { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D64C { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D64D { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D64E { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D64F { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D650 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D651 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D652 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D653 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D654 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D655 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D656 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D657 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D658 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D659 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D65A { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D65B { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D65C { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D65D { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D65E { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D65F { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D660 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D661 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D662 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D663 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D664 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D665 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D666 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D667 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D668 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D669 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D66A { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D66B { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D66C { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D66D { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D66E { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D66F { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D670 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D671 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D672 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D673 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D674 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D675 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D676 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D677 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D678 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D679 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D67A { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D67B { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D67C { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D67D { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D67E { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D67F { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D680 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D681 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D682 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D683 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D684 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D685 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D686 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D687 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D688 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D689 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D68A { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1D68B { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1D68C { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1D68D { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1D68E { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1D68F { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1D690 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1D691 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1D692 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1D693 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1D694 { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1D695 { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1D696 { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1D697 { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1D698 { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1D699 { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1D69A { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1D69B { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1D69C { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1D69D { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1D69E { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1D69F { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1D6A0 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1D6A1 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1D6A2 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1D6A3 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1D6A4 { return (true, to:[UnicodeScalar(0x0131)!]) }
    if value == 0x1D6A5 { return (true, to:[UnicodeScalar(0x0237)!]) }
    if value == 0x1D6A8 { return (true, to:[UnicodeScalar(0x03B1)!]) }
    if value == 0x1D6A9 { return (true, to:[UnicodeScalar(0x03B2)!]) }
    if value == 0x1D6AA { return (true, to:[UnicodeScalar(0x03B3)!]) }
    if value == 0x1D6AB { return (true, to:[UnicodeScalar(0x03B4)!]) }
    if value == 0x1D6AC { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x1D6AD { return (true, to:[UnicodeScalar(0x03B6)!]) }
    if value == 0x1D6AE { return (true, to:[UnicodeScalar(0x03B7)!]) }
    if value == 0x1D6AF { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D6B0 { return (true, to:[UnicodeScalar(0x03B9)!]) }
    if value == 0x1D6B1 { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x1D6B2 { return (true, to:[UnicodeScalar(0x03BB)!]) }
    if value == 0x1D6B3 { return (true, to:[UnicodeScalar(0x03BC)!]) }
    if value == 0x1D6B4 { return (true, to:[UnicodeScalar(0x03BD)!]) }
    if value == 0x1D6B5 { return (true, to:[UnicodeScalar(0x03BE)!]) }
    if value == 0x1D6B6 { return (true, to:[UnicodeScalar(0x03BF)!]) }
    if value == 0x1D6B7 { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x1D6B8 { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if value == 0x1D6B9 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D6BA { return (true, to:[UnicodeScalar(0x03C3)!]) }
    if value == 0x1D6BB { return (true, to:[UnicodeScalar(0x03C4)!]) }
    if value == 0x1D6BC { return (true, to:[UnicodeScalar(0x03C5)!]) }
    if value == 0x1D6BD { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D6BE { return (true, to:[UnicodeScalar(0x03C7)!]) }
    if value == 0x1D6BF { return (true, to:[UnicodeScalar(0x03C8)!]) }
    if value == 0x1D6C0 { return (true, to:[UnicodeScalar(0x03C9)!]) }
    if value == 0x1D6C1 { return (true, to:[UnicodeScalar(0x2207)!]) }
    if value == 0x1D6C2 { return (true, to:[UnicodeScalar(0x03B1)!]) }
    if value == 0x1D6C3 { return (true, to:[UnicodeScalar(0x03B2)!]) }
    if value == 0x1D6C4 { return (true, to:[UnicodeScalar(0x03B3)!]) }
    if value == 0x1D6C5 { return (true, to:[UnicodeScalar(0x03B4)!]) }
    if value == 0x1D6C6 { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x1D6C7 { return (true, to:[UnicodeScalar(0x03B6)!]) }
    if value == 0x1D6C8 { return (true, to:[UnicodeScalar(0x03B7)!]) }
    if value == 0x1D6C9 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D6CA { return (true, to:[UnicodeScalar(0x03B9)!]) }
    if value == 0x1D6CB { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x1D6CC { return (true, to:[UnicodeScalar(0x03BB)!]) }
    if value == 0x1D6CD { return (true, to:[UnicodeScalar(0x03BC)!]) }
    if value == 0x1D6CE { return (true, to:[UnicodeScalar(0x03BD)!]) }
    if value == 0x1D6CF { return (true, to:[UnicodeScalar(0x03BE)!]) }
    if value == 0x1D6D0 { return (true, to:[UnicodeScalar(0x03BF)!]) }
    if value == 0x1D6D1 { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x1D6D2 { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if (0x1D6D3 <= value && value <= 0x1D6D4) { return (true, to:[UnicodeScalar(0x03C3)!]) }
    if value == 0x1D6D5 { return (true, to:[UnicodeScalar(0x03C4)!]) }
    if value == 0x1D6D6 { return (true, to:[UnicodeScalar(0x03C5)!]) }
    if value == 0x1D6D7 { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D6D8 { return (true, to:[UnicodeScalar(0x03C7)!]) }
    if value == 0x1D6D9 { return (true, to:[UnicodeScalar(0x03C8)!]) }
    if value == 0x1D6DA { return (true, to:[UnicodeScalar(0x03C9)!]) }
    if value == 0x1D6DB { return (true, to:[UnicodeScalar(0x2202)!]) }
    if value == 0x1D6DC { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x1D6DD { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D6DE { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x1D6DF { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D6E0 { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if value == 0x1D6E1 { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x1D6E2 { return (true, to:[UnicodeScalar(0x03B1)!]) }
    if value == 0x1D6E3 { return (true, to:[UnicodeScalar(0x03B2)!]) }
    if value == 0x1D6E4 { return (true, to:[UnicodeScalar(0x03B3)!]) }
    if value == 0x1D6E5 { return (true, to:[UnicodeScalar(0x03B4)!]) }
    if value == 0x1D6E6 { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x1D6E7 { return (true, to:[UnicodeScalar(0x03B6)!]) }
    if value == 0x1D6E8 { return (true, to:[UnicodeScalar(0x03B7)!]) }
    if value == 0x1D6E9 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D6EA { return (true, to:[UnicodeScalar(0x03B9)!]) }
    if value == 0x1D6EB { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x1D6EC { return (true, to:[UnicodeScalar(0x03BB)!]) }
    if value == 0x1D6ED { return (true, to:[UnicodeScalar(0x03BC)!]) }
    if value == 0x1D6EE { return (true, to:[UnicodeScalar(0x03BD)!]) }
    if value == 0x1D6EF { return (true, to:[UnicodeScalar(0x03BE)!]) }
    if value == 0x1D6F0 { return (true, to:[UnicodeScalar(0x03BF)!]) }
    if value == 0x1D6F1 { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x1D6F2 { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if value == 0x1D6F3 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D6F4 { return (true, to:[UnicodeScalar(0x03C3)!]) }
    if value == 0x1D6F5 { return (true, to:[UnicodeScalar(0x03C4)!]) }
    if value == 0x1D6F6 { return (true, to:[UnicodeScalar(0x03C5)!]) }
    if value == 0x1D6F7 { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D6F8 { return (true, to:[UnicodeScalar(0x03C7)!]) }
    if value == 0x1D6F9 { return (true, to:[UnicodeScalar(0x03C8)!]) }
    if value == 0x1D6FA { return (true, to:[UnicodeScalar(0x03C9)!]) }
    if value == 0x1D6FB { return (true, to:[UnicodeScalar(0x2207)!]) }
    if value == 0x1D6FC { return (true, to:[UnicodeScalar(0x03B1)!]) }
    if value == 0x1D6FD { return (true, to:[UnicodeScalar(0x03B2)!]) }
    if value == 0x1D6FE { return (true, to:[UnicodeScalar(0x03B3)!]) }
    if value == 0x1D6FF { return (true, to:[UnicodeScalar(0x03B4)!]) }
    if value == 0x1D700 { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x1D701 { return (true, to:[UnicodeScalar(0x03B6)!]) }
    if value == 0x1D702 { return (true, to:[UnicodeScalar(0x03B7)!]) }
    if value == 0x1D703 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D704 { return (true, to:[UnicodeScalar(0x03B9)!]) }
    if value == 0x1D705 { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x1D706 { return (true, to:[UnicodeScalar(0x03BB)!]) }
    if value == 0x1D707 { return (true, to:[UnicodeScalar(0x03BC)!]) }
    if value == 0x1D708 { return (true, to:[UnicodeScalar(0x03BD)!]) }
    if value == 0x1D709 { return (true, to:[UnicodeScalar(0x03BE)!]) }
    if value == 0x1D70A { return (true, to:[UnicodeScalar(0x03BF)!]) }
    if value == 0x1D70B { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x1D70C { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if (0x1D70D <= value && value <= 0x1D70E) { return (true, to:[UnicodeScalar(0x03C3)!]) }
    if value == 0x1D70F { return (true, to:[UnicodeScalar(0x03C4)!]) }
    if value == 0x1D710 { return (true, to:[UnicodeScalar(0x03C5)!]) }
    if value == 0x1D711 { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D712 { return (true, to:[UnicodeScalar(0x03C7)!]) }
    if value == 0x1D713 { return (true, to:[UnicodeScalar(0x03C8)!]) }
    if value == 0x1D714 { return (true, to:[UnicodeScalar(0x03C9)!]) }
    if value == 0x1D715 { return (true, to:[UnicodeScalar(0x2202)!]) }
    if value == 0x1D716 { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x1D717 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D718 { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x1D719 { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D71A { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if value == 0x1D71B { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x1D71C { return (true, to:[UnicodeScalar(0x03B1)!]) }
    if value == 0x1D71D { return (true, to:[UnicodeScalar(0x03B2)!]) }
    if value == 0x1D71E { return (true, to:[UnicodeScalar(0x03B3)!]) }
    if value == 0x1D71F { return (true, to:[UnicodeScalar(0x03B4)!]) }
    if value == 0x1D720 { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x1D721 { return (true, to:[UnicodeScalar(0x03B6)!]) }
    if value == 0x1D722 { return (true, to:[UnicodeScalar(0x03B7)!]) }
    if value == 0x1D723 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D724 { return (true, to:[UnicodeScalar(0x03B9)!]) }
    if value == 0x1D725 { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x1D726 { return (true, to:[UnicodeScalar(0x03BB)!]) }
    if value == 0x1D727 { return (true, to:[UnicodeScalar(0x03BC)!]) }
    if value == 0x1D728 { return (true, to:[UnicodeScalar(0x03BD)!]) }
    if value == 0x1D729 { return (true, to:[UnicodeScalar(0x03BE)!]) }
    if value == 0x1D72A { return (true, to:[UnicodeScalar(0x03BF)!]) }
    if value == 0x1D72B { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x1D72C { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if value == 0x1D72D { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D72E { return (true, to:[UnicodeScalar(0x03C3)!]) }
    if value == 0x1D72F { return (true, to:[UnicodeScalar(0x03C4)!]) }
    if value == 0x1D730 { return (true, to:[UnicodeScalar(0x03C5)!]) }
    if value == 0x1D731 { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D732 { return (true, to:[UnicodeScalar(0x03C7)!]) }
    if value == 0x1D733 { return (true, to:[UnicodeScalar(0x03C8)!]) }
    if value == 0x1D734 { return (true, to:[UnicodeScalar(0x03C9)!]) }
    if value == 0x1D735 { return (true, to:[UnicodeScalar(0x2207)!]) }
    if value == 0x1D736 { return (true, to:[UnicodeScalar(0x03B1)!]) }
    if value == 0x1D737 { return (true, to:[UnicodeScalar(0x03B2)!]) }
    if value == 0x1D738 { return (true, to:[UnicodeScalar(0x03B3)!]) }
    if value == 0x1D739 { return (true, to:[UnicodeScalar(0x03B4)!]) }
    if value == 0x1D73A { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x1D73B { return (true, to:[UnicodeScalar(0x03B6)!]) }
    if value == 0x1D73C { return (true, to:[UnicodeScalar(0x03B7)!]) }
    if value == 0x1D73D { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D73E { return (true, to:[UnicodeScalar(0x03B9)!]) }
    if value == 0x1D73F { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x1D740 { return (true, to:[UnicodeScalar(0x03BB)!]) }
    if value == 0x1D741 { return (true, to:[UnicodeScalar(0x03BC)!]) }
    if value == 0x1D742 { return (true, to:[UnicodeScalar(0x03BD)!]) }
    if value == 0x1D743 { return (true, to:[UnicodeScalar(0x03BE)!]) }
    if value == 0x1D744 { return (true, to:[UnicodeScalar(0x03BF)!]) }
    if value == 0x1D745 { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x1D746 { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if (0x1D747 <= value && value <= 0x1D748) { return (true, to:[UnicodeScalar(0x03C3)!]) }
    if value == 0x1D749 { return (true, to:[UnicodeScalar(0x03C4)!]) }
    if value == 0x1D74A { return (true, to:[UnicodeScalar(0x03C5)!]) }
    if value == 0x1D74B { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D74C { return (true, to:[UnicodeScalar(0x03C7)!]) }
    if value == 0x1D74D { return (true, to:[UnicodeScalar(0x03C8)!]) }
    if value == 0x1D74E { return (true, to:[UnicodeScalar(0x03C9)!]) }
    if value == 0x1D74F { return (true, to:[UnicodeScalar(0x2202)!]) }
    if value == 0x1D750 { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x1D751 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D752 { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x1D753 { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D754 { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if value == 0x1D755 { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x1D756 { return (true, to:[UnicodeScalar(0x03B1)!]) }
    if value == 0x1D757 { return (true, to:[UnicodeScalar(0x03B2)!]) }
    if value == 0x1D758 { return (true, to:[UnicodeScalar(0x03B3)!]) }
    if value == 0x1D759 { return (true, to:[UnicodeScalar(0x03B4)!]) }
    if value == 0x1D75A { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x1D75B { return (true, to:[UnicodeScalar(0x03B6)!]) }
    if value == 0x1D75C { return (true, to:[UnicodeScalar(0x03B7)!]) }
    if value == 0x1D75D { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D75E { return (true, to:[UnicodeScalar(0x03B9)!]) }
    if value == 0x1D75F { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x1D760 { return (true, to:[UnicodeScalar(0x03BB)!]) }
    if value == 0x1D761 { return (true, to:[UnicodeScalar(0x03BC)!]) }
    if value == 0x1D762 { return (true, to:[UnicodeScalar(0x03BD)!]) }
    if value == 0x1D763 { return (true, to:[UnicodeScalar(0x03BE)!]) }
    if value == 0x1D764 { return (true, to:[UnicodeScalar(0x03BF)!]) }
    if value == 0x1D765 { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x1D766 { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if value == 0x1D767 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D768 { return (true, to:[UnicodeScalar(0x03C3)!]) }
    if value == 0x1D769 { return (true, to:[UnicodeScalar(0x03C4)!]) }
    if value == 0x1D76A { return (true, to:[UnicodeScalar(0x03C5)!]) }
    if value == 0x1D76B { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D76C { return (true, to:[UnicodeScalar(0x03C7)!]) }
    if value == 0x1D76D { return (true, to:[UnicodeScalar(0x03C8)!]) }
    if value == 0x1D76E { return (true, to:[UnicodeScalar(0x03C9)!]) }
    if value == 0x1D76F { return (true, to:[UnicodeScalar(0x2207)!]) }
    if value == 0x1D770 { return (true, to:[UnicodeScalar(0x03B1)!]) }
    if value == 0x1D771 { return (true, to:[UnicodeScalar(0x03B2)!]) }
    if value == 0x1D772 { return (true, to:[UnicodeScalar(0x03B3)!]) }
    if value == 0x1D773 { return (true, to:[UnicodeScalar(0x03B4)!]) }
    if value == 0x1D774 { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x1D775 { return (true, to:[UnicodeScalar(0x03B6)!]) }
    if value == 0x1D776 { return (true, to:[UnicodeScalar(0x03B7)!]) }
    if value == 0x1D777 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D778 { return (true, to:[UnicodeScalar(0x03B9)!]) }
    if value == 0x1D779 { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x1D77A { return (true, to:[UnicodeScalar(0x03BB)!]) }
    if value == 0x1D77B { return (true, to:[UnicodeScalar(0x03BC)!]) }
    if value == 0x1D77C { return (true, to:[UnicodeScalar(0x03BD)!]) }
    if value == 0x1D77D { return (true, to:[UnicodeScalar(0x03BE)!]) }
    if value == 0x1D77E { return (true, to:[UnicodeScalar(0x03BF)!]) }
    if value == 0x1D77F { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x1D780 { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if (0x1D781 <= value && value <= 0x1D782) { return (true, to:[UnicodeScalar(0x03C3)!]) }
    if value == 0x1D783 { return (true, to:[UnicodeScalar(0x03C4)!]) }
    if value == 0x1D784 { return (true, to:[UnicodeScalar(0x03C5)!]) }
    if value == 0x1D785 { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D786 { return (true, to:[UnicodeScalar(0x03C7)!]) }
    if value == 0x1D787 { return (true, to:[UnicodeScalar(0x03C8)!]) }
    if value == 0x1D788 { return (true, to:[UnicodeScalar(0x03C9)!]) }
    if value == 0x1D789 { return (true, to:[UnicodeScalar(0x2202)!]) }
    if value == 0x1D78A { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x1D78B { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D78C { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x1D78D { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D78E { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if value == 0x1D78F { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x1D790 { return (true, to:[UnicodeScalar(0x03B1)!]) }
    if value == 0x1D791 { return (true, to:[UnicodeScalar(0x03B2)!]) }
    if value == 0x1D792 { return (true, to:[UnicodeScalar(0x03B3)!]) }
    if value == 0x1D793 { return (true, to:[UnicodeScalar(0x03B4)!]) }
    if value == 0x1D794 { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x1D795 { return (true, to:[UnicodeScalar(0x03B6)!]) }
    if value == 0x1D796 { return (true, to:[UnicodeScalar(0x03B7)!]) }
    if value == 0x1D797 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D798 { return (true, to:[UnicodeScalar(0x03B9)!]) }
    if value == 0x1D799 { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x1D79A { return (true, to:[UnicodeScalar(0x03BB)!]) }
    if value == 0x1D79B { return (true, to:[UnicodeScalar(0x03BC)!]) }
    if value == 0x1D79C { return (true, to:[UnicodeScalar(0x03BD)!]) }
    if value == 0x1D79D { return (true, to:[UnicodeScalar(0x03BE)!]) }
    if value == 0x1D79E { return (true, to:[UnicodeScalar(0x03BF)!]) }
    if value == 0x1D79F { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x1D7A0 { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if value == 0x1D7A1 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D7A2 { return (true, to:[UnicodeScalar(0x03C3)!]) }
    if value == 0x1D7A3 { return (true, to:[UnicodeScalar(0x03C4)!]) }
    if value == 0x1D7A4 { return (true, to:[UnicodeScalar(0x03C5)!]) }
    if value == 0x1D7A5 { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D7A6 { return (true, to:[UnicodeScalar(0x03C7)!]) }
    if value == 0x1D7A7 { return (true, to:[UnicodeScalar(0x03C8)!]) }
    if value == 0x1D7A8 { return (true, to:[UnicodeScalar(0x03C9)!]) }
    if value == 0x1D7A9 { return (true, to:[UnicodeScalar(0x2207)!]) }
    if value == 0x1D7AA { return (true, to:[UnicodeScalar(0x03B1)!]) }
    if value == 0x1D7AB { return (true, to:[UnicodeScalar(0x03B2)!]) }
    if value == 0x1D7AC { return (true, to:[UnicodeScalar(0x03B3)!]) }
    if value == 0x1D7AD { return (true, to:[UnicodeScalar(0x03B4)!]) }
    if value == 0x1D7AE { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x1D7AF { return (true, to:[UnicodeScalar(0x03B6)!]) }
    if value == 0x1D7B0 { return (true, to:[UnicodeScalar(0x03B7)!]) }
    if value == 0x1D7B1 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D7B2 { return (true, to:[UnicodeScalar(0x03B9)!]) }
    if value == 0x1D7B3 { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x1D7B4 { return (true, to:[UnicodeScalar(0x03BB)!]) }
    if value == 0x1D7B5 { return (true, to:[UnicodeScalar(0x03BC)!]) }
    if value == 0x1D7B6 { return (true, to:[UnicodeScalar(0x03BD)!]) }
    if value == 0x1D7B7 { return (true, to:[UnicodeScalar(0x03BE)!]) }
    if value == 0x1D7B8 { return (true, to:[UnicodeScalar(0x03BF)!]) }
    if value == 0x1D7B9 { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if value == 0x1D7BA { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if (0x1D7BB <= value && value <= 0x1D7BC) { return (true, to:[UnicodeScalar(0x03C3)!]) }
    if value == 0x1D7BD { return (true, to:[UnicodeScalar(0x03C4)!]) }
    if value == 0x1D7BE { return (true, to:[UnicodeScalar(0x03C5)!]) }
    if value == 0x1D7BF { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D7C0 { return (true, to:[UnicodeScalar(0x03C7)!]) }
    if value == 0x1D7C1 { return (true, to:[UnicodeScalar(0x03C8)!]) }
    if value == 0x1D7C2 { return (true, to:[UnicodeScalar(0x03C9)!]) }
    if value == 0x1D7C3 { return (true, to:[UnicodeScalar(0x2202)!]) }
    if value == 0x1D7C4 { return (true, to:[UnicodeScalar(0x03B5)!]) }
    if value == 0x1D7C5 { return (true, to:[UnicodeScalar(0x03B8)!]) }
    if value == 0x1D7C6 { return (true, to:[UnicodeScalar(0x03BA)!]) }
    if value == 0x1D7C7 { return (true, to:[UnicodeScalar(0x03C6)!]) }
    if value == 0x1D7C8 { return (true, to:[UnicodeScalar(0x03C1)!]) }
    if value == 0x1D7C9 { return (true, to:[UnicodeScalar(0x03C0)!]) }
    if (0x1D7CA <= value && value <= 0x1D7CB) { return (true, to:[UnicodeScalar(0x03DD)!]) }
    if value == 0x1D7CE { return (true, to:[UnicodeScalar(0x0030)!]) }
    if value == 0x1D7CF { return (true, to:[UnicodeScalar(0x0031)!]) }
    if value == 0x1D7D0 { return (true, to:[UnicodeScalar(0x0032)!]) }
    if value == 0x1D7D1 { return (true, to:[UnicodeScalar(0x0033)!]) }
    if value == 0x1D7D2 { return (true, to:[UnicodeScalar(0x0034)!]) }
    if value == 0x1D7D3 { return (true, to:[UnicodeScalar(0x0035)!]) }
    if value == 0x1D7D4 { return (true, to:[UnicodeScalar(0x0036)!]) }
    if value == 0x1D7D5 { return (true, to:[UnicodeScalar(0x0037)!]) }
    if value == 0x1D7D6 { return (true, to:[UnicodeScalar(0x0038)!]) }
    if value == 0x1D7D7 { return (true, to:[UnicodeScalar(0x0039)!]) }
    if value == 0x1D7D8 { return (true, to:[UnicodeScalar(0x0030)!]) }
    if value == 0x1D7D9 { return (true, to:[UnicodeScalar(0x0031)!]) }
    if value == 0x1D7DA { return (true, to:[UnicodeScalar(0x0032)!]) }
    if value == 0x1D7DB { return (true, to:[UnicodeScalar(0x0033)!]) }
    if value == 0x1D7DC { return (true, to:[UnicodeScalar(0x0034)!]) }
    if value == 0x1D7DD { return (true, to:[UnicodeScalar(0x0035)!]) }
    if value == 0x1D7DE { return (true, to:[UnicodeScalar(0x0036)!]) }
    if value == 0x1D7DF { return (true, to:[UnicodeScalar(0x0037)!]) }
    if value == 0x1D7E0 { return (true, to:[UnicodeScalar(0x0038)!]) }
    if value == 0x1D7E1 { return (true, to:[UnicodeScalar(0x0039)!]) }
    if value == 0x1D7E2 { return (true, to:[UnicodeScalar(0x0030)!]) }
    if value == 0x1D7E3 { return (true, to:[UnicodeScalar(0x0031)!]) }
    if value == 0x1D7E4 { return (true, to:[UnicodeScalar(0x0032)!]) }
    if value == 0x1D7E5 { return (true, to:[UnicodeScalar(0x0033)!]) }
    if value == 0x1D7E6 { return (true, to:[UnicodeScalar(0x0034)!]) }
    if value == 0x1D7E7 { return (true, to:[UnicodeScalar(0x0035)!]) }
    if value == 0x1D7E8 { return (true, to:[UnicodeScalar(0x0036)!]) }
    if value == 0x1D7E9 { return (true, to:[UnicodeScalar(0x0037)!]) }
    if value == 0x1D7EA { return (true, to:[UnicodeScalar(0x0038)!]) }
    if value == 0x1D7EB { return (true, to:[UnicodeScalar(0x0039)!]) }
    if value == 0x1D7EC { return (true, to:[UnicodeScalar(0x0030)!]) }
    if value == 0x1D7ED { return (true, to:[UnicodeScalar(0x0031)!]) }
    if value == 0x1D7EE { return (true, to:[UnicodeScalar(0x0032)!]) }
    if value == 0x1D7EF { return (true, to:[UnicodeScalar(0x0033)!]) }
    if value == 0x1D7F0 { return (true, to:[UnicodeScalar(0x0034)!]) }
    if value == 0x1D7F1 { return (true, to:[UnicodeScalar(0x0035)!]) }
    if value == 0x1D7F2 { return (true, to:[UnicodeScalar(0x0036)!]) }
    if value == 0x1D7F3 { return (true, to:[UnicodeScalar(0x0037)!]) }
    if value == 0x1D7F4 { return (true, to:[UnicodeScalar(0x0038)!]) }
    if value == 0x1D7F5 { return (true, to:[UnicodeScalar(0x0039)!]) }
    if value == 0x1D7F6 { return (true, to:[UnicodeScalar(0x0030)!]) }
    if value == 0x1D7F7 { return (true, to:[UnicodeScalar(0x0031)!]) }
    if value == 0x1D7F8 { return (true, to:[UnicodeScalar(0x0032)!]) }
    if value == 0x1D7F9 { return (true, to:[UnicodeScalar(0x0033)!]) }
    if value == 0x1D7FA { return (true, to:[UnicodeScalar(0x0034)!]) }
    if value == 0x1D7FB { return (true, to:[UnicodeScalar(0x0035)!]) }
    if value == 0x1D7FC { return (true, to:[UnicodeScalar(0x0036)!]) }
    if value == 0x1D7FD { return (true, to:[UnicodeScalar(0x0037)!]) }
    if value == 0x1D7FE { return (true, to:[UnicodeScalar(0x0038)!]) }
    if value == 0x1D7FF { return (true, to:[UnicodeScalar(0x0039)!]) }
    if value == 0x1E900 { return (true, to:[UnicodeScalar(0x1E922)!]) }
    if value == 0x1E901 { return (true, to:[UnicodeScalar(0x1E923)!]) }
    if value == 0x1E902 { return (true, to:[UnicodeScalar(0x1E924)!]) }
    if value == 0x1E903 { return (true, to:[UnicodeScalar(0x1E925)!]) }
    if value == 0x1E904 { return (true, to:[UnicodeScalar(0x1E926)!]) }
    if value == 0x1E905 { return (true, to:[UnicodeScalar(0x1E927)!]) }
    if value == 0x1E906 { return (true, to:[UnicodeScalar(0x1E928)!]) }
    if value == 0x1E907 { return (true, to:[UnicodeScalar(0x1E929)!]) }
    if value == 0x1E908 { return (true, to:[UnicodeScalar(0x1E92A)!]) }
    if value == 0x1E909 { return (true, to:[UnicodeScalar(0x1E92B)!]) }
    if value == 0x1E90A { return (true, to:[UnicodeScalar(0x1E92C)!]) }
    if value == 0x1E90B { return (true, to:[UnicodeScalar(0x1E92D)!]) }
    if value == 0x1E90C { return (true, to:[UnicodeScalar(0x1E92E)!]) }
    if value == 0x1E90D { return (true, to:[UnicodeScalar(0x1E92F)!]) }
    if value == 0x1E90E { return (true, to:[UnicodeScalar(0x1E930)!]) }
    if value == 0x1E90F { return (true, to:[UnicodeScalar(0x1E931)!]) }
    if value == 0x1E910 { return (true, to:[UnicodeScalar(0x1E932)!]) }
    if value == 0x1E911 { return (true, to:[UnicodeScalar(0x1E933)!]) }
    if value == 0x1E912 { return (true, to:[UnicodeScalar(0x1E934)!]) }
    if value == 0x1E913 { return (true, to:[UnicodeScalar(0x1E935)!]) }
    if value == 0x1E914 { return (true, to:[UnicodeScalar(0x1E936)!]) }
    if value == 0x1E915 { return (true, to:[UnicodeScalar(0x1E937)!]) }
    if value == 0x1E916 { return (true, to:[UnicodeScalar(0x1E938)!]) }
    if value == 0x1E917 { return (true, to:[UnicodeScalar(0x1E939)!]) }
    if value == 0x1E918 { return (true, to:[UnicodeScalar(0x1E93A)!]) }
    if value == 0x1E919 { return (true, to:[UnicodeScalar(0x1E93B)!]) }
    if value == 0x1E91A { return (true, to:[UnicodeScalar(0x1E93C)!]) }
    if value == 0x1E91B { return (true, to:[UnicodeScalar(0x1E93D)!]) }
    if value == 0x1E91C { return (true, to:[UnicodeScalar(0x1E93E)!]) }
    if value == 0x1E91D { return (true, to:[UnicodeScalar(0x1E93F)!]) }
    if value == 0x1E91E { return (true, to:[UnicodeScalar(0x1E940)!]) }
    if value == 0x1E91F { return (true, to:[UnicodeScalar(0x1E941)!]) }
    if value == 0x1E920 { return (true, to:[UnicodeScalar(0x1E942)!]) }
    if value == 0x1E921 { return (true, to:[UnicodeScalar(0x1E943)!]) }
    if value == 0x1EE00 { return (true, to:[UnicodeScalar(0x0627)!]) }
    if value == 0x1EE01 { return (true, to:[UnicodeScalar(0x0628)!]) }
    if value == 0x1EE02 { return (true, to:[UnicodeScalar(0x062C)!]) }
    if value == 0x1EE03 { return (true, to:[UnicodeScalar(0x062F)!]) }
    if value == 0x1EE05 { return (true, to:[UnicodeScalar(0x0648)!]) }
    if value == 0x1EE06 { return (true, to:[UnicodeScalar(0x0632)!]) }
    if value == 0x1EE07 { return (true, to:[UnicodeScalar(0x062D)!]) }
    if value == 0x1EE08 { return (true, to:[UnicodeScalar(0x0637)!]) }
    if value == 0x1EE09 { return (true, to:[UnicodeScalar(0x064A)!]) }
    if value == 0x1EE0A { return (true, to:[UnicodeScalar(0x0643)!]) }
    if value == 0x1EE0B { return (true, to:[UnicodeScalar(0x0644)!]) }
    if value == 0x1EE0C { return (true, to:[UnicodeScalar(0x0645)!]) }
    if value == 0x1EE0D { return (true, to:[UnicodeScalar(0x0646)!]) }
    if value == 0x1EE0E { return (true, to:[UnicodeScalar(0x0633)!]) }
    if value == 0x1EE0F { return (true, to:[UnicodeScalar(0x0639)!]) }
    if value == 0x1EE10 { return (true, to:[UnicodeScalar(0x0641)!]) }
    if value == 0x1EE11 { return (true, to:[UnicodeScalar(0x0635)!]) }
    if value == 0x1EE12 { return (true, to:[UnicodeScalar(0x0642)!]) }
    if value == 0x1EE13 { return (true, to:[UnicodeScalar(0x0631)!]) }
    if value == 0x1EE14 { return (true, to:[UnicodeScalar(0x0634)!]) }
    if value == 0x1EE15 { return (true, to:[UnicodeScalar(0x062A)!]) }
    if value == 0x1EE16 { return (true, to:[UnicodeScalar(0x062B)!]) }
    if value == 0x1EE17 { return (true, to:[UnicodeScalar(0x062E)!]) }
    if value == 0x1EE18 { return (true, to:[UnicodeScalar(0x0630)!]) }
    if value == 0x1EE19 { return (true, to:[UnicodeScalar(0x0636)!]) }
    if value == 0x1EE1A { return (true, to:[UnicodeScalar(0x0638)!]) }
    if value == 0x1EE1B { return (true, to:[UnicodeScalar(0x063A)!]) }
    if value == 0x1EE1C { return (true, to:[UnicodeScalar(0x066E)!]) }
    if value == 0x1EE1D { return (true, to:[UnicodeScalar(0x06BA)!]) }
    if value == 0x1EE1E { return (true, to:[UnicodeScalar(0x06A1)!]) }
    if value == 0x1EE1F { return (true, to:[UnicodeScalar(0x066F)!]) }
    if value == 0x1EE21 { return (true, to:[UnicodeScalar(0x0628)!]) }
    if value == 0x1EE22 { return (true, to:[UnicodeScalar(0x062C)!]) }
    if value == 0x1EE24 { return (true, to:[UnicodeScalar(0x0647)!]) }
    if value == 0x1EE27 { return (true, to:[UnicodeScalar(0x062D)!]) }
    if value == 0x1EE29 { return (true, to:[UnicodeScalar(0x064A)!]) }
    if value == 0x1EE2A { return (true, to:[UnicodeScalar(0x0643)!]) }
    if value == 0x1EE2B { return (true, to:[UnicodeScalar(0x0644)!]) }
    if value == 0x1EE2C { return (true, to:[UnicodeScalar(0x0645)!]) }
    if value == 0x1EE2D { return (true, to:[UnicodeScalar(0x0646)!]) }
    if value == 0x1EE2E { return (true, to:[UnicodeScalar(0x0633)!]) }
    if value == 0x1EE2F { return (true, to:[UnicodeScalar(0x0639)!]) }
    if value == 0x1EE30 { return (true, to:[UnicodeScalar(0x0641)!]) }
    if value == 0x1EE31 { return (true, to:[UnicodeScalar(0x0635)!]) }
    if value == 0x1EE32 { return (true, to:[UnicodeScalar(0x0642)!]) }
    if value == 0x1EE34 { return (true, to:[UnicodeScalar(0x0634)!]) }
    if value == 0x1EE35 { return (true, to:[UnicodeScalar(0x062A)!]) }
    if value == 0x1EE36 { return (true, to:[UnicodeScalar(0x062B)!]) }
    if value == 0x1EE37 { return (true, to:[UnicodeScalar(0x062E)!]) }
    if value == 0x1EE39 { return (true, to:[UnicodeScalar(0x0636)!]) }
    if value == 0x1EE3B { return (true, to:[UnicodeScalar(0x063A)!]) }
    if value == 0x1EE42 { return (true, to:[UnicodeScalar(0x062C)!]) }
    if value == 0x1EE47 { return (true, to:[UnicodeScalar(0x062D)!]) }
    if value == 0x1EE49 { return (true, to:[UnicodeScalar(0x064A)!]) }
    if value == 0x1EE4B { return (true, to:[UnicodeScalar(0x0644)!]) }
    if value == 0x1EE4D { return (true, to:[UnicodeScalar(0x0646)!]) }
    if value == 0x1EE4E { return (true, to:[UnicodeScalar(0x0633)!]) }
    if value == 0x1EE4F { return (true, to:[UnicodeScalar(0x0639)!]) }
    if value == 0x1EE51 { return (true, to:[UnicodeScalar(0x0635)!]) }
    if value == 0x1EE52 { return (true, to:[UnicodeScalar(0x0642)!]) }
    if value == 0x1EE54 { return (true, to:[UnicodeScalar(0x0634)!]) }
    if value == 0x1EE57 { return (true, to:[UnicodeScalar(0x062E)!]) }
    if value == 0x1EE59 { return (true, to:[UnicodeScalar(0x0636)!]) }
    if value == 0x1EE5B { return (true, to:[UnicodeScalar(0x063A)!]) }
    if value == 0x1EE5D { return (true, to:[UnicodeScalar(0x06BA)!]) }
    if value == 0x1EE5F { return (true, to:[UnicodeScalar(0x066F)!]) }
    if value == 0x1EE61 { return (true, to:[UnicodeScalar(0x0628)!]) }
    if value == 0x1EE62 { return (true, to:[UnicodeScalar(0x062C)!]) }
    if value == 0x1EE64 { return (true, to:[UnicodeScalar(0x0647)!]) }
    if value == 0x1EE67 { return (true, to:[UnicodeScalar(0x062D)!]) }
    if value == 0x1EE68 { return (true, to:[UnicodeScalar(0x0637)!]) }
    if value == 0x1EE69 { return (true, to:[UnicodeScalar(0x064A)!]) }
    if value == 0x1EE6A { return (true, to:[UnicodeScalar(0x0643)!]) }
    if value == 0x1EE6C { return (true, to:[UnicodeScalar(0x0645)!]) }
    if value == 0x1EE6D { return (true, to:[UnicodeScalar(0x0646)!]) }
    if value == 0x1EE6E { return (true, to:[UnicodeScalar(0x0633)!]) }
    if value == 0x1EE6F { return (true, to:[UnicodeScalar(0x0639)!]) }
    if value == 0x1EE70 { return (true, to:[UnicodeScalar(0x0641)!]) }
    if value == 0x1EE71 { return (true, to:[UnicodeScalar(0x0635)!]) }
    if value == 0x1EE72 { return (true, to:[UnicodeScalar(0x0642)!]) }
    if value == 0x1EE74 { return (true, to:[UnicodeScalar(0x0634)!]) }
    if value == 0x1EE75 { return (true, to:[UnicodeScalar(0x062A)!]) }
    if value == 0x1EE76 { return (true, to:[UnicodeScalar(0x062B)!]) }
    if value == 0x1EE77 { return (true, to:[UnicodeScalar(0x062E)!]) }
    if value == 0x1EE79 { return (true, to:[UnicodeScalar(0x0636)!]) }
    if value == 0x1EE7A { return (true, to:[UnicodeScalar(0x0638)!]) }
    if value == 0x1EE7B { return (true, to:[UnicodeScalar(0x063A)!]) }
    if value == 0x1EE7C { return (true, to:[UnicodeScalar(0x066E)!]) }
    if value == 0x1EE7E { return (true, to:[UnicodeScalar(0x06A1)!]) }
    if value == 0x1EE80 { return (true, to:[UnicodeScalar(0x0627)!]) }
    if value == 0x1EE81 { return (true, to:[UnicodeScalar(0x0628)!]) }
    if value == 0x1EE82 { return (true, to:[UnicodeScalar(0x062C)!]) }
    if value == 0x1EE83 { return (true, to:[UnicodeScalar(0x062F)!]) }
    if value == 0x1EE84 { return (true, to:[UnicodeScalar(0x0647)!]) }
    if value == 0x1EE85 { return (true, to:[UnicodeScalar(0x0648)!]) }
    if value == 0x1EE86 { return (true, to:[UnicodeScalar(0x0632)!]) }
    if value == 0x1EE87 { return (true, to:[UnicodeScalar(0x062D)!]) }
    if value == 0x1EE88 { return (true, to:[UnicodeScalar(0x0637)!]) }
    if value == 0x1EE89 { return (true, to:[UnicodeScalar(0x064A)!]) }
    if value == 0x1EE8B { return (true, to:[UnicodeScalar(0x0644)!]) }
    if value == 0x1EE8C { return (true, to:[UnicodeScalar(0x0645)!]) }
    if value == 0x1EE8D { return (true, to:[UnicodeScalar(0x0646)!]) }
    if value == 0x1EE8E { return (true, to:[UnicodeScalar(0x0633)!]) }
    if value == 0x1EE8F { return (true, to:[UnicodeScalar(0x0639)!]) }
    if value == 0x1EE90 { return (true, to:[UnicodeScalar(0x0641)!]) }
    if value == 0x1EE91 { return (true, to:[UnicodeScalar(0x0635)!]) }
    if value == 0x1EE92 { return (true, to:[UnicodeScalar(0x0642)!]) }
    if value == 0x1EE93 { return (true, to:[UnicodeScalar(0x0631)!]) }
    if value == 0x1EE94 { return (true, to:[UnicodeScalar(0x0634)!]) }
    if value == 0x1EE95 { return (true, to:[UnicodeScalar(0x062A)!]) }
    if value == 0x1EE96 { return (true, to:[UnicodeScalar(0x062B)!]) }
    if value == 0x1EE97 { return (true, to:[UnicodeScalar(0x062E)!]) }
    if value == 0x1EE98 { return (true, to:[UnicodeScalar(0x0630)!]) }
    if value == 0x1EE99 { return (true, to:[UnicodeScalar(0x0636)!]) }
    if value == 0x1EE9A { return (true, to:[UnicodeScalar(0x0638)!]) }
    if value == 0x1EE9B { return (true, to:[UnicodeScalar(0x063A)!]) }
    if value == 0x1EEA1 { return (true, to:[UnicodeScalar(0x0628)!]) }
    if value == 0x1EEA2 { return (true, to:[UnicodeScalar(0x062C)!]) }
    if value == 0x1EEA3 { return (true, to:[UnicodeScalar(0x062F)!]) }
    if value == 0x1EEA5 { return (true, to:[UnicodeScalar(0x0648)!]) }
    if value == 0x1EEA6 { return (true, to:[UnicodeScalar(0x0632)!]) }
    if value == 0x1EEA7 { return (true, to:[UnicodeScalar(0x062D)!]) }
    if value == 0x1EEA8 { return (true, to:[UnicodeScalar(0x0637)!]) }
    if value == 0x1EEA9 { return (true, to:[UnicodeScalar(0x064A)!]) }
    if value == 0x1EEAB { return (true, to:[UnicodeScalar(0x0644)!]) }
    if value == 0x1EEAC { return (true, to:[UnicodeScalar(0x0645)!]) }
    if value == 0x1EEAD { return (true, to:[UnicodeScalar(0x0646)!]) }
    if value == 0x1EEAE { return (true, to:[UnicodeScalar(0x0633)!]) }
    if value == 0x1EEAF { return (true, to:[UnicodeScalar(0x0639)!]) }
    if value == 0x1EEB0 { return (true, to:[UnicodeScalar(0x0641)!]) }
    if value == 0x1EEB1 { return (true, to:[UnicodeScalar(0x0635)!]) }
    if value == 0x1EEB2 { return (true, to:[UnicodeScalar(0x0642)!]) }
    if value == 0x1EEB3 { return (true, to:[UnicodeScalar(0x0631)!]) }
    if value == 0x1EEB4 { return (true, to:[UnicodeScalar(0x0634)!]) }
    if value == 0x1EEB5 { return (true, to:[UnicodeScalar(0x062A)!]) }
    if value == 0x1EEB6 { return (true, to:[UnicodeScalar(0x062B)!]) }
    if value == 0x1EEB7 { return (true, to:[UnicodeScalar(0x062E)!]) }
    if value == 0x1EEB8 { return (true, to:[UnicodeScalar(0x0630)!]) }
    if value == 0x1EEB9 { return (true, to:[UnicodeScalar(0x0636)!]) }
    if value == 0x1EEBA { return (true, to:[UnicodeScalar(0x0638)!]) }
    if value == 0x1EEBB { return (true, to:[UnicodeScalar(0x063A)!]) }
    if value == 0x1F12A { return (true, to:[UnicodeScalar(0x3014)!, UnicodeScalar(0x0073)!, UnicodeScalar(0x3015)!]) }
    if value == 0x1F12B { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1F12C { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1F12D { return (true, to:[UnicodeScalar(0x0063)!, UnicodeScalar(0x0064)!]) }
    if value == 0x1F12E { return (true, to:[UnicodeScalar(0x0077)!, UnicodeScalar(0x007A)!]) }
    if value == 0x1F130 { return (true, to:[UnicodeScalar(0x0061)!]) }
    if value == 0x1F131 { return (true, to:[UnicodeScalar(0x0062)!]) }
    if value == 0x1F132 { return (true, to:[UnicodeScalar(0x0063)!]) }
    if value == 0x1F133 { return (true, to:[UnicodeScalar(0x0064)!]) }
    if value == 0x1F134 { return (true, to:[UnicodeScalar(0x0065)!]) }
    if value == 0x1F135 { return (true, to:[UnicodeScalar(0x0066)!]) }
    if value == 0x1F136 { return (true, to:[UnicodeScalar(0x0067)!]) }
    if value == 0x1F137 { return (true, to:[UnicodeScalar(0x0068)!]) }
    if value == 0x1F138 { return (true, to:[UnicodeScalar(0x0069)!]) }
    if value == 0x1F139 { return (true, to:[UnicodeScalar(0x006A)!]) }
    if value == 0x1F13A { return (true, to:[UnicodeScalar(0x006B)!]) }
    if value == 0x1F13B { return (true, to:[UnicodeScalar(0x006C)!]) }
    if value == 0x1F13C { return (true, to:[UnicodeScalar(0x006D)!]) }
    if value == 0x1F13D { return (true, to:[UnicodeScalar(0x006E)!]) }
    if value == 0x1F13E { return (true, to:[UnicodeScalar(0x006F)!]) }
    if value == 0x1F13F { return (true, to:[UnicodeScalar(0x0070)!]) }
    if value == 0x1F140 { return (true, to:[UnicodeScalar(0x0071)!]) }
    if value == 0x1F141 { return (true, to:[UnicodeScalar(0x0072)!]) }
    if value == 0x1F142 { return (true, to:[UnicodeScalar(0x0073)!]) }
    if value == 0x1F143 { return (true, to:[UnicodeScalar(0x0074)!]) }
    if value == 0x1F144 { return (true, to:[UnicodeScalar(0x0075)!]) }
    if value == 0x1F145 { return (true, to:[UnicodeScalar(0x0076)!]) }
    if value == 0x1F146 { return (true, to:[UnicodeScalar(0x0077)!]) }
    if value == 0x1F147 { return (true, to:[UnicodeScalar(0x0078)!]) }
    if value == 0x1F148 { return (true, to:[UnicodeScalar(0x0079)!]) }
    if value == 0x1F149 { return (true, to:[UnicodeScalar(0x007A)!]) }
    if value == 0x1F14A { return (true, to:[UnicodeScalar(0x0068)!, UnicodeScalar(0x0076)!]) }
    if value == 0x1F14B { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0076)!]) }
    if value == 0x1F14C { return (true, to:[UnicodeScalar(0x0073)!, UnicodeScalar(0x0064)!]) }
    if value == 0x1F14D { return (true, to:[UnicodeScalar(0x0073)!, UnicodeScalar(0x0073)!]) }
    if value == 0x1F14E { return (true, to:[UnicodeScalar(0x0070)!, UnicodeScalar(0x0070)!, UnicodeScalar(0x0076)!]) }
    if value == 0x1F14F { return (true, to:[UnicodeScalar(0x0077)!, UnicodeScalar(0x0063)!]) }
    if value == 0x1F16A { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0063)!]) }
    if value == 0x1F16B { return (true, to:[UnicodeScalar(0x006D)!, UnicodeScalar(0x0064)!]) }
    if value == 0x1F190 { return (true, to:[UnicodeScalar(0x0064)!, UnicodeScalar(0x006A)!]) }
    if value == 0x1F200 { return (true, to:[UnicodeScalar(0x307B)!, UnicodeScalar(0x304B)!]) }
    if value == 0x1F201 { return (true, to:[UnicodeScalar(0x30B3)!, UnicodeScalar(0x30B3)!]) }
    if value == 0x1F202 { return (true, to:[UnicodeScalar(0x30B5)!]) }
    if value == 0x1F210 { return (true, to:[UnicodeScalar(0x624B)!]) }
    if value == 0x1F211 { return (true, to:[UnicodeScalar(0x5B57)!]) }
    if value == 0x1F212 { return (true, to:[UnicodeScalar(0x53CC)!]) }
    if value == 0x1F213 { return (true, to:[UnicodeScalar(0x30C7)!]) }
    if value == 0x1F214 { return (true, to:[UnicodeScalar(0x4E8C)!]) }
    if value == 0x1F215 { return (true, to:[UnicodeScalar(0x591A)!]) }
    if value == 0x1F216 { return (true, to:[UnicodeScalar(0x89E3)!]) }
    if value == 0x1F217 { return (true, to:[UnicodeScalar(0x5929)!]) }
    if value == 0x1F218 { return (true, to:[UnicodeScalar(0x4EA4)!]) }
    if value == 0x1F219 { return (true, to:[UnicodeScalar(0x6620)!]) }
    if value == 0x1F21A { return (true, to:[UnicodeScalar(0x7121)!]) }
    if value == 0x1F21B { return (true, to:[UnicodeScalar(0x6599)!]) }
    if value == 0x1F21C { return (true, to:[UnicodeScalar(0x524D)!]) }
    if value == 0x1F21D { return (true, to:[UnicodeScalar(0x5F8C)!]) }
    if value == 0x1F21E { return (true, to:[UnicodeScalar(0x518D)!]) }
    if value == 0x1F21F { return (true, to:[UnicodeScalar(0x65B0)!]) }
    if value == 0x1F220 { return (true, to:[UnicodeScalar(0x521D)!]) }
    if value == 0x1F221 { return (true, to:[UnicodeScalar(0x7D42)!]) }
    if value == 0x1F222 { return (true, to:[UnicodeScalar(0x751F)!]) }
    if value == 0x1F223 { return (true, to:[UnicodeScalar(0x8CA9)!]) }
    if value == 0x1F224 { return (true, to:[UnicodeScalar(0x58F0)!]) }
    if value == 0x1F225 { return (true, to:[UnicodeScalar(0x5439)!]) }
    if value == 0x1F226 { return (true, to:[UnicodeScalar(0x6F14)!]) }
    if value == 0x1F227 { return (true, to:[UnicodeScalar(0x6295)!]) }
    if value == 0x1F228 { return (true, to:[UnicodeScalar(0x6355)!]) }
    if value == 0x1F229 { return (true, to:[UnicodeScalar(0x4E00)!]) }
    if value == 0x1F22A { return (true, to:[UnicodeScalar(0x4E09)!]) }
    if value == 0x1F22B { return (true, to:[UnicodeScalar(0x904A)!]) }
    if value == 0x1F22C { return (true, to:[UnicodeScalar(0x5DE6)!]) }
    if value == 0x1F22D { return (true, to:[UnicodeScalar(0x4E2D)!]) }
    if value == 0x1F22E { return (true, to:[UnicodeScalar(0x53F3)!]) }
    if value == 0x1F22F { return (true, to:[UnicodeScalar(0x6307)!]) }
    if value == 0x1F230 { return (true, to:[UnicodeScalar(0x8D70)!]) }
    if value == 0x1F231 { return (true, to:[UnicodeScalar(0x6253)!]) }
    if value == 0x1F232 { return (true, to:[UnicodeScalar(0x7981)!]) }
    if value == 0x1F233 { return (true, to:[UnicodeScalar(0x7A7A)!]) }
    if value == 0x1F234 { return (true, to:[UnicodeScalar(0x5408)!]) }
    if value == 0x1F235 { return (true, to:[UnicodeScalar(0x6E80)!]) }
    if value == 0x1F236 { return (true, to:[UnicodeScalar(0x6709)!]) }
    if value == 0x1F237 { return (true, to:[UnicodeScalar(0x6708)!]) }
    if value == 0x1F238 { return (true, to:[UnicodeScalar(0x7533)!]) }
    if value == 0x1F239 { return (true, to:[UnicodeScalar(0x5272)!]) }
    if value == 0x1F23A { return (true, to:[UnicodeScalar(0x55B6)!]) }
    if value == 0x1F23B { return (true, to:[UnicodeScalar(0x914D)!]) }
    if value == 0x1F240 { return (true, to:[UnicodeScalar(0x3014)!, UnicodeScalar(0x672C)!, UnicodeScalar(0x3015)!]) }
    if value == 0x1F241 { return (true, to:[UnicodeScalar(0x3014)!, UnicodeScalar(0x4E09)!, UnicodeScalar(0x3015)!]) }
    if value == 0x1F242 { return (true, to:[UnicodeScalar(0x3014)!, UnicodeScalar(0x4E8C)!, UnicodeScalar(0x3015)!]) }
    if value == 0x1F243 { return (true, to:[UnicodeScalar(0x3014)!, UnicodeScalar(0x5B89)!, UnicodeScalar(0x3015)!]) }
    if value == 0x1F244 { return (true, to:[UnicodeScalar(0x3014)!, UnicodeScalar(0x70B9)!, UnicodeScalar(0x3015)!]) }
    if value == 0x1F245 { return (true, to:[UnicodeScalar(0x3014)!, UnicodeScalar(0x6253)!, UnicodeScalar(0x3015)!]) }
    if value == 0x1F246 { return (true, to:[UnicodeScalar(0x3014)!, UnicodeScalar(0x76D7)!, UnicodeScalar(0x3015)!]) }
    if value == 0x1F247 { return (true, to:[UnicodeScalar(0x3014)!, UnicodeScalar(0x52DD)!, UnicodeScalar(0x3015)!]) }
    if value == 0x1F248 { return (true, to:[UnicodeScalar(0x3014)!, UnicodeScalar(0x6557)!, UnicodeScalar(0x3015)!]) }
    if value == 0x1F250 { return (true, to:[UnicodeScalar(0x5F97)!]) }
    if value == 0x1F251 { return (true, to:[UnicodeScalar(0x53EF)!]) }
    if value == 0x2F800 { return (true, to:[UnicodeScalar(0x4E3D)!]) }
    if value == 0x2F801 { return (true, to:[UnicodeScalar(0x4E38)!]) }
    if value == 0x2F802 { return (true, to:[UnicodeScalar(0x4E41)!]) }
    if value == 0x2F803 { return (true, to:[UnicodeScalar(0x20122)!]) }
    if value == 0x2F804 { return (true, to:[UnicodeScalar(0x4F60)!]) }
    if value == 0x2F805 { return (true, to:[UnicodeScalar(0x4FAE)!]) }
    if value == 0x2F806 { return (true, to:[UnicodeScalar(0x4FBB)!]) }
    if value == 0x2F807 { return (true, to:[UnicodeScalar(0x5002)!]) }
    if value == 0x2F808 { return (true, to:[UnicodeScalar(0x507A)!]) }
    if value == 0x2F809 { return (true, to:[UnicodeScalar(0x5099)!]) }
    if value == 0x2F80A { return (true, to:[UnicodeScalar(0x50E7)!]) }
    if value == 0x2F80B { return (true, to:[UnicodeScalar(0x50CF)!]) }
    if value == 0x2F80C { return (true, to:[UnicodeScalar(0x349E)!]) }
    if value == 0x2F80D { return (true, to:[UnicodeScalar(0x2063A)!]) }
    if value == 0x2F80E { return (true, to:[UnicodeScalar(0x514D)!]) }
    if value == 0x2F80F { return (true, to:[UnicodeScalar(0x5154)!]) }
    if value == 0x2F810 { return (true, to:[UnicodeScalar(0x5164)!]) }
    if value == 0x2F811 { return (true, to:[UnicodeScalar(0x5177)!]) }
    if value == 0x2F812 { return (true, to:[UnicodeScalar(0x2051C)!]) }
    if value == 0x2F813 { return (true, to:[UnicodeScalar(0x34B9)!]) }
    if value == 0x2F814 { return (true, to:[UnicodeScalar(0x5167)!]) }
    if value == 0x2F815 { return (true, to:[UnicodeScalar(0x518D)!]) }
    if value == 0x2F816 { return (true, to:[UnicodeScalar(0x2054B)!]) }
    if value == 0x2F817 { return (true, to:[UnicodeScalar(0x5197)!]) }
    if value == 0x2F818 { return (true, to:[UnicodeScalar(0x51A4)!]) }
    if value == 0x2F819 { return (true, to:[UnicodeScalar(0x4ECC)!]) }
    if value == 0x2F81A { return (true, to:[UnicodeScalar(0x51AC)!]) }
    if value == 0x2F81B { return (true, to:[UnicodeScalar(0x51B5)!]) }
    if value == 0x2F81C { return (true, to:[UnicodeScalar(0x291DF)!]) }
    if value == 0x2F81D { return (true, to:[UnicodeScalar(0x51F5)!]) }
    if value == 0x2F81E { return (true, to:[UnicodeScalar(0x5203)!]) }
    if value == 0x2F81F { return (true, to:[UnicodeScalar(0x34DF)!]) }
    if value == 0x2F820 { return (true, to:[UnicodeScalar(0x523B)!]) }
    if value == 0x2F821 { return (true, to:[UnicodeScalar(0x5246)!]) }
    if value == 0x2F822 { return (true, to:[UnicodeScalar(0x5272)!]) }
    if value == 0x2F823 { return (true, to:[UnicodeScalar(0x5277)!]) }
    if value == 0x2F824 { return (true, to:[UnicodeScalar(0x3515)!]) }
    if value == 0x2F825 { return (true, to:[UnicodeScalar(0x52C7)!]) }
    if value == 0x2F826 { return (true, to:[UnicodeScalar(0x52C9)!]) }
    if value == 0x2F827 { return (true, to:[UnicodeScalar(0x52E4)!]) }
    if value == 0x2F828 { return (true, to:[UnicodeScalar(0x52FA)!]) }
    if value == 0x2F829 { return (true, to:[UnicodeScalar(0x5305)!]) }
    if value == 0x2F82A { return (true, to:[UnicodeScalar(0x5306)!]) }
    if value == 0x2F82B { return (true, to:[UnicodeScalar(0x5317)!]) }
    if value == 0x2F82C { return (true, to:[UnicodeScalar(0x5349)!]) }
    if value == 0x2F82D { return (true, to:[UnicodeScalar(0x5351)!]) }
    if value == 0x2F82E { return (true, to:[UnicodeScalar(0x535A)!]) }
    if value == 0x2F82F { return (true, to:[UnicodeScalar(0x5373)!]) }
    if value == 0x2F830 { return (true, to:[UnicodeScalar(0x537D)!]) }
    if (0x2F831 <= value && value <= 0x2F833) { return (true, to:[UnicodeScalar(0x537F)!]) }
    if value == 0x2F834 { return (true, to:[UnicodeScalar(0x20A2C)!]) }
    if value == 0x2F835 { return (true, to:[UnicodeScalar(0x7070)!]) }
    if value == 0x2F836 { return (true, to:[UnicodeScalar(0x53CA)!]) }
    if value == 0x2F837 { return (true, to:[UnicodeScalar(0x53DF)!]) }
    if value == 0x2F838 { return (true, to:[UnicodeScalar(0x20B63)!]) }
    if value == 0x2F839 { return (true, to:[UnicodeScalar(0x53EB)!]) }
    if value == 0x2F83A { return (true, to:[UnicodeScalar(0x53F1)!]) }
    if value == 0x2F83B { return (true, to:[UnicodeScalar(0x5406)!]) }
    if value == 0x2F83C { return (true, to:[UnicodeScalar(0x549E)!]) }
    if value == 0x2F83D { return (true, to:[UnicodeScalar(0x5438)!]) }
    if value == 0x2F83E { return (true, to:[UnicodeScalar(0x5448)!]) }
    if value == 0x2F83F { return (true, to:[UnicodeScalar(0x5468)!]) }
    if value == 0x2F840 { return (true, to:[UnicodeScalar(0x54A2)!]) }
    if value == 0x2F841 { return (true, to:[UnicodeScalar(0x54F6)!]) }
    if value == 0x2F842 { return (true, to:[UnicodeScalar(0x5510)!]) }
    if value == 0x2F843 { return (true, to:[UnicodeScalar(0x5553)!]) }
    if value == 0x2F844 { return (true, to:[UnicodeScalar(0x5563)!]) }
    if (0x2F845 <= value && value <= 0x2F846) { return (true, to:[UnicodeScalar(0x5584)!]) }
    if value == 0x2F847 { return (true, to:[UnicodeScalar(0x5599)!]) }
    if value == 0x2F848 { return (true, to:[UnicodeScalar(0x55AB)!]) }
    if value == 0x2F849 { return (true, to:[UnicodeScalar(0x55B3)!]) }
    if value == 0x2F84A { return (true, to:[UnicodeScalar(0x55C2)!]) }
    if value == 0x2F84B { return (true, to:[UnicodeScalar(0x5716)!]) }
    if value == 0x2F84C { return (true, to:[UnicodeScalar(0x5606)!]) }
    if value == 0x2F84D { return (true, to:[UnicodeScalar(0x5717)!]) }
    if value == 0x2F84E { return (true, to:[UnicodeScalar(0x5651)!]) }
    if value == 0x2F84F { return (true, to:[UnicodeScalar(0x5674)!]) }
    if value == 0x2F850 { return (true, to:[UnicodeScalar(0x5207)!]) }
    if value == 0x2F851 { return (true, to:[UnicodeScalar(0x58EE)!]) }
    if value == 0x2F852 { return (true, to:[UnicodeScalar(0x57CE)!]) }
    if value == 0x2F853 { return (true, to:[UnicodeScalar(0x57F4)!]) }
    if value == 0x2F854 { return (true, to:[UnicodeScalar(0x580D)!]) }
    if value == 0x2F855 { return (true, to:[UnicodeScalar(0x578B)!]) }
    if value == 0x2F856 { return (true, to:[UnicodeScalar(0x5832)!]) }
    if value == 0x2F857 { return (true, to:[UnicodeScalar(0x5831)!]) }
    if value == 0x2F858 { return (true, to:[UnicodeScalar(0x58AC)!]) }
    if value == 0x2F859 { return (true, to:[UnicodeScalar(0x214E4)!]) }
    if value == 0x2F85A { return (true, to:[UnicodeScalar(0x58F2)!]) }
    if value == 0x2F85B { return (true, to:[UnicodeScalar(0x58F7)!]) }
    if value == 0x2F85C { return (true, to:[UnicodeScalar(0x5906)!]) }
    if value == 0x2F85D { return (true, to:[UnicodeScalar(0x591A)!]) }
    if value == 0x2F85E { return (true, to:[UnicodeScalar(0x5922)!]) }
    if value == 0x2F85F { return (true, to:[UnicodeScalar(0x5962)!]) }
    if value == 0x2F860 { return (true, to:[UnicodeScalar(0x216A8)!]) }
    if value == 0x2F861 { return (true, to:[UnicodeScalar(0x216EA)!]) }
    if value == 0x2F862 { return (true, to:[UnicodeScalar(0x59EC)!]) }
    if value == 0x2F863 { return (true, to:[UnicodeScalar(0x5A1B)!]) }
    if value == 0x2F864 { return (true, to:[UnicodeScalar(0x5A27)!]) }
    if value == 0x2F865 { return (true, to:[UnicodeScalar(0x59D8)!]) }
    if value == 0x2F866 { return (true, to:[UnicodeScalar(0x5A66)!]) }
    if value == 0x2F867 { return (true, to:[UnicodeScalar(0x36EE)!]) }
    if value == 0x2F869 { return (true, to:[UnicodeScalar(0x5B08)!]) }
    if (0x2F86A <= value && value <= 0x2F86B) { return (true, to:[UnicodeScalar(0x5B3E)!]) }
    if value == 0x2F86C { return (true, to:[UnicodeScalar(0x219C8)!]) }
    if value == 0x2F86D { return (true, to:[UnicodeScalar(0x5BC3)!]) }
    if value == 0x2F86E { return (true, to:[UnicodeScalar(0x5BD8)!]) }
    if value == 0x2F86F { return (true, to:[UnicodeScalar(0x5BE7)!]) }
    if value == 0x2F870 { return (true, to:[UnicodeScalar(0x5BF3)!]) }
    if value == 0x2F871 { return (true, to:[UnicodeScalar(0x21B18)!]) }
    if value == 0x2F872 { return (true, to:[UnicodeScalar(0x5BFF)!]) }
    if value == 0x2F873 { return (true, to:[UnicodeScalar(0x5C06)!]) }
    if value == 0x2F875 { return (true, to:[UnicodeScalar(0x5C22)!]) }
    if value == 0x2F876 { return (true, to:[UnicodeScalar(0x3781)!]) }
    if value == 0x2F877 { return (true, to:[UnicodeScalar(0x5C60)!]) }
    if value == 0x2F878 { return (true, to:[UnicodeScalar(0x5C6E)!]) }
    if value == 0x2F879 { return (true, to:[UnicodeScalar(0x5CC0)!]) }
    if value == 0x2F87A { return (true, to:[UnicodeScalar(0x5C8D)!]) }
    if value == 0x2F87B { return (true, to:[UnicodeScalar(0x21DE4)!]) }
    if value == 0x2F87C { return (true, to:[UnicodeScalar(0x5D43)!]) }
    if value == 0x2F87D { return (true, to:[UnicodeScalar(0x21DE6)!]) }
    if value == 0x2F87E { return (true, to:[UnicodeScalar(0x5D6E)!]) }
    if value == 0x2F87F { return (true, to:[UnicodeScalar(0x5D6B)!]) }
    if value == 0x2F880 { return (true, to:[UnicodeScalar(0x5D7C)!]) }
    if value == 0x2F881 { return (true, to:[UnicodeScalar(0x5DE1)!]) }
    if value == 0x2F882 { return (true, to:[UnicodeScalar(0x5DE2)!]) }
    if value == 0x2F883 { return (true, to:[UnicodeScalar(0x382F)!]) }
    if value == 0x2F884 { return (true, to:[UnicodeScalar(0x5DFD)!]) }
    if value == 0x2F885 { return (true, to:[UnicodeScalar(0x5E28)!]) }
    if value == 0x2F886 { return (true, to:[UnicodeScalar(0x5E3D)!]) }
    if value == 0x2F887 { return (true, to:[UnicodeScalar(0x5E69)!]) }
    if value == 0x2F888 { return (true, to:[UnicodeScalar(0x3862)!]) }
    if value == 0x2F889 { return (true, to:[UnicodeScalar(0x22183)!]) }
    if value == 0x2F88A { return (true, to:[UnicodeScalar(0x387C)!]) }
    if value == 0x2F88B { return (true, to:[UnicodeScalar(0x5EB0)!]) }
    if value == 0x2F88C { return (true, to:[UnicodeScalar(0x5EB3)!]) }
    if value == 0x2F88D { return (true, to:[UnicodeScalar(0x5EB6)!]) }
    if value == 0x2F88E { return (true, to:[UnicodeScalar(0x5ECA)!]) }
    if value == 0x2F88F { return (true, to:[UnicodeScalar(0x2A392)!]) }
    if value == 0x2F890 { return (true, to:[UnicodeScalar(0x5EFE)!]) }
    if (0x2F891 <= value && value <= 0x2F892) { return (true, to:[UnicodeScalar(0x22331)!]) }
    if value == 0x2F893 { return (true, to:[UnicodeScalar(0x8201)!]) }
    if (0x2F894 <= value && value <= 0x2F895) { return (true, to:[UnicodeScalar(0x5F22)!]) }
    if value == 0x2F896 { return (true, to:[UnicodeScalar(0x38C7)!]) }
    if value == 0x2F897 { return (true, to:[UnicodeScalar(0x232B8)!]) }
    if value == 0x2F898 { return (true, to:[UnicodeScalar(0x261DA)!]) }
    if value == 0x2F899 { return (true, to:[UnicodeScalar(0x5F62)!]) }
    if value == 0x2F89A { return (true, to:[UnicodeScalar(0x5F6B)!]) }
    if value == 0x2F89B { return (true, to:[UnicodeScalar(0x38E3)!]) }
    if value == 0x2F89C { return (true, to:[UnicodeScalar(0x5F9A)!]) }
    if value == 0x2F89D { return (true, to:[UnicodeScalar(0x5FCD)!]) }
    if value == 0x2F89E { return (true, to:[UnicodeScalar(0x5FD7)!]) }
    if value == 0x2F89F { return (true, to:[UnicodeScalar(0x5FF9)!]) }
    if value == 0x2F8A0 { return (true, to:[UnicodeScalar(0x6081)!]) }
    if value == 0x2F8A1 { return (true, to:[UnicodeScalar(0x393A)!]) }
    if value == 0x2F8A2 { return (true, to:[UnicodeScalar(0x391C)!]) }
    if value == 0x2F8A3 { return (true, to:[UnicodeScalar(0x6094)!]) }
    if value == 0x2F8A4 { return (true, to:[UnicodeScalar(0x226D4)!]) }
    if value == 0x2F8A5 { return (true, to:[UnicodeScalar(0x60C7)!]) }
    if value == 0x2F8A6 { return (true, to:[UnicodeScalar(0x6148)!]) }
    if value == 0x2F8A7 { return (true, to:[UnicodeScalar(0x614C)!]) }
    if value == 0x2F8A8 { return (true, to:[UnicodeScalar(0x614E)!]) }
    if value == 0x2F8A9 { return (true, to:[UnicodeScalar(0x614C)!]) }
    if value == 0x2F8AA { return (true, to:[UnicodeScalar(0x617A)!]) }
    if value == 0x2F8AB { return (true, to:[UnicodeScalar(0x618E)!]) }
    if value == 0x2F8AC { return (true, to:[UnicodeScalar(0x61B2)!]) }
    if value == 0x2F8AD { return (true, to:[UnicodeScalar(0x61A4)!]) }
    if value == 0x2F8AE { return (true, to:[UnicodeScalar(0x61AF)!]) }
    if value == 0x2F8AF { return (true, to:[UnicodeScalar(0x61DE)!]) }
    if value == 0x2F8B0 { return (true, to:[UnicodeScalar(0x61F2)!]) }
    if value == 0x2F8B1 { return (true, to:[UnicodeScalar(0x61F6)!]) }
    if value == 0x2F8B2 { return (true, to:[UnicodeScalar(0x6210)!]) }
    if value == 0x2F8B3 { return (true, to:[UnicodeScalar(0x621B)!]) }
    if value == 0x2F8B4 { return (true, to:[UnicodeScalar(0x625D)!]) }
    if value == 0x2F8B5 { return (true, to:[UnicodeScalar(0x62B1)!]) }
    if value == 0x2F8B6 { return (true, to:[UnicodeScalar(0x62D4)!]) }
    if value == 0x2F8B7 { return (true, to:[UnicodeScalar(0x6350)!]) }
    if value == 0x2F8B8 { return (true, to:[UnicodeScalar(0x22B0C)!]) }
    if value == 0x2F8B9 { return (true, to:[UnicodeScalar(0x633D)!]) }
    if value == 0x2F8BA { return (true, to:[UnicodeScalar(0x62FC)!]) }
    if value == 0x2F8BB { return (true, to:[UnicodeScalar(0x6368)!]) }
    if value == 0x2F8BC { return (true, to:[UnicodeScalar(0x6383)!]) }
    if value == 0x2F8BD { return (true, to:[UnicodeScalar(0x63E4)!]) }
    if value == 0x2F8BE { return (true, to:[UnicodeScalar(0x22BF1)!]) }
    if value == 0x2F8BF { return (true, to:[UnicodeScalar(0x6422)!]) }
    if value == 0x2F8C0 { return (true, to:[UnicodeScalar(0x63C5)!]) }
    if value == 0x2F8C1 { return (true, to:[UnicodeScalar(0x63A9)!]) }
    if value == 0x2F8C2 { return (true, to:[UnicodeScalar(0x3A2E)!]) }
    if value == 0x2F8C3 { return (true, to:[UnicodeScalar(0x6469)!]) }
    if value == 0x2F8C4 { return (true, to:[UnicodeScalar(0x647E)!]) }
    if value == 0x2F8C5 { return (true, to:[UnicodeScalar(0x649D)!]) }
    if value == 0x2F8C6 { return (true, to:[UnicodeScalar(0x6477)!]) }
    if value == 0x2F8C7 { return (true, to:[UnicodeScalar(0x3A6C)!]) }
    if value == 0x2F8C8 { return (true, to:[UnicodeScalar(0x654F)!]) }
    if value == 0x2F8C9 { return (true, to:[UnicodeScalar(0x656C)!]) }
    if value == 0x2F8CA { return (true, to:[UnicodeScalar(0x2300A)!]) }
    if value == 0x2F8CB { return (true, to:[UnicodeScalar(0x65E3)!]) }
    if value == 0x2F8CC { return (true, to:[UnicodeScalar(0x66F8)!]) }
    if value == 0x2F8CD { return (true, to:[UnicodeScalar(0x6649)!]) }
    if value == 0x2F8CE { return (true, to:[UnicodeScalar(0x3B19)!]) }
    if value == 0x2F8CF { return (true, to:[UnicodeScalar(0x6691)!]) }
    if value == 0x2F8D0 { return (true, to:[UnicodeScalar(0x3B08)!]) }
    if value == 0x2F8D1 { return (true, to:[UnicodeScalar(0x3AE4)!]) }
    if value == 0x2F8D2 { return (true, to:[UnicodeScalar(0x5192)!]) }
    if value == 0x2F8D3 { return (true, to:[UnicodeScalar(0x5195)!]) }
    if value == 0x2F8D4 { return (true, to:[UnicodeScalar(0x6700)!]) }
    if value == 0x2F8D5 { return (true, to:[UnicodeScalar(0x669C)!]) }
    if value == 0x2F8D6 { return (true, to:[UnicodeScalar(0x80AD)!]) }
    if value == 0x2F8D7 { return (true, to:[UnicodeScalar(0x43D9)!]) }
    if value == 0x2F8D8 { return (true, to:[UnicodeScalar(0x6717)!]) }
    if value == 0x2F8D9 { return (true, to:[UnicodeScalar(0x671B)!]) }
    if value == 0x2F8DA { return (true, to:[UnicodeScalar(0x6721)!]) }
    if value == 0x2F8DB { return (true, to:[UnicodeScalar(0x675E)!]) }
    if value == 0x2F8DC { return (true, to:[UnicodeScalar(0x6753)!]) }
    if value == 0x2F8DD { return (true, to:[UnicodeScalar(0x233C3)!]) }
    if value == 0x2F8DE { return (true, to:[UnicodeScalar(0x3B49)!]) }
    if value == 0x2F8DF { return (true, to:[UnicodeScalar(0x67FA)!]) }
    if value == 0x2F8E0 { return (true, to:[UnicodeScalar(0x6785)!]) }
    if value == 0x2F8E1 { return (true, to:[UnicodeScalar(0x6852)!]) }
    if value == 0x2F8E2 { return (true, to:[UnicodeScalar(0x6885)!]) }
    if value == 0x2F8E3 { return (true, to:[UnicodeScalar(0x2346D)!]) }
    if value == 0x2F8E4 { return (true, to:[UnicodeScalar(0x688E)!]) }
    if value == 0x2F8E5 { return (true, to:[UnicodeScalar(0x681F)!]) }
    if value == 0x2F8E6 { return (true, to:[UnicodeScalar(0x6914)!]) }
    if value == 0x2F8E7 { return (true, to:[UnicodeScalar(0x3B9D)!]) }
    if value == 0x2F8E8 { return (true, to:[UnicodeScalar(0x6942)!]) }
    if value == 0x2F8E9 { return (true, to:[UnicodeScalar(0x69A3)!]) }
    if value == 0x2F8EA { return (true, to:[UnicodeScalar(0x69EA)!]) }
    if value == 0x2F8EB { return (true, to:[UnicodeScalar(0x6AA8)!]) }
    if value == 0x2F8EC { return (true, to:[UnicodeScalar(0x236A3)!]) }
    if value == 0x2F8ED { return (true, to:[UnicodeScalar(0x6ADB)!]) }
    if value == 0x2F8EE { return (true, to:[UnicodeScalar(0x3C18)!]) }
    if value == 0x2F8EF { return (true, to:[UnicodeScalar(0x6B21)!]) }
    if value == 0x2F8F0 { return (true, to:[UnicodeScalar(0x238A7)!]) }
    if value == 0x2F8F1 { return (true, to:[UnicodeScalar(0x6B54)!]) }
    if value == 0x2F8F2 { return (true, to:[UnicodeScalar(0x3C4E)!]) }
    if value == 0x2F8F3 { return (true, to:[UnicodeScalar(0x6B72)!]) }
    if value == 0x2F8F4 { return (true, to:[UnicodeScalar(0x6B9F)!]) }
    if value == 0x2F8F5 { return (true, to:[UnicodeScalar(0x6BBA)!]) }
    if value == 0x2F8F6 { return (true, to:[UnicodeScalar(0x6BBB)!]) }
    if value == 0x2F8F7 { return (true, to:[UnicodeScalar(0x23A8D)!]) }
    if value == 0x2F8F8 { return (true, to:[UnicodeScalar(0x21D0B)!]) }
    if value == 0x2F8F9 { return (true, to:[UnicodeScalar(0x23AFA)!]) }
    if value == 0x2F8FA { return (true, to:[UnicodeScalar(0x6C4E)!]) }
    if value == 0x2F8FB { return (true, to:[UnicodeScalar(0x23CBC)!]) }
    if value == 0x2F8FC { return (true, to:[UnicodeScalar(0x6CBF)!]) }
    if value == 0x2F8FD { return (true, to:[UnicodeScalar(0x6CCD)!]) }
    if value == 0x2F8FE { return (true, to:[UnicodeScalar(0x6C67)!]) }
    if value == 0x2F8FF { return (true, to:[UnicodeScalar(0x6D16)!]) }
    if value == 0x2F900 { return (true, to:[UnicodeScalar(0x6D3E)!]) }
    if value == 0x2F901 { return (true, to:[UnicodeScalar(0x6D77)!]) }
    if value == 0x2F902 { return (true, to:[UnicodeScalar(0x6D41)!]) }
    if value == 0x2F903 { return (true, to:[UnicodeScalar(0x6D69)!]) }
    if value == 0x2F904 { return (true, to:[UnicodeScalar(0x6D78)!]) }
    if value == 0x2F905 { return (true, to:[UnicodeScalar(0x6D85)!]) }
    if value == 0x2F906 { return (true, to:[UnicodeScalar(0x23D1E)!]) }
    if value == 0x2F907 { return (true, to:[UnicodeScalar(0x6D34)!]) }
    if value == 0x2F908 { return (true, to:[UnicodeScalar(0x6E2F)!]) }
    if value == 0x2F909 { return (true, to:[UnicodeScalar(0x6E6E)!]) }
    if value == 0x2F90A { return (true, to:[UnicodeScalar(0x3D33)!]) }
    if value == 0x2F90B { return (true, to:[UnicodeScalar(0x6ECB)!]) }
    if value == 0x2F90C { return (true, to:[UnicodeScalar(0x6EC7)!]) }
    if value == 0x2F90D { return (true, to:[UnicodeScalar(0x23ED1)!]) }
    if value == 0x2F90E { return (true, to:[UnicodeScalar(0x6DF9)!]) }
    if value == 0x2F90F { return (true, to:[UnicodeScalar(0x6F6E)!]) }
    if value == 0x2F910 { return (true, to:[UnicodeScalar(0x23F5E)!]) }
    if value == 0x2F911 { return (true, to:[UnicodeScalar(0x23F8E)!]) }
    if value == 0x2F912 { return (true, to:[UnicodeScalar(0x6FC6)!]) }
    if value == 0x2F913 { return (true, to:[UnicodeScalar(0x7039)!]) }
    if value == 0x2F914 { return (true, to:[UnicodeScalar(0x701E)!]) }
    if value == 0x2F915 { return (true, to:[UnicodeScalar(0x701B)!]) }
    if value == 0x2F916 { return (true, to:[UnicodeScalar(0x3D96)!]) }
    if value == 0x2F917 { return (true, to:[UnicodeScalar(0x704A)!]) }
    if value == 0x2F918 { return (true, to:[UnicodeScalar(0x707D)!]) }
    if value == 0x2F919 { return (true, to:[UnicodeScalar(0x7077)!]) }
    if value == 0x2F91A { return (true, to:[UnicodeScalar(0x70AD)!]) }
    if value == 0x2F91B { return (true, to:[UnicodeScalar(0x20525)!]) }
    if value == 0x2F91C { return (true, to:[UnicodeScalar(0x7145)!]) }
    if value == 0x2F91D { return (true, to:[UnicodeScalar(0x24263)!]) }
    if value == 0x2F91E { return (true, to:[UnicodeScalar(0x719C)!]) }
    if value == 0x2F920 { return (true, to:[UnicodeScalar(0x7228)!]) }
    if value == 0x2F921 { return (true, to:[UnicodeScalar(0x7235)!]) }
    if value == 0x2F922 { return (true, to:[UnicodeScalar(0x7250)!]) }
    if value == 0x2F923 { return (true, to:[UnicodeScalar(0x24608)!]) }
    if value == 0x2F924 { return (true, to:[UnicodeScalar(0x7280)!]) }
    if value == 0x2F925 { return (true, to:[UnicodeScalar(0x7295)!]) }
    if value == 0x2F926 { return (true, to:[UnicodeScalar(0x24735)!]) }
    if value == 0x2F927 { return (true, to:[UnicodeScalar(0x24814)!]) }
    if value == 0x2F928 { return (true, to:[UnicodeScalar(0x737A)!]) }
    if value == 0x2F929 { return (true, to:[UnicodeScalar(0x738B)!]) }
    if value == 0x2F92A { return (true, to:[UnicodeScalar(0x3EAC)!]) }
    if value == 0x2F92B { return (true, to:[UnicodeScalar(0x73A5)!]) }
    if (0x2F92C <= value && value <= 0x2F92D) { return (true, to:[UnicodeScalar(0x3EB8)!]) }
    if value == 0x2F92E { return (true, to:[UnicodeScalar(0x7447)!]) }
    if value == 0x2F92F { return (true, to:[UnicodeScalar(0x745C)!]) }
    if value == 0x2F930 { return (true, to:[UnicodeScalar(0x7471)!]) }
    if value == 0x2F931 { return (true, to:[UnicodeScalar(0x7485)!]) }
    if value == 0x2F932 { return (true, to:[UnicodeScalar(0x74CA)!]) }
    if value == 0x2F933 { return (true, to:[UnicodeScalar(0x3F1B)!]) }
    if value == 0x2F934 { return (true, to:[UnicodeScalar(0x7524)!]) }
    if value == 0x2F935 { return (true, to:[UnicodeScalar(0x24C36)!]) }
    if value == 0x2F936 { return (true, to:[UnicodeScalar(0x753E)!]) }
    if value == 0x2F937 { return (true, to:[UnicodeScalar(0x24C92)!]) }
    if value == 0x2F938 { return (true, to:[UnicodeScalar(0x7570)!]) }
    if value == 0x2F939 { return (true, to:[UnicodeScalar(0x2219F)!]) }
    if value == 0x2F93A { return (true, to:[UnicodeScalar(0x7610)!]) }
    if value == 0x2F93B { return (true, to:[UnicodeScalar(0x24FA1)!]) }
    if value == 0x2F93C { return (true, to:[UnicodeScalar(0x24FB8)!]) }
    if value == 0x2F93D { return (true, to:[UnicodeScalar(0x25044)!]) }
    if value == 0x2F93E { return (true, to:[UnicodeScalar(0x3FFC)!]) }
    if value == 0x2F93F { return (true, to:[UnicodeScalar(0x4008)!]) }
    if value == 0x2F940 { return (true, to:[UnicodeScalar(0x76F4)!]) }
    if value == 0x2F941 { return (true, to:[UnicodeScalar(0x250F3)!]) }
    if value == 0x2F942 { return (true, to:[UnicodeScalar(0x250F2)!]) }
    if value == 0x2F943 { return (true, to:[UnicodeScalar(0x25119)!]) }
    if value == 0x2F944 { return (true, to:[UnicodeScalar(0x25133)!]) }
    if value == 0x2F945 { return (true, to:[UnicodeScalar(0x771E)!]) }
    if (0x2F946 <= value && value <= 0x2F947) { return (true, to:[UnicodeScalar(0x771F)!]) }
    if value == 0x2F948 { return (true, to:[UnicodeScalar(0x774A)!]) }
    if value == 0x2F949 { return (true, to:[UnicodeScalar(0x4039)!]) }
    if value == 0x2F94A { return (true, to:[UnicodeScalar(0x778B)!]) }
    if value == 0x2F94B { return (true, to:[UnicodeScalar(0x4046)!]) }
    if value == 0x2F94C { return (true, to:[UnicodeScalar(0x4096)!]) }
    if value == 0x2F94D { return (true, to:[UnicodeScalar(0x2541D)!]) }
    if value == 0x2F94E { return (true, to:[UnicodeScalar(0x784E)!]) }
    if value == 0x2F94F { return (true, to:[UnicodeScalar(0x788C)!]) }
    if value == 0x2F950 { return (true, to:[UnicodeScalar(0x78CC)!]) }
    if value == 0x2F951 { return (true, to:[UnicodeScalar(0x40E3)!]) }
    if value == 0x2F952 { return (true, to:[UnicodeScalar(0x25626)!]) }
    if value == 0x2F953 { return (true, to:[UnicodeScalar(0x7956)!]) }
    if value == 0x2F954 { return (true, to:[UnicodeScalar(0x2569A)!]) }
    if value == 0x2F955 { return (true, to:[UnicodeScalar(0x256C5)!]) }
    if value == 0x2F956 { return (true, to:[UnicodeScalar(0x798F)!]) }
    if value == 0x2F957 { return (true, to:[UnicodeScalar(0x79EB)!]) }
    if value == 0x2F958 { return (true, to:[UnicodeScalar(0x412F)!]) }
    if value == 0x2F959 { return (true, to:[UnicodeScalar(0x7A40)!]) }
    if value == 0x2F95A { return (true, to:[UnicodeScalar(0x7A4A)!]) }
    if value == 0x2F95B { return (true, to:[UnicodeScalar(0x7A4F)!]) }
    if value == 0x2F95C { return (true, to:[UnicodeScalar(0x2597C)!]) }
    if (0x2F95D <= value && value <= 0x2F95E) { return (true, to:[UnicodeScalar(0x25AA7)!]) }
    if value == 0x2F960 { return (true, to:[UnicodeScalar(0x4202)!]) }
    if value == 0x2F961 { return (true, to:[UnicodeScalar(0x25BAB)!]) }
    if value == 0x2F962 { return (true, to:[UnicodeScalar(0x7BC6)!]) }
    if value == 0x2F963 { return (true, to:[UnicodeScalar(0x7BC9)!]) }
    if value == 0x2F964 { return (true, to:[UnicodeScalar(0x4227)!]) }
    if value == 0x2F965 { return (true, to:[UnicodeScalar(0x25C80)!]) }
    if value == 0x2F966 { return (true, to:[UnicodeScalar(0x7CD2)!]) }
    if value == 0x2F967 { return (true, to:[UnicodeScalar(0x42A0)!]) }
    if value == 0x2F968 { return (true, to:[UnicodeScalar(0x7CE8)!]) }
    if value == 0x2F969 { return (true, to:[UnicodeScalar(0x7CE3)!]) }
    if value == 0x2F96A { return (true, to:[UnicodeScalar(0x7D00)!]) }
    if value == 0x2F96B { return (true, to:[UnicodeScalar(0x25F86)!]) }
    if value == 0x2F96C { return (true, to:[UnicodeScalar(0x7D63)!]) }
    if value == 0x2F96D { return (true, to:[UnicodeScalar(0x4301)!]) }
    if value == 0x2F96E { return (true, to:[UnicodeScalar(0x7DC7)!]) }
    if value == 0x2F96F { return (true, to:[UnicodeScalar(0x7E02)!]) }
    if value == 0x2F970 { return (true, to:[UnicodeScalar(0x7E45)!]) }
    if value == 0x2F971 { return (true, to:[UnicodeScalar(0x4334)!]) }
    if value == 0x2F972 { return (true, to:[UnicodeScalar(0x26228)!]) }
    if value == 0x2F973 { return (true, to:[UnicodeScalar(0x26247)!]) }
    if value == 0x2F974 { return (true, to:[UnicodeScalar(0x4359)!]) }
    if value == 0x2F975 { return (true, to:[UnicodeScalar(0x262D9)!]) }
    if value == 0x2F976 { return (true, to:[UnicodeScalar(0x7F7A)!]) }
    if value == 0x2F977 { return (true, to:[UnicodeScalar(0x2633E)!]) }
    if value == 0x2F978 { return (true, to:[UnicodeScalar(0x7F95)!]) }
    if value == 0x2F979 { return (true, to:[UnicodeScalar(0x7FFA)!]) }
    if value == 0x2F97A { return (true, to:[UnicodeScalar(0x8005)!]) }
    if value == 0x2F97B { return (true, to:[UnicodeScalar(0x264DA)!]) }
    if value == 0x2F97C { return (true, to:[UnicodeScalar(0x26523)!]) }
    if value == 0x2F97D { return (true, to:[UnicodeScalar(0x8060)!]) }
    if value == 0x2F97E { return (true, to:[UnicodeScalar(0x265A8)!]) }
    if value == 0x2F97F { return (true, to:[UnicodeScalar(0x8070)!]) }
    if value == 0x2F980 { return (true, to:[UnicodeScalar(0x2335F)!]) }
    if value == 0x2F981 { return (true, to:[UnicodeScalar(0x43D5)!]) }
    if value == 0x2F982 { return (true, to:[UnicodeScalar(0x80B2)!]) }
    if value == 0x2F983 { return (true, to:[UnicodeScalar(0x8103)!]) }
    if value == 0x2F984 { return (true, to:[UnicodeScalar(0x440B)!]) }
    if value == 0x2F985 { return (true, to:[UnicodeScalar(0x813E)!]) }
    if value == 0x2F986 { return (true, to:[UnicodeScalar(0x5AB5)!]) }
    if value == 0x2F987 { return (true, to:[UnicodeScalar(0x267A7)!]) }
    if value == 0x2F988 { return (true, to:[UnicodeScalar(0x267B5)!]) }
    if value == 0x2F989 { return (true, to:[UnicodeScalar(0x23393)!]) }
    if value == 0x2F98A { return (true, to:[UnicodeScalar(0x2339C)!]) }
    if value == 0x2F98B { return (true, to:[UnicodeScalar(0x8201)!]) }
    if value == 0x2F98C { return (true, to:[UnicodeScalar(0x8204)!]) }
    if value == 0x2F98D { return (true, to:[UnicodeScalar(0x8F9E)!]) }
    if value == 0x2F98E { return (true, to:[UnicodeScalar(0x446B)!]) }
    if value == 0x2F98F { return (true, to:[UnicodeScalar(0x8291)!]) }
    if value == 0x2F990 { return (true, to:[UnicodeScalar(0x828B)!]) }
    if value == 0x2F991 { return (true, to:[UnicodeScalar(0x829D)!]) }
    if value == 0x2F992 { return (true, to:[UnicodeScalar(0x52B3)!]) }
    if value == 0x2F993 { return (true, to:[UnicodeScalar(0x82B1)!]) }
    if value == 0x2F994 { return (true, to:[UnicodeScalar(0x82B3)!]) }
    if value == 0x2F995 { return (true, to:[UnicodeScalar(0x82BD)!]) }
    if value == 0x2F996 { return (true, to:[UnicodeScalar(0x82E6)!]) }
    if value == 0x2F997 { return (true, to:[UnicodeScalar(0x26B3C)!]) }
    if value == 0x2F998 { return (true, to:[UnicodeScalar(0x82E5)!]) }
    if value == 0x2F999 { return (true, to:[UnicodeScalar(0x831D)!]) }
    if value == 0x2F99A { return (true, to:[UnicodeScalar(0x8363)!]) }
    if value == 0x2F99B { return (true, to:[UnicodeScalar(0x83AD)!]) }
    if value == 0x2F99C { return (true, to:[UnicodeScalar(0x8323)!]) }
    if value == 0x2F99D { return (true, to:[UnicodeScalar(0x83BD)!]) }
    if value == 0x2F99E { return (true, to:[UnicodeScalar(0x83E7)!]) }
    if value == 0x2F99F { return (true, to:[UnicodeScalar(0x8457)!]) }
    if value == 0x2F9A0 { return (true, to:[UnicodeScalar(0x8353)!]) }
    if value == 0x2F9A1 { return (true, to:[UnicodeScalar(0x83CA)!]) }
    if value == 0x2F9A2 { return (true, to:[UnicodeScalar(0x83CC)!]) }
    if value == 0x2F9A3 { return (true, to:[UnicodeScalar(0x83DC)!]) }
    if value == 0x2F9A4 { return (true, to:[UnicodeScalar(0x26C36)!]) }
    if value == 0x2F9A5 { return (true, to:[UnicodeScalar(0x26D6B)!]) }
    if value == 0x2F9A6 { return (true, to:[UnicodeScalar(0x26CD5)!]) }
    if value == 0x2F9A7 { return (true, to:[UnicodeScalar(0x452B)!]) }
    if value == 0x2F9A8 { return (true, to:[UnicodeScalar(0x84F1)!]) }
    if value == 0x2F9A9 { return (true, to:[UnicodeScalar(0x84F3)!]) }
    if value == 0x2F9AA { return (true, to:[UnicodeScalar(0x8516)!]) }
    if value == 0x2F9AB { return (true, to:[UnicodeScalar(0x273CA)!]) }
    if value == 0x2F9AC { return (true, to:[UnicodeScalar(0x8564)!]) }
    if value == 0x2F9AD { return (true, to:[UnicodeScalar(0x26F2C)!]) }
    if value == 0x2F9AE { return (true, to:[UnicodeScalar(0x455D)!]) }
    if value == 0x2F9AF { return (true, to:[UnicodeScalar(0x4561)!]) }
    if value == 0x2F9B0 { return (true, to:[UnicodeScalar(0x26FB1)!]) }
    if value == 0x2F9B1 { return (true, to:[UnicodeScalar(0x270D2)!]) }
    if value == 0x2F9B2 { return (true, to:[UnicodeScalar(0x456B)!]) }
    if value == 0x2F9B3 { return (true, to:[UnicodeScalar(0x8650)!]) }
    if value == 0x2F9B4 { return (true, to:[UnicodeScalar(0x865C)!]) }
    if value == 0x2F9B5 { return (true, to:[UnicodeScalar(0x8667)!]) }
    if value == 0x2F9B6 { return (true, to:[UnicodeScalar(0x8669)!]) }
    if value == 0x2F9B7 { return (true, to:[UnicodeScalar(0x86A9)!]) }
    if value == 0x2F9B8 { return (true, to:[UnicodeScalar(0x8688)!]) }
    if value == 0x2F9B9 { return (true, to:[UnicodeScalar(0x870E)!]) }
    if value == 0x2F9BA { return (true, to:[UnicodeScalar(0x86E2)!]) }
    if value == 0x2F9BB { return (true, to:[UnicodeScalar(0x8779)!]) }
    if value == 0x2F9BC { return (true, to:[UnicodeScalar(0x8728)!]) }
    if value == 0x2F9BD { return (true, to:[UnicodeScalar(0x876B)!]) }
    if value == 0x2F9BE { return (true, to:[UnicodeScalar(0x8786)!]) }
    if value == 0x2F9C0 { return (true, to:[UnicodeScalar(0x87E1)!]) }
    if value == 0x2F9C1 { return (true, to:[UnicodeScalar(0x8801)!]) }
    if value == 0x2F9C2 { return (true, to:[UnicodeScalar(0x45F9)!]) }
    if value == 0x2F9C3 { return (true, to:[UnicodeScalar(0x8860)!]) }
    if value == 0x2F9C4 { return (true, to:[UnicodeScalar(0x8863)!]) }
    if value == 0x2F9C5 { return (true, to:[UnicodeScalar(0x27667)!]) }
    if value == 0x2F9C6 { return (true, to:[UnicodeScalar(0x88D7)!]) }
    if value == 0x2F9C7 { return (true, to:[UnicodeScalar(0x88DE)!]) }
    if value == 0x2F9C8 { return (true, to:[UnicodeScalar(0x4635)!]) }
    if value == 0x2F9C9 { return (true, to:[UnicodeScalar(0x88FA)!]) }
    if value == 0x2F9CA { return (true, to:[UnicodeScalar(0x34BB)!]) }
    if value == 0x2F9CB { return (true, to:[UnicodeScalar(0x278AE)!]) }
    if value == 0x2F9CC { return (true, to:[UnicodeScalar(0x27966)!]) }
    if value == 0x2F9CD { return (true, to:[UnicodeScalar(0x46BE)!]) }
    if value == 0x2F9CE { return (true, to:[UnicodeScalar(0x46C7)!]) }
    if value == 0x2F9CF { return (true, to:[UnicodeScalar(0x8AA0)!]) }
    if value == 0x2F9D0 { return (true, to:[UnicodeScalar(0x8AED)!]) }
    if value == 0x2F9D1 { return (true, to:[UnicodeScalar(0x8B8A)!]) }
    if value == 0x2F9D2 { return (true, to:[UnicodeScalar(0x8C55)!]) }
    if value == 0x2F9D3 { return (true, to:[UnicodeScalar(0x27CA8)!]) }
    if value == 0x2F9D4 { return (true, to:[UnicodeScalar(0x8CAB)!]) }
    if value == 0x2F9D5 { return (true, to:[UnicodeScalar(0x8CC1)!]) }
    if value == 0x2F9D6 { return (true, to:[UnicodeScalar(0x8D1B)!]) }
    if value == 0x2F9D7 { return (true, to:[UnicodeScalar(0x8D77)!]) }
    if value == 0x2F9D8 { return (true, to:[UnicodeScalar(0x27F2F)!]) }
    if value == 0x2F9D9 { return (true, to:[UnicodeScalar(0x20804)!]) }
    if value == 0x2F9DA { return (true, to:[UnicodeScalar(0x8DCB)!]) }
    if value == 0x2F9DB { return (true, to:[UnicodeScalar(0x8DBC)!]) }
    if value == 0x2F9DC { return (true, to:[UnicodeScalar(0x8DF0)!]) }
    if value == 0x2F9DD { return (true, to:[UnicodeScalar(0x208DE)!]) }
    if value == 0x2F9DE { return (true, to:[UnicodeScalar(0x8ED4)!]) }
    if value == 0x2F9DF { return (true, to:[UnicodeScalar(0x8F38)!]) }
    if value == 0x2F9E0 { return (true, to:[UnicodeScalar(0x285D2)!]) }
    if value == 0x2F9E1 { return (true, to:[UnicodeScalar(0x285ED)!]) }
    if value == 0x2F9E2 { return (true, to:[UnicodeScalar(0x9094)!]) }
    if value == 0x2F9E3 { return (true, to:[UnicodeScalar(0x90F1)!]) }
    if value == 0x2F9E4 { return (true, to:[UnicodeScalar(0x9111)!]) }
    if value == 0x2F9E5 { return (true, to:[UnicodeScalar(0x2872E)!]) }
    if value == 0x2F9E6 { return (true, to:[UnicodeScalar(0x911B)!]) }
    if value == 0x2F9E7 { return (true, to:[UnicodeScalar(0x9238)!]) }
    if value == 0x2F9E8 { return (true, to:[UnicodeScalar(0x92D7)!]) }
    if value == 0x2F9E9 { return (true, to:[UnicodeScalar(0x92D8)!]) }
    if value == 0x2F9EA { return (true, to:[UnicodeScalar(0x927C)!]) }
    if value == 0x2F9EB { return (true, to:[UnicodeScalar(0x93F9)!]) }
    if value == 0x2F9EC { return (true, to:[UnicodeScalar(0x9415)!]) }
    if value == 0x2F9ED { return (true, to:[UnicodeScalar(0x28BFA)!]) }
    if value == 0x2F9EE { return (true, to:[UnicodeScalar(0x958B)!]) }
    if value == 0x2F9EF { return (true, to:[UnicodeScalar(0x4995)!]) }
    if value == 0x2F9F0 { return (true, to:[UnicodeScalar(0x95B7)!]) }
    if value == 0x2F9F1 { return (true, to:[UnicodeScalar(0x28D77)!]) }
    if value == 0x2F9F2 { return (true, to:[UnicodeScalar(0x49E6)!]) }
    if value == 0x2F9F3 { return (true, to:[UnicodeScalar(0x96C3)!]) }
    if value == 0x2F9F4 { return (true, to:[UnicodeScalar(0x5DB2)!]) }
    if value == 0x2F9F5 { return (true, to:[UnicodeScalar(0x9723)!]) }
    if value == 0x2F9F6 { return (true, to:[UnicodeScalar(0x29145)!]) }
    if value == 0x2F9F7 { return (true, to:[UnicodeScalar(0x2921A)!]) }
    if value == 0x2F9F8 { return (true, to:[UnicodeScalar(0x4A6E)!]) }
    if value == 0x2F9F9 { return (true, to:[UnicodeScalar(0x4A76)!]) }
    if value == 0x2F9FA { return (true, to:[UnicodeScalar(0x97E0)!]) }
    if value == 0x2F9FB { return (true, to:[UnicodeScalar(0x2940A)!]) }
    if value == 0x2F9FC { return (true, to:[UnicodeScalar(0x4AB2)!]) }
    if value == 0x2F9FD { return (true, to:[UnicodeScalar(0x29496)!]) }
    if (0x2F9FE <= value && value <= 0x2F9FF) { return (true, to:[UnicodeScalar(0x980B)!]) }
    if value == 0x2FA00 { return (true, to:[UnicodeScalar(0x9829)!]) }
    if value == 0x2FA01 { return (true, to:[UnicodeScalar(0x295B6)!]) }
    if value == 0x2FA02 { return (true, to:[UnicodeScalar(0x98E2)!]) }
    if value == 0x2FA03 { return (true, to:[UnicodeScalar(0x4B33)!]) }
    if value == 0x2FA04 { return (true, to:[UnicodeScalar(0x9929)!]) }
    if value == 0x2FA05 { return (true, to:[UnicodeScalar(0x99A7)!]) }
    if value == 0x2FA06 { return (true, to:[UnicodeScalar(0x99C2)!]) }
    if value == 0x2FA07 { return (true, to:[UnicodeScalar(0x99FE)!]) }
    if value == 0x2FA08 { return (true, to:[UnicodeScalar(0x4BCE)!]) }
    if value == 0x2FA09 { return (true, to:[UnicodeScalar(0x29B30)!]) }
    if value == 0x2FA0A { return (true, to:[UnicodeScalar(0x9B12)!]) }
    if value == 0x2FA0B { return (true, to:[UnicodeScalar(0x9C40)!]) }
    if value == 0x2FA0C { return (true, to:[UnicodeScalar(0x9CFD)!]) }
    if value == 0x2FA0D { return (true, to:[UnicodeScalar(0x4CCE)!]) }
    if value == 0x2FA0E { return (true, to:[UnicodeScalar(0x4CED)!]) }
    if value == 0x2FA0F { return (true, to:[UnicodeScalar(0x9D67)!]) }
    if value == 0x2FA10 { return (true, to:[UnicodeScalar(0x2A0CE)!]) }
    if value == 0x2FA11 { return (true, to:[UnicodeScalar(0x4CF8)!]) }
    if value == 0x2FA12 { return (true, to:[UnicodeScalar(0x2A105)!]) }
    if value == 0x2FA13 { return (true, to:[UnicodeScalar(0x2A20E)!]) }
    if value == 0x2FA14 { return (true, to:[UnicodeScalar(0x2A291)!]) }
    if value == 0x2FA15 { return (true, to:[UnicodeScalar(0x9EBB)!]) }
    if value == 0x2FA16 { return (true, to:[UnicodeScalar(0x4D56)!]) }
    if value == 0x2FA17 { return (true, to:[UnicodeScalar(0x9EF9)!]) }
    if value == 0x2FA18 { return (true, to:[UnicodeScalar(0x9EFE)!]) }
    if value == 0x2FA19 { return (true, to:[UnicodeScalar(0x9F05)!]) }
    if value == 0x2FA1A { return (true, to:[UnicodeScalar(0x9F0F)!]) }
    if value == 0x2FA1B { return (true, to:[UnicodeScalar(0x9F16)!]) }
    if value == 0x2FA1C { return (true, to:[UnicodeScalar(0x9F3B)!]) }
    if value == 0x2FA1D { return (true, to:[UnicodeScalar(0x2A600)!]) }
    return (false, to:nil)
  }
  fileprivate var isDeviation: (Bool, to:[UnicodeScalar]?) {
    let value: UInt32 = self.value
    if value == 0x00DF { return (true, to:[UnicodeScalar(0x0073)!, UnicodeScalar(0x0073)!]) }
    if value == 0x03C2 { return (true, to:[UnicodeScalar(0x03C3)!]) }
    if (0x200C <= value && value <= 0x200D) { return (true, to:nil) }
    return (false, to:nil)
  }
  fileprivate var isDisallowedButMappedUsingSTD3ASCIIRules: (Bool, to:[UnicodeScalar]?) {
    let value: UInt32 = self.value
    if value == 0x00A0 { return (true, to:[UnicodeScalar(0x0020)!]) }
    if value == 0x00A8 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0308)!]) }
    if value == 0x00AF { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0304)!]) }
    if value == 0x00B4 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0301)!]) }
    if value == 0x00B8 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0327)!]) }
    if value == 0x02D8 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0306)!]) }
    if value == 0x02D9 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0307)!]) }
    if value == 0x02DA { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x030A)!]) }
    if value == 0x02DB { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0328)!]) }
    if value == 0x02DC { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0303)!]) }
    if value == 0x02DD { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x030B)!]) }
    if value == 0x037A { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x03B9)!]) }
    if value == 0x037E { return (true, to:[UnicodeScalar(0x003B)!]) }
    if value == 0x0384 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0301)!]) }
    if value == 0x0385 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0308)!, UnicodeScalar(0x0301)!]) }
    if value == 0x1FBD { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0313)!]) }
    if value == 0x1FBF { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0313)!]) }
    if value == 0x1FC0 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0342)!]) }
    if value == 0x1FC1 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0308)!, UnicodeScalar(0x0342)!]) }
    if value == 0x1FCD { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0313)!, UnicodeScalar(0x0300)!]) }
    if value == 0x1FCE { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0313)!, UnicodeScalar(0x0301)!]) }
    if value == 0x1FCF { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0313)!, UnicodeScalar(0x0342)!]) }
    if value == 0x1FDD { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0314)!, UnicodeScalar(0x0300)!]) }
    if value == 0x1FDE { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0314)!, UnicodeScalar(0x0301)!]) }
    if value == 0x1FDF { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0314)!, UnicodeScalar(0x0342)!]) }
    if value == 0x1FED { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0308)!, UnicodeScalar(0x0300)!]) }
    if value == 0x1FEE { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0308)!, UnicodeScalar(0x0301)!]) }
    if value == 0x1FEF { return (true, to:[UnicodeScalar(0x0060)!]) }
    if value == 0x1FFD { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0301)!]) }
    if value == 0x1FFE { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0314)!]) }
    if (0x2000 <= value && value <= 0x200A) { return (true, to:[UnicodeScalar(0x0020)!]) }
    if value == 0x2017 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0333)!]) }
    if value == 0x202F { return (true, to:[UnicodeScalar(0x0020)!]) }
    if value == 0x203C { return (true, to:[UnicodeScalar(0x0021)!, UnicodeScalar(0x0021)!]) }
    if value == 0x203E { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0305)!]) }
    if value == 0x2047 { return (true, to:[UnicodeScalar(0x003F)!, UnicodeScalar(0x003F)!]) }
    if value == 0x2048 { return (true, to:[UnicodeScalar(0x003F)!, UnicodeScalar(0x0021)!]) }
    if value == 0x2049 { return (true, to:[UnicodeScalar(0x0021)!, UnicodeScalar(0x003F)!]) }
    if value == 0x205F { return (true, to:[UnicodeScalar(0x0020)!]) }
    if value == 0x207A { return (true, to:[UnicodeScalar(0x002B)!]) }
    if value == 0x207C { return (true, to:[UnicodeScalar(0x003D)!]) }
    if value == 0x207D { return (true, to:[UnicodeScalar(0x0028)!]) }
    if value == 0x207E { return (true, to:[UnicodeScalar(0x0029)!]) }
    if value == 0x208A { return (true, to:[UnicodeScalar(0x002B)!]) }
    if value == 0x208C { return (true, to:[UnicodeScalar(0x003D)!]) }
    if value == 0x208D { return (true, to:[UnicodeScalar(0x0028)!]) }
    if value == 0x208E { return (true, to:[UnicodeScalar(0x0029)!]) }
    if value == 0x2100 { return (true, to:[UnicodeScalar(0x0061)!, UnicodeScalar(0x002F)!, UnicodeScalar(0x0063)!]) }
    if value == 0x2101 { return (true, to:[UnicodeScalar(0x0061)!, UnicodeScalar(0x002F)!, UnicodeScalar(0x0073)!]) }
    if value == 0x2105 { return (true, to:[UnicodeScalar(0x0063)!, UnicodeScalar(0x002F)!, UnicodeScalar(0x006F)!]) }
    if value == 0x2106 { return (true, to:[UnicodeScalar(0x0063)!, UnicodeScalar(0x002F)!, UnicodeScalar(0x0075)!]) }
    if value == 0x2474 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x0029)!]) }
    if value == 0x2475 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0032)!, UnicodeScalar(0x0029)!]) }
    if value == 0x2476 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0033)!, UnicodeScalar(0x0029)!]) }
    if value == 0x2477 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0034)!, UnicodeScalar(0x0029)!]) }
    if value == 0x2478 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0035)!, UnicodeScalar(0x0029)!]) }
    if value == 0x2479 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0036)!, UnicodeScalar(0x0029)!]) }
    if value == 0x247A { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0037)!, UnicodeScalar(0x0029)!]) }
    if value == 0x247B { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0038)!, UnicodeScalar(0x0029)!]) }
    if value == 0x247C { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0039)!, UnicodeScalar(0x0029)!]) }
    if value == 0x247D { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x0030)!, UnicodeScalar(0x0029)!]) }
    if value == 0x247E { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x0029)!]) }
    if value == 0x247F { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x0032)!, UnicodeScalar(0x0029)!]) }
    if value == 0x2480 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x0033)!, UnicodeScalar(0x0029)!]) }
    if value == 0x2481 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x0034)!, UnicodeScalar(0x0029)!]) }
    if value == 0x2482 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x0035)!, UnicodeScalar(0x0029)!]) }
    if value == 0x2483 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x0036)!, UnicodeScalar(0x0029)!]) }
    if value == 0x2484 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x0037)!, UnicodeScalar(0x0029)!]) }
    if value == 0x2485 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x0038)!, UnicodeScalar(0x0029)!]) }
    if value == 0x2486 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0031)!, UnicodeScalar(0x0039)!, UnicodeScalar(0x0029)!]) }
    if value == 0x2487 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0032)!, UnicodeScalar(0x0030)!, UnicodeScalar(0x0029)!]) }
    if value == 0x249C { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0061)!, UnicodeScalar(0x0029)!]) }
    if value == 0x249D { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0062)!, UnicodeScalar(0x0029)!]) }
    if value == 0x249E { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0063)!, UnicodeScalar(0x0029)!]) }
    if value == 0x249F { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0064)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24A0 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0065)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24A1 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0066)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24A2 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0067)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24A3 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0068)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24A4 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0069)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24A5 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x006A)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24A6 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x006B)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24A7 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x006C)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24A8 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x006D)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24A9 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x006E)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24AA { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x006F)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24AB { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0070)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24AC { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0071)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24AD { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0072)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24AE { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0073)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24AF { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0074)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24B0 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0075)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24B1 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0076)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24B2 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0077)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24B3 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0078)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24B4 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0079)!, UnicodeScalar(0x0029)!]) }
    if value == 0x24B5 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x007A)!, UnicodeScalar(0x0029)!]) }
    if value == 0x2A74 { return (true, to:[UnicodeScalar(0x003A)!, UnicodeScalar(0x003A)!, UnicodeScalar(0x003D)!]) }
    if value == 0x2A75 { return (true, to:[UnicodeScalar(0x003D)!, UnicodeScalar(0x003D)!]) }
    if value == 0x2A76 { return (true, to:[UnicodeScalar(0x003D)!, UnicodeScalar(0x003D)!, UnicodeScalar(0x003D)!]) }
    if value == 0x3000 { return (true, to:[UnicodeScalar(0x0020)!]) }
    if value == 0x309B { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x3099)!]) }
    if value == 0x309C { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x309A)!]) }
    if value == 0x3200 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x1100)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3201 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x1102)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3202 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x1103)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3203 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x1105)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3204 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x1106)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3205 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x1107)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3206 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x1109)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3207 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x110B)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3208 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x110C)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3209 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x110E)!, UnicodeScalar(0x0029)!]) }
    if value == 0x320A { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x110F)!, UnicodeScalar(0x0029)!]) }
    if value == 0x320B { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x1110)!, UnicodeScalar(0x0029)!]) }
    if value == 0x320C { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x1111)!, UnicodeScalar(0x0029)!]) }
    if value == 0x320D { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x1112)!, UnicodeScalar(0x0029)!]) }
    if value == 0x320E { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xAC00)!, UnicodeScalar(0x0029)!]) }
    if value == 0x320F { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xB098)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3210 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xB2E4)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3211 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xB77C)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3212 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xB9C8)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3213 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xBC14)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3214 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xC0AC)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3215 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xC544)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3216 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xC790)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3217 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xCC28)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3218 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xCE74)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3219 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xD0C0)!, UnicodeScalar(0x0029)!]) }
    if value == 0x321A { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xD30C)!, UnicodeScalar(0x0029)!]) }
    if value == 0x321B { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xD558)!, UnicodeScalar(0x0029)!]) }
    if value == 0x321C { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xC8FC)!, UnicodeScalar(0x0029)!]) }
    if value == 0x321D { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xC624)!, UnicodeScalar(0xC804)!, UnicodeScalar(0x0029)!]) }
    if value == 0x321E { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0xC624)!, UnicodeScalar(0xD6C4)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3220 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x4E00)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3221 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x4E8C)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3222 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x4E09)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3223 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x56DB)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3224 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x4E94)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3225 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x516D)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3226 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x4E03)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3227 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x516B)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3228 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x4E5D)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3229 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x5341)!, UnicodeScalar(0x0029)!]) }
    if value == 0x322A { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x6708)!, UnicodeScalar(0x0029)!]) }
    if value == 0x322B { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x706B)!, UnicodeScalar(0x0029)!]) }
    if value == 0x322C { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x6C34)!, UnicodeScalar(0x0029)!]) }
    if value == 0x322D { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x6728)!, UnicodeScalar(0x0029)!]) }
    if value == 0x322E { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x91D1)!, UnicodeScalar(0x0029)!]) }
    if value == 0x322F { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x571F)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3230 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x65E5)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3231 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x682A)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3232 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x6709)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3233 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x793E)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3234 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x540D)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3235 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x7279)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3236 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x8CA1)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3237 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x795D)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3238 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x52B4)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3239 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x4EE3)!, UnicodeScalar(0x0029)!]) }
    if value == 0x323A { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x547C)!, UnicodeScalar(0x0029)!]) }
    if value == 0x323B { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x5B66)!, UnicodeScalar(0x0029)!]) }
    if value == 0x323C { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x76E3)!, UnicodeScalar(0x0029)!]) }
    if value == 0x323D { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x4F01)!, UnicodeScalar(0x0029)!]) }
    if value == 0x323E { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x8CC7)!, UnicodeScalar(0x0029)!]) }
    if value == 0x323F { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x5354)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3240 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x796D)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3241 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x4F11)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3242 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x81EA)!, UnicodeScalar(0x0029)!]) }
    if value == 0x3243 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x81F3)!, UnicodeScalar(0x0029)!]) }
    if value == 0xFB29 { return (true, to:[UnicodeScalar(0x002B)!]) }
    if value == 0xFC5E { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x064C)!, UnicodeScalar(0x0651)!]) }
    if value == 0xFC5F { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x064D)!, UnicodeScalar(0x0651)!]) }
    if value == 0xFC60 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x064E)!, UnicodeScalar(0x0651)!]) }
    if value == 0xFC61 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x064F)!, UnicodeScalar(0x0651)!]) }
    if value == 0xFC62 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0650)!, UnicodeScalar(0x0651)!]) }
    if value == 0xFC63 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0651)!, UnicodeScalar(0x0670)!]) }
    if value == 0xFDFA { return (true, to:[UnicodeScalar(0x0635)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x0649)!, UnicodeScalar(0x0020)!, UnicodeScalar(0x0627)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x0647)!, UnicodeScalar(0x0020)!, UnicodeScalar(0x0639)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x064A)!, UnicodeScalar(0x0647)!, UnicodeScalar(0x0020)!, UnicodeScalar(0x0648)!, UnicodeScalar(0x0633)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x0645)!]) }
    if value == 0xFDFB { return (true, to:[UnicodeScalar(0x062C)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x0020)!, UnicodeScalar(0x062C)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x0627)!, UnicodeScalar(0x0644)!, UnicodeScalar(0x0647)!]) }
    if value == 0xFE10 { return (true, to:[UnicodeScalar(0x002C)!]) }
    if value == 0xFE13 { return (true, to:[UnicodeScalar(0x003A)!]) }
    if value == 0xFE14 { return (true, to:[UnicodeScalar(0x003B)!]) }
    if value == 0xFE15 { return (true, to:[UnicodeScalar(0x0021)!]) }
    if value == 0xFE16 { return (true, to:[UnicodeScalar(0x003F)!]) }
    if (0xFE33 <= value && value <= 0xFE34) { return (true, to:[UnicodeScalar(0x005F)!]) }
    if value == 0xFE35 { return (true, to:[UnicodeScalar(0x0028)!]) }
    if value == 0xFE36 { return (true, to:[UnicodeScalar(0x0029)!]) }
    if value == 0xFE37 { return (true, to:[UnicodeScalar(0x007B)!]) }
    if value == 0xFE38 { return (true, to:[UnicodeScalar(0x007D)!]) }
    if value == 0xFE47 { return (true, to:[UnicodeScalar(0x005B)!]) }
    if value == 0xFE48 { return (true, to:[UnicodeScalar(0x005D)!]) }
    if (0xFE49 <= value && value <= 0xFE4C) { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0305)!]) }
    if (0xFE4D <= value && value <= 0xFE4F) { return (true, to:[UnicodeScalar(0x005F)!]) }
    if value == 0xFE50 { return (true, to:[UnicodeScalar(0x002C)!]) }
    if value == 0xFE54 { return (true, to:[UnicodeScalar(0x003B)!]) }
    if value == 0xFE55 { return (true, to:[UnicodeScalar(0x003A)!]) }
    if value == 0xFE56 { return (true, to:[UnicodeScalar(0x003F)!]) }
    if value == 0xFE57 { return (true, to:[UnicodeScalar(0x0021)!]) }
    if value == 0xFE59 { return (true, to:[UnicodeScalar(0x0028)!]) }
    if value == 0xFE5A { return (true, to:[UnicodeScalar(0x0029)!]) }
    if value == 0xFE5B { return (true, to:[UnicodeScalar(0x007B)!]) }
    if value == 0xFE5C { return (true, to:[UnicodeScalar(0x007D)!]) }
    if value == 0xFE5F { return (true, to:[UnicodeScalar(0x0023)!]) }
    if value == 0xFE60 { return (true, to:[UnicodeScalar(0x0026)!]) }
    if value == 0xFE61 { return (true, to:[UnicodeScalar(0x002A)!]) }
    if value == 0xFE62 { return (true, to:[UnicodeScalar(0x002B)!]) }
    if value == 0xFE64 { return (true, to:[UnicodeScalar(0x003C)!]) }
    if value == 0xFE65 { return (true, to:[UnicodeScalar(0x003E)!]) }
    if value == 0xFE66 { return (true, to:[UnicodeScalar(0x003D)!]) }
    if value == 0xFE68 { return (true, to:[UnicodeScalar(0x005C)!]) }
    if value == 0xFE69 { return (true, to:[UnicodeScalar(0x0024)!]) }
    if value == 0xFE6A { return (true, to:[UnicodeScalar(0x0025)!]) }
    if value == 0xFE6B { return (true, to:[UnicodeScalar(0x0040)!]) }
    if value == 0xFE70 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x064B)!]) }
    if value == 0xFE72 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x064C)!]) }
    if value == 0xFE74 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x064D)!]) }
    if value == 0xFE76 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x064E)!]) }
    if value == 0xFE78 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x064F)!]) }
    if value == 0xFE7A { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0650)!]) }
    if value == 0xFE7C { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0651)!]) }
    if value == 0xFE7E { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0652)!]) }
    if value == 0xFF01 { return (true, to:[UnicodeScalar(0x0021)!]) }
    if value == 0xFF02 { return (true, to:[UnicodeScalar(0x0022)!]) }
    if value == 0xFF03 { return (true, to:[UnicodeScalar(0x0023)!]) }
    if value == 0xFF04 { return (true, to:[UnicodeScalar(0x0024)!]) }
    if value == 0xFF05 { return (true, to:[UnicodeScalar(0x0025)!]) }
    if value == 0xFF06 { return (true, to:[UnicodeScalar(0x0026)!]) }
    if value == 0xFF07 { return (true, to:[UnicodeScalar(0x0027)!]) }
    if value == 0xFF08 { return (true, to:[UnicodeScalar(0x0028)!]) }
    if value == 0xFF09 { return (true, to:[UnicodeScalar(0x0029)!]) }
    if value == 0xFF0A { return (true, to:[UnicodeScalar(0x002A)!]) }
    if value == 0xFF0B { return (true, to:[UnicodeScalar(0x002B)!]) }
    if value == 0xFF0C { return (true, to:[UnicodeScalar(0x002C)!]) }
    if value == 0xFF0F { return (true, to:[UnicodeScalar(0x002F)!]) }
    if value == 0xFF1A { return (true, to:[UnicodeScalar(0x003A)!]) }
    if value == 0xFF1B { return (true, to:[UnicodeScalar(0x003B)!]) }
    if value == 0xFF1C { return (true, to:[UnicodeScalar(0x003C)!]) }
    if value == 0xFF1D { return (true, to:[UnicodeScalar(0x003D)!]) }
    if value == 0xFF1E { return (true, to:[UnicodeScalar(0x003E)!]) }
    if value == 0xFF1F { return (true, to:[UnicodeScalar(0x003F)!]) }
    if value == 0xFF20 { return (true, to:[UnicodeScalar(0x0040)!]) }
    if value == 0xFF3B { return (true, to:[UnicodeScalar(0x005B)!]) }
    if value == 0xFF3C { return (true, to:[UnicodeScalar(0x005C)!]) }
    if value == 0xFF3D { return (true, to:[UnicodeScalar(0x005D)!]) }
    if value == 0xFF3E { return (true, to:[UnicodeScalar(0x005E)!]) }
    if value == 0xFF3F { return (true, to:[UnicodeScalar(0x005F)!]) }
    if value == 0xFF40 { return (true, to:[UnicodeScalar(0x0060)!]) }
    if value == 0xFF5B { return (true, to:[UnicodeScalar(0x007B)!]) }
    if value == 0xFF5C { return (true, to:[UnicodeScalar(0x007C)!]) }
    if value == 0xFF5D { return (true, to:[UnicodeScalar(0x007D)!]) }
    if value == 0xFF5E { return (true, to:[UnicodeScalar(0x007E)!]) }
    if value == 0xFFE3 { return (true, to:[UnicodeScalar(0x0020)!, UnicodeScalar(0x0304)!]) }
    if value == 0x1F101 { return (true, to:[UnicodeScalar(0x0030)!, UnicodeScalar(0x002C)!]) }
    if value == 0x1F102 { return (true, to:[UnicodeScalar(0x0031)!, UnicodeScalar(0x002C)!]) }
    if value == 0x1F103 { return (true, to:[UnicodeScalar(0x0032)!, UnicodeScalar(0x002C)!]) }
    if value == 0x1F104 { return (true, to:[UnicodeScalar(0x0033)!, UnicodeScalar(0x002C)!]) }
    if value == 0x1F105 { return (true, to:[UnicodeScalar(0x0034)!, UnicodeScalar(0x002C)!]) }
    if value == 0x1F106 { return (true, to:[UnicodeScalar(0x0035)!, UnicodeScalar(0x002C)!]) }
    if value == 0x1F107 { return (true, to:[UnicodeScalar(0x0036)!, UnicodeScalar(0x002C)!]) }
    if value == 0x1F108 { return (true, to:[UnicodeScalar(0x0037)!, UnicodeScalar(0x002C)!]) }
    if value == 0x1F109 { return (true, to:[UnicodeScalar(0x0038)!, UnicodeScalar(0x002C)!]) }
    if value == 0x1F10A { return (true, to:[UnicodeScalar(0x0039)!, UnicodeScalar(0x002C)!]) }
    if value == 0x1F110 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0061)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F111 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0062)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F112 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0063)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F113 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0064)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F114 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0065)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F115 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0066)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F116 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0067)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F117 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0068)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F118 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0069)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F119 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x006A)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F11A { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x006B)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F11B { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x006C)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F11C { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x006D)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F11D { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x006E)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F11E { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x006F)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F11F { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0070)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F120 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0071)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F121 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0072)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F122 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0073)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F123 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0074)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F124 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0075)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F125 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0076)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F126 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0077)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F127 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0078)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F128 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x0079)!, UnicodeScalar(0x0029)!]) }
    if value == 0x1F129 { return (true, to:[UnicodeScalar(0x0028)!, UnicodeScalar(0x007A)!, UnicodeScalar(0x0029)!]) }
    return (false, to:nil)
  }
}

extension UnicodeScalar {
  public func idnaStatus(usingSTD3ASCIIRules std3:Bool = true, idna2008Compatible idna2008:Bool = false) -> UnicodeScalar.IDNAStatus? {
    if self.isValidButDisallowedInIDNA2008 {
      if idna2008 { return .disallowed }
      return .valid
    }
    if self.isValid { return .valid }
    if self.isIgnored { return .ignored }
    if self.isDisallowed { return .disallowed }
    if self.isDisallowedButValidUsingSTD3ASCIIRules {
      if std3 { return .valid }
      return .disallowed
    }
    switch self.isMapped {
      case (true, let scalars): return .mapped(scalars)
      default: break
    }
    switch self.isDeviation {
      case (true, let scalars): return .mapped(scalars)
      default: break
    }
    switch self.isDisallowedButMappedUsingSTD3ASCIIRules {
      case (true, let scalars):
        if std3 { return .mapped(scalars) }
        return .disallowed
      default: break
    }
    return nil
  }
}
