=begin
 
 _swift_common_.rb
   ©︎ 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end

require 'date'
require 'yaml'

module SWIFT_COMMON
  def head(filename, urls)
    hh = "/***************************************************************************************************\n"
    hh += " #{File.basename(filename)}\n"
    hh += "   This file was created automatically\n"
    hh += "   from " + urls.join("\n        ") + "\n"
    hh += "   at " + DateTime.now.to_s + "\n"
    hh += " **************************************************************************************************/\n"
    hh += "\n"
    return hh
  end
end

class String
  def to_keyword
    words = self.gsub(/(?:\-|(?<=[a-z])(?=[A-Z]))/, ' ').split(/\s+/)
    if words[0] =~ /^([A-Z]+)([A-Z][0-9a-z]+)$/
      words.shift
      words.unshift($1, $2)
    end
    return words.map.with_index{|ww,ii|
      if ii == 0
        ww.downcase
      elsif ww !~ /^[A-Z]+$/
        ww.capitalize
      else
        ww
      end
    }.join('')
  end
  
  @@swift_reserved_keywords = nil
  def reserved?
    if !@@swift_reserved_keywords
      require File.realpath('./SwiftKeywords.rb', File.dirname(__FILE__))
      filename = (($ROOT) ? $ROOT : File.realpath('../..', File.dirname(__FILE__))) + "/#{SwiftKeywords.const_get(:PATH)}"
      File.open(filename) {|file| @@swift_reserved_keywords = YAML.load(file.read)}
    end
    return (@@swift_reserved_keywords.include?(self)) ? true : false
  end
end
