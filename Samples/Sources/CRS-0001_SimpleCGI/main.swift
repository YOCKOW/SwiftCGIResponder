/***************************************************************************************************
 CRS-0001
   © 2017-2018 YOCKOW.
     Licensed under CC0 1.0 Universal.
     See "LICENSE.txt" for more information.
 **************************************************************************************************/

// Very simple CGI program with `CGIResponder`.
// Don't forget `respond()`.

import CGIResponder
import NetworkGear

var responder = CGIResponder()
responder.status = .ok
responder.contentType = ContentType(pathExtension: .txt, parameters: ["charset": "UTF-8"])!
responder.content = .string("Hello, World!\n", encoding: .utf8)

try! responder.respond()
