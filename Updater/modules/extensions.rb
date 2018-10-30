=begin
 
extensions.rb
  ©︎ 2018 YOCKOW.
   Licensed under MIT License.
   See "LICENSE.txt" for more information.
 
=end

require 'open-uri'
require 'tempfile'


module IO_CSV_
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
class IO; include IO_CSV_; end
class StringIO; include IO_CSV_; end

class String
  protected
  
  def _split_for_camel_case
    words = self.gsub(/(?:\-|_|(?<=[a-z])(?=[A-Z]))/, ' ').split(/\s+/)
    if words[0] =~ /^([A-Z]+)([A-Z][0-9a-z]+)$/
      words.shift
      words.unshift($1, $2)
    end
    return words
  end
  
  public
  
  def to_lower_camel_case
    return self._split_for_camel_case.map.with_index {|word, index|
      next word.downcase if index == 0
      next word if word =~ /\A[A-Z]+\Z/
      next word.capitalize
    }.join('')
  end
  
  def to_upper_camel_case
    return self._split_for_camel_case.map.with_index {|word, index|
      next word if word =~ /\A[A-Z]+\Z/
      next word.capitalize
    }.join('')
  end
  
  def reserved_by_swift?
    return (SWIFT_KEYWORDS.include?(self)) ? true : false
  end
  
  def to_swift_identifier
    lcc = self.to_lower_camel_case
    return self.reserved_by_swift? ? "`#{lcc}`" : lcc
  end
end

module URI
  TMP_DIR = Dir.mktmpdir()
  @@downloaded_files = {}
  
  public
  
  def to_hash
    return self
  end
  
  def to_file
    if !@@downloaded_files[self]
      $stdout.puts("-- Fetching #{self.to_s}")
      tmp = Tempfile.new('', TMP_DIR)
      self.open {|remote_file|
        tmp.write(remote_file.read)
      }
      @@downloaded_files[self] = tmp
    end
    @@downloaded_files[self].close
    return @@downloaded_files[self].open
  end
  
  def content
    return self.to_file.read
  end
  
  def last_modified
    trial = 0
    redirected = self
    last_modified_string = nil
    
    while true
      failed("Many redirections: #{url.to_s}") if trial > 10
      
      https = Net::HTTP.new(redirected.host, redirected.port)
      https.use_ssl = true
      header = https.head(redirected.path)
      
      if header['location']
        redirected = URI.parse(header['location'])
        trial += 1
      else
        last_modified_string = header['last-modified']
        break
      end
    end
    
    return nil if !last_modified_string
    return Time.parse(last_modified_string)
  end
end
