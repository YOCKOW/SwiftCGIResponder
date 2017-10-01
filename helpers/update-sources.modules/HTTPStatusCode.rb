=begin
 
 HTTPStatusCode.rb
   ©︎ 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end

require File.realpath('./_common_.rb', File.dirname(__FILE__))
require File.realpath('./_swift_common_.rb', File.dirname(__FILE__))

module HTTPStatusCode
  PATH = 'Sources/CGIResponder/HTTPStatusCode.swift'
  URLs = [
    URI.parse('https://www.iana.org/assignments/http-status-codes/http-status-codes-1.csv')
  ]
  
  extend SWIFT_COMMON
  
  def write(file)
    codes = []
    URLs.each {|url|
      $stdout.puts("- Fetching #{url}")
      url.parse_csv {|row|
        next if row[0] !~ /^[0-9][0-9][0-9]$/ || row[1] =~ /^(?:Unassigned|\(Unused\))$/i
        codes.push([row[1].to_keyword, row[0], row[1]])
      }
    }
    raise "No data about HTTP Status Codes" if codes.count < 1
    
    file.puts(head(PATH, URLs))
    file.puts('public enum HTTPStatusCode: UInt16 {')
    codes.each {|info|
      file.write('  case ')
      file.write((info[0].reserved?) ? "`#{info[0]}`" : "#{info[0]}")
      file.write(" = #{info[1]}")
      file.write("\n")
    }
    file.puts('}')
    file.puts('extension HTTPStatusCode{')
    file.puts('  public var reasonPhrase: String {')
    file.puts('    switch self {')
    codes.each {|info|
      file.puts("    case .#{info[0]}: return \"#{info[2]}\" // #{info[1]}")
    }
    file.puts('    }')
    file.puts('  }')
    file.puts('}')
  end
  module_function :write
end
