=begin
 
 HTTPMethod.rb
   ©︎ 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end


module HTTPMethod
  PATH = 'Sources/Supporters/HTTP/Method.swift'
  URLs = [
    URI.parse('https://www.iana.org/assignments/http-methods/methods.csv')
  ]
end
  
module HTTPMethod; class << self
  def write(remote_io, file)
    methods = []
    remote_io.parse_csv {|row|
      next if row[0] !~ /^[\-A-Za-z]+$/
      methods.push(row[0])
    }
    raise "No data about HTTP Methods" if methods.count < 1
    
    _TYPE_NAME = "Method"
    
    file.puts("public enum #{_TYPE_NAME}: String {")
    methods.each {|method|
      swift_id = method.split(/[^A-Za-z]/).map{|m| m.capitalize}.join(' ').to_swift_identifier
      file.puts("  case #{swift_id} = \"#{method}\"")
    }
    file.puts('}')
  end
end; end

