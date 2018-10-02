# What is `SwiftCGIResponder`?
`SwiftCGIResponder` will provide miscellaneous functions you may use when you write CGI programs in Swift.  
It's an experimental library under development, and useless as of now.

# Requirements
* Swift >= 4.1 + CoreFoundation + Foundation
* macOS >= 10.12 or Linux
* HTTP server software (e.g. Apache or similar software)

## Dependencies

* [SwiftBonaFideCharacterSet](https://github.com/YOCKOW/SwiftBonaFideCharacterSet)
* [SwiftRanges](https://github.com/YOCKOW/SwiftRanges)
* [SwiftUnicodeSupplement](https://github.com/YOCKOW/SwiftUnicodeSupplement)


# Usage

```Swift
import Foundation
import CGIResponder

var responder = CGIResponder()
responder.status = .ok
responder.contentType = MIMEType(pathExtension:.txt, parameters:["charset":"UTF-8"])!
responder.content = .string("Hello, World!\n", encoding:.utf8)

responder.respond()

// -- Output --
// Status: 200 OK
// Content-Type: text/plain; charset=UTF-8
//
// Hello, World!
//
```

You may see other samples in [SwiftCGIResponderSamples](https://github.com/YOCKOW/SwiftCGIResponderSamples).

# How to install

You can use [Swift Package Manager](https://github.com/apple/swift-package-manager) easily to import `CGIResponder` to your project.

# License
MIT License.  
See "LICENSE.txt" for more information.
