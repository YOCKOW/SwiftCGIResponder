=begin
 
 HTTPStatusCode.rb
   ©︎ 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end


module HTTPStatusCode
  PATH = 'Sources/Supporters/HTTP/StatusCode.swift'
  URLs = [
    URI.parse('https://www.iana.org/assignments/http-status-codes/http-status-codes-1.csv')
  ]
end
  
module HTTPStatusCode; class << self
  def write(remote_io, file)
    codes = []
    remote_io.parse_csv {|row|
      next if row[0] !~ /^[0-9][0-9][0-9]$/ || row[1] =~ /^(?:Unassigned|\(Unused\))$/i
      codes.push([row[1].to_lower_camel_case, row[0], row[1]])
    }
    raise "No data about HTTP Status Codes" if codes.count < 1
    
    _TYPE_NAME = "StatusCode"
    
    file.puts("public enum #{_TYPE_NAME}: UInt16 {")
    codes.each {|info|
      file.write('  case ')
      file.write((info[0].reserved_by_swift?) ? "`#{info[0]}`" : "#{info[0]}")
      file.write(" = #{info[1]}")
      file.write("\n")
    }
    file.puts('}')
    file.puts()
    file.puts("extension #{_TYPE_NAME} {")
    file.puts('  public var reasonPhrase: String {')
    file.puts('    switch self {')
    codes.each {|info|
      file.puts("    case .#{info[0]}: return \"#{info[2]}\" // #{info[1]}")
    }
    file.puts('    }')
    file.puts('  }')
    file.puts('}')
  end
end; end

