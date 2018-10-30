=begin
 
 ContentDispositionParameterKey.rb
   ©︎ 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end


module ContentDispositionParameterKey_IANARegistered
  PATH = 'Sources/Supporters/HTTP/ContentDispositionParameterKey+IANARegistered.swift'
  URLs = [
    URI.parse('https://www.iana.org/assignments/cont-disp/cont-disp-2.csv')
  ]
end
  
module ContentDispositionParameterKey_IANARegistered; class << self
  def write(remote_io, file)
    keys = []
    remote_io.parse_csv {|row|
      next if row[0] !~ /^[\-a-z]+$/
      keys.push(row[0])
    }
    raise "No data about Cotent Dispocition Parameters" if keys.count < 1
    
    _TYPE_NAME = "ContentDispositionParameterKey"
    
    file.puts("extension #{_TYPE_NAME} {")
    keys.each {|key|
      file.write("  public static let #{key.to_swift_identifier}")
      file.write(" = #{_TYPE_NAME}(rawValue:\"#{key}\")\n")
    }
    file.puts('}')
  end
end; end

