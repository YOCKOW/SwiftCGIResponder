=begin
 
 _common_.rb
   ©︎ 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end

require 'csv'
require 'open-uri'

module URI
  def parse_csv(options = Hash.new)
    string = self.read
    
    if block_given?
      CSV.parse(string, options) {|row|
        yield(row)
      }
    else
      return CSV.parse(string, options)
    end
  end
end
