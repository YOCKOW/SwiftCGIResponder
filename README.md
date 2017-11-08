# What is `SwiftCGIResponder`?
`SwiftCGIResponder` will provide miscellaneous functions you may use when you write CGI programs in Swift.
It's an experimental library under development, and useless so far. (I rebuild the library from scratch, once I had created.)

# Requirements
* Swift >= 4.0 + CoreFoundation + Foundation
* macOS >= 10.12 or Linux
* HTTP server software (e.g. Apache or similar software)

# Usage

```
import CGIResponder

var responder = CGIResponder()
responder.status = .ok
responder.contentType = MIMEType(pathExtension:.txt, parameters:["charset":"UTF-8"])!
responder.content = .string("Hello, World!\n", encoding:.utf8)

// -- Output --
// Status: 200 OK
// Content-Type: text/plain; charset=UTF-8
//
// Hello, World!
//
```

# How to install

```
git clone https://github.com/YOCKOW/SwiftCGIResponder.git
cd SwiftCGIResponder
sudo ./build-install.rb --install-prefix=/path/to/your/system --install
swiftc ./your/project/main.swift -I/path/to/your/system/include -L/path/to/your/system/lib -lSwiftCGIResponder
```

... or you can also use [Swift Package Manager](https://github.com/apple/swift-package-manager) easily to import `CGIResponder` to your project.

# License
MIT License.  
See "LICENSE.txt" for more information.
