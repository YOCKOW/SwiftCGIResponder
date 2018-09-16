=begin
 
 HTTPMethod.rb
   ©︎ 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end

require File.realpath('./_common_.rb', File.dirname(__FILE__))
require File.realpath('./_swift_common_.rb', File.dirname(__FILE__))

module HTTPMethod
  PATH = 'Sources/CGIResponder/HTTPMethod.swift'
  URLs = [
    URI.parse('https://www.iana.org/assignments/http-methods/methods.csv')
  ]
  
  extend SWIFT_COMMON
  
  def write(file)
    methods = []
    URLs.each {|url|
      $stdout.puts("- Fetching #{url}")
      url.parse_csv {|row|
        next if row[0] !~ /^[\-A-Za-z]+$/
        methods.push(row[0].split(/\-/).map{|rr| rr.capitalize}.join('-'))
      }
    }
    raise "No data about HTTP Methods" if methods.count < 1
    
    file.puts(head(PATH, URLs))
    file.puts('public enum HTTPMethod: String {')
    methods.each {|method|
      file.puts("  case #{method.to_keyword} = \"#{method.upcase}\"")
    }
    file.puts('}')
  end
  module_function :write
end
