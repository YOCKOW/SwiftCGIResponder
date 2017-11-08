=begin
 
 HTTPHeaderFieldName_IANARegistered.rb
   ©︎ 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end

require File.realpath('./_common_.rb', File.dirname(__FILE__))
require File.realpath('./_swift_common_.rb', File.dirname(__FILE__))

module HTTPHeaderFieldName_IANARegistered
  PATH = 'Sources/CGIResponder/HTTPHeaderFieldName+IANARegistered.swift'
  URLs = [
    URI.parse('https://www.iana.org/assignments/message-headers/perm-headers.csv'),
    URI.parse('https://www.iana.org/assignments/message-headers/prov-headers.csv')
  ]
  
  extend SWIFT_COMMON
  
  def write(file)
    headers = []
    URLs.each {|url|
      $stdout.puts("- Fetching #{url}")
      url.parse_csv {|row|
        next if row[2] !~ /^http$/i || row[3] =~ /^(?:deprecated|obsoleted)$/i
        headers.push([row[0].to_keyword, row[0]])
      }
    }
    raise "No data about HTTP Header Field Name" if headers.count < 1
    
    file.puts(head(PATH, URLs))
    file.puts('extension HTTPHeaderFieldName {')
    headers.each {|info|
      file.write('  public static let ')
      file.write((info[0].reserved?) ? "`#{info[0]}`" : "#{info[0]}")
      file.write(" = HTTPHeaderFieldName(rawValue:\"#{info[1]}\")!")
      file.write("\n")
    }
    file.puts('}')
  end
  
  module_function :write
end
