=begin
 
 ContentDispositionValue.rb
   ©︎ 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end

require File.realpath('./_common_.rb', File.dirname(__FILE__))
require File.realpath('./_swift_common_.rb', File.dirname(__FILE__))

module ContentDispositionValue
  PATH = 'Sources/CGIResponder/ContentDispositionValue.swift'
  URLs = [
    URI.parse('https://www.iana.org/assignments/cont-disp/cont-disp-1.csv')
  ]
  
  extend SWIFT_COMMON
  
  def write(file)
    values = []
    URLs.each {|url|
      $stdout.puts("- Fetching #{url}")
      url.parse_csv {|row|
        next if row[0] !~ /^[\-a-z]+$/
        values.push(row[0])
      }
    }
    raise "No data about Content Disposition Values" if values.count < 1
    
    file.puts(head(PATH, URLs))
    file.puts('public enum ContentDispositionValue: String {')
    values.each {|value|
      keyword = value.to_keyword
      file.write('  case ')
      file.write((keyword.reserved?) ? "`#{keyword}`" : "#{keyword}")
      file.write(" = \"#{value}\"")
      file.write("\n")
    }
    file.puts('  public init(rawValue:String) {')
    file.puts('    switch rawValue.lowercased() {')
    values.each {|value|
      keyword = value.to_keyword
      file.puts("    case \"#{value}\": self = .#{keyword}")
    }
    file.puts('    default: self = .attachment')
    file.puts('    }')
    file.puts('  }')
    file.puts('}')
  end
  module_function :write
end
