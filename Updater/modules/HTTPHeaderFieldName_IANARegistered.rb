=begin
 
 HTTPHeaderFieldName_IANARegistered.rb
   ©︎ 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end


module HTTPHeaderFieldName_IANARegistered
  PATH = 'Sources/Supporters/HTTP/HeaderFieldName+IANARegistered.swift'
  URLs = [
    URI.parse('https://www.iana.org/assignments/message-headers/perm-headers.csv'),
    URI.parse('https://www.iana.org/assignments/message-headers/prov-headers.csv')
  ]
  
  module_function def write(remote_io, file)
    headers = []
    remote_io.parse_csv {|row|
      next if row[2] !~ /^http$/i || row[3] =~ /^(?:deprecated|obsoleted)$/i
      headers.push([row[0].to_keyword, row[0]])
    }
    raise "No data about HTTP Header Field Name" if headers.count < 1
    
    _TYPE_NAME = "HeaderFieldName"
    
    file.puts("extension #{_TYPE_NAME} {")
    headers.each {|info|
      file.write('  public static let ')
      file.write((info[0].reserved?) ? "`#{info[0]}`" : "#{info[0]}")
      file.write(" = HeaderFieldName(rawValue:\"#{info[1]}\")!")
      file.write("\n")
    }
    file.puts('}')
  end
end

