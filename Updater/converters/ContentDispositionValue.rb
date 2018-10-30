=begin
 
 ContentDispositionValue.rb
   ©︎ 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end


module ContentDispositionValue
  PATH = 'Sources/Supporters/HTTP/ContentDispositionValue.swift'
  URLs = [
    URI.parse('https://www.iana.org/assignments/cont-disp/cont-disp-1.csv')
  ]
end
  
module ContentDispositionValue; class << self
  def write(remote_io, file)
    values = []
    remote_io.parse_csv {|row|
      next if row[0] !~ /^[\-a-z]+$/
      values.push(row[0])
    }
    raise "No data about Cotent Dispocition Values" if values.count < 1
    
    _TYPE_NAME = "ContentDispositionValue"
    
    file.puts('/// Represents Content Disposition Value aka "disposition type".')
    file.puts('public enum ContentDispositionValue: String {')
    values.each {|value|
      file.puts("  case #{value.to_swift_identifier} = \"#{value}\"")
    }
    file.puts('  public init(rawValue:String) {')
    file.puts('    switch rawValue.lowercased() {')
    values.each {|value|
      file.puts("    case \"#{value}\": self = .#{value.to_lower_camel_case}")
    }
    file.puts('    default: self = .attachment')
    file.puts('    }')
    file.puts('  }')
    file.puts('}')
  end
end; end

