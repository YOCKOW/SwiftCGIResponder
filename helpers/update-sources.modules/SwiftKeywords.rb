=begin
 
 SwiftKeywords.rb
   ©︎ 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end

require 'open-uri'

module SwiftKeywords
  PATH = 'SwiftKeywords.yml'
  URL = URI.parse('https://raw.githubusercontent.com/apple/swift/master/include/swift/Syntax/TokenKinds.def')
  
  def write(file)
    file.write("\# List of Swift Keywords\n")
    file.write("\# This file was automatically generated\n")
    file.write("\#   from #{URL}\n")
    file.write("\#\n")
    
    $stdout.puts("- Fetching #{URL}")
    URL.open.each {|line|
      if line =~ %r{^//\s*((?:Copyright|Licensed under Apache License|See https?://swift.org/).*)$}
        file.puts("\# #{$1}")
      elsif line =~ /^\s*(?:DECL_KEYWORD|STMT_KEYWORD|KEYWORD)\(([A-Z_a-z]+)\)/
        file.puts("- #{$1}")
      end
    }
  end
  module_function :write
  
end
