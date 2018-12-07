=begin
 
 CFStringEncodings.rb
   ©︎ 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end


module CFStringEncodings
  PATH = 'Sources/Supporters/LibExtender/CFStringEncodings.swift'
  URLs = [
    URI.parse('https://raw.githubusercontent.com/apple/swift-corelibs-foundation/master/CoreFoundation/String.subproj/CFString.h'),
    URI.parse('https://raw.githubusercontent.com/apple/swift-corelibs-foundation/master/CoreFoundation/String.subproj/CFStringEncodingExt.h')
  ]
end
  
module CFStringEncodings; class << self
  @@imported_cf = false
  
  def write(remote_io, file)
    if !@@imported_cf
      file.puts("import CoreFoundation")
      file.puts()
      @@imported_cf = true
    end
    
    encodings = {}
    
    copyright_sentences = true
    remote_io.each {|line|
      if copyright_sentences
        file.write(line)
        if line =~ /^\s*\*\//
          copyright_sentences = false
        end
      elsif line =~ /^\s*kCFStringEncoding([0-9A-Z_a-z]+)(?:\sAPI_AVAILABLE.+)?\s*=\s*(0x[0-9A-Fa-f]+|\d+)/
        encodings[$1] = $2
      end
    }
    
    file.puts("extension CFString.Encoding {")
    encodings.keys.each {|key|
      enc_name = key.to_swift_identifier
      file.puts("  public static let #{enc_name} = CFString.Encoding(rawValue:#{encodings[key]})")
    }
    file.puts("}")
    file.puts()
  end
end; end

