=begin
 
 ContentDispositionParameterKey.rb
   ©︎ 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end

require File.realpath('./_common_.rb', File.dirname(__FILE__))
require File.realpath('./_swift_common_.rb', File.dirname(__FILE__))

module ContentDispositionParameterKey
  PATH = 'Sources/CGIResponder/ContentDispositionParameterKey.swift'
  URLs = [
    URI.parse('https://www.iana.org/assignments/cont-disp/cont-disp-2.csv')
  ]
  
  extend SWIFT_COMMON
  
  def write(file)
    keys = []
    URLs.each {|url|
      $stdout.puts("- Fetching #{url}")
      url.parse_csv {|row|
        next if row[0] !~ /^[\-a-z]+$/
        keys.push(row[0])
      }
    }
    raise "No data about Content Disposition Parameter Keys" if keys.count < 1
    
    file.puts(head(PATH, URLs))
    file.puts('public struct ContentDispositionParameterKey: RawRepresentable {')
    file.puts('  public let rawValue: String')
    file.puts('  public init(rawValue:String) { self.rawValue = rawValue }')
    file.puts('}')
    
    file.puts('extension ContentDispositionParameterKey: Hashable {')
    file.puts('  public var hashValue: Int { return self.rawValue.hashValue }')
    file.puts('  public static func ==(lhs:ContentDispositionParameterKey, rhs:ContentDispositionParameterKey) -> Bool {')
    file.puts('    return lhs.rawValue == rhs.rawValue')
    file.puts('  }')
    file.puts('}')
    
    file.puts('extension ContentDispositionParameterKey {')
    keys.each {|key|
      keyword = key.to_keyword
      file.write('  public static let ')
      file.write((keyword.reserved?) ? "`#{keyword}`" : "#{keyword}")
      file.write(" = ContentDispositionParameterKey(rawValue:\"#{key}\")")
      file.write("\n")
    }
    file.puts('}')
  end
  module_function :write
end
