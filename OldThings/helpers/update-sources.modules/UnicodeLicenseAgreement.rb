=begin
 
 SwiftKeywords.rb
   ©︎ 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end

require 'open-uri'

module UnicodeLicenseAgreement
  PATH = 'UnicodeLicenseAgreement.txt'
  URL = URI.parse('http://unicode.org/copyright.html')
  
  def write(file)
    $stdout.puts("- Fetching #{URL}")
    
    terms_of_use = ""
    URL.open {|file|
      terms_of_use = file.read
    }
    terms_of_use = terms_of_use.match(%r{<a\s+name="License">(.+)</a>[\S\s]*<pre>\s*(\S[\S\s]*\S)\s*</pre>})[1,2].join("\n\n")
    raise "Cannot fetch UNICODE, INC. LICENSE AGREEMENT." if terms_of_use.length < 1
    
    file.puts(terms_of_use)
  end
  module_function :write
  
end
