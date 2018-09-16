=begin
 
 UnicodeScalar_IDNA.rb
   ©︎ 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end

require File.realpath('./_common_.rb', File.dirname(__FILE__))
require File.realpath('./_swift_common_.rb', File.dirname(__FILE__))
require File.realpath('./_unicode_common_.rb', File.dirname(__FILE__))

module UnicodeScalar_IDNA
  PATH = 'Sources/CGIResponder/UnicodeScalar+IDNA.swift'
  URLs = [
    URI.parse('http://www.unicode.org/Public/idna/latest/IdnaMappingTable.txt')
  ]
  
  extend SWIFT_COMMON
  extend UNICODE_COMMON
  
  def write(file)
    table = []
    URLs.each {|url|
      $stdout.puts("- Fetching #{url}")
      url.open.each {|line|
        next if line =~ /^\s*\#/
        next if line !~ /^[0-9A-Fa-f]+(\.\.[0-9A-Fa-f])?/
        
        line.sub!(%r'\s*#.*$', '')
        table.push(line.split(/\s*;\s*/).map{|item| item.strip})
      }
    }
    raise "No data about IDNA Mapping Table" if table.count < 1
    
    file.puts(head(PATH, URLs))
    file.puts("/*\n")
    unicode_license_agreement().each_line{|line| file.puts('  ' + line)}
    file.puts("\n */\n\n")
    
    arranged_table = {
      :valid_idna2008_disallowed => [],
      :valid => [],
      :ignored => [],
      :mapped => [],
      :deviation => [],
      :disallowed => [],
      :disallowed_std3_valid => [],
      :disallowed_std3_mapped => []
    }
    table.each {|info|
      if info[1] == 'valid'
        if !info[3].nil? && info[3] =~ /^[NX]V8$/
          arranged_table[:valid_idna2008_disallowed].push(info)
        else
          arranged_table[:valid].push(info)
        end
      elsif info[1] == 'ignored'
        arranged_table[:ignored].push(info)
      elsif info[1] == 'mapped'
        arranged_table[:mapped].push(info)
      elsif info[1] == 'deviation'
        arranged_table[:deviation].push(info)
      elsif info[1] == 'disallowed'
        arranged_table[:disallowed].push(info)
      elsif info[1] == 'disallowed_STD3_valid'
        arranged_table[:disallowed_std3_valid].push(info)
      elsif info[1] == 'disallowed_STD3_mapped'
        arranged_table[:disallowed_std3_mapped].push(info)
      end
    }
    
    file.puts(<<-"__UNICODE_SCALAR__IDNA__00__")

extension UnicodeScalar {
  public enum IDNAStatus {
    case valid
    case ignored
    case mapped([UnicodeScalar]?)
    case deviation([UnicodeScalar]?)
    case disallowed
  }
}
    __UNICODE_SCALAR__IDNA__00__
    
    rangeCond = lambda {|range|
      if range =~ /\.\./
        rangeArray = range.split(/\.\./).map{|item| "0x#{item}"}
        return "(#{rangeArray[0]} <= value && value <= #{rangeArray[1]})"
        else
        return "value == 0x#{range}"
      end
    }
    mappingResult = lambda{|scalars|
      return 'nil' if scalars.nil? || scalars.empty?
      return '[' + scalars.split(/\s+/).map{|item| "UnicodeScalar(0x#{item})!" }.join(', ') + ']'
    }
    
    file.puts('extension UnicodeScalar {')
    
    # :valid_idna2008_disallowed
    file.puts('  fileprivate var isValidButDisallowedInIDNA2008: Bool {')
    file.puts('    let value: UInt32 = self.value')
    arranged_table[:valid_idna2008_disallowed].each{|info|
      file.puts("    if #{rangeCond.call(info[0])} { return true }")
    }
    file.puts('    return false')
    file.puts('  }')
    
    # :valid
    file.puts('  fileprivate var isValid: Bool {')
    file.puts('    let value: UInt32 = self.value')
    arranged_table[:valid].each{|info|
      file.puts("    if #{rangeCond.call(info[0])} { return true }")
    }
    file.puts('    return false')
    file.puts('  }')
    
    # :ignored
    file.puts('  fileprivate var isIgnored: Bool {')
    file.puts('    let value: UInt32 = self.value')
    arranged_table[:ignored].each{|info|
      file.puts("    if #{rangeCond.call(info[0])} { return true }")
    }
    file.puts('    return false')
    file.puts('  }')
    
    # :disallowed
    file.puts('  fileprivate var isDisallowed: Bool {')
    file.puts('    let value: UInt32 = self.value')
    arranged_table[:disallowed].each{|info|
      file.puts("    if #{rangeCond.call(info[0])} { return true }")
    }
    file.puts('    return false')
    file.puts('  }')
    
    # :disallowed_std3_valid
    file.puts('  fileprivate var isDisallowedButValidUsingSTD3ASCIIRules: Bool {')
    file.puts('    let value: UInt32 = self.value')
    arranged_table[:disallowed_std3_valid].each{|info|
      file.puts("    if #{rangeCond.call(info[0])} { return true }")
    }
    file.puts('    return false')
    file.puts('  }')
    
    # :mapped
    file.puts('  fileprivate var isMapped: (Bool, to:[UnicodeScalar]?) {')
    file.puts('    let value: UInt32 = self.value')
    arranged_table[:mapped].each{|info|
      cond = rangeCond.call(info[0])
      scalars = mappingResult.call(info[2])
      file.puts("    if #{cond} { return (true, to:#{scalars}) }")
    }
    file.puts('    return (false, to:nil)')
    file.puts('  }')
    
    # :deviation
    file.puts('  fileprivate var isDeviation: (Bool, to:[UnicodeScalar]?) {')
    file.puts('    let value: UInt32 = self.value')
    arranged_table[:deviation].each{|info|
      cond = rangeCond.call(info[0])
      scalars = mappingResult.call(info[2])
      file.puts("    if #{cond} { return (true, to:#{scalars}) }")
    }
    file.puts('    return (false, to:nil)')
    file.puts('  }')
    
    # :disallowed_std3_mapped
    file.puts('  fileprivate var isDisallowedButMappedUsingSTD3ASCIIRules: (Bool, to:[UnicodeScalar]?) {')
    file.puts('    let value: UInt32 = self.value')
    arranged_table[:disallowed_std3_mapped].each{|info|
      cond = rangeCond.call(info[0])
      scalars = mappingResult.call(info[2])
      file.puts("    if #{cond} { return (true, to:#{scalars}) }")
    }
    file.puts('    return (false, to:nil)')
    file.puts('  }')
    
    file.puts('}')
    
    file.puts(<<-"__UNICODE_SCALAR__IDNA__01__")

extension UnicodeScalar {
  public func idnaStatus(usingSTD3ASCIIRules std3:Bool = true, idna2008Compatible idna2008:Bool = false) -> UnicodeScalar.IDNAStatus? {
    if self.isValidButDisallowedInIDNA2008 {
      if idna2008 { return .disallowed }
      return .valid
    }
    if self.isValid { return .valid }
    if self.isIgnored { return .ignored }
    if self.isDisallowed { return .disallowed }
    if self.isDisallowedButValidUsingSTD3ASCIIRules {
      if std3 { return .valid }
      return .disallowed
    }
    switch self.isMapped {
      case (true, let scalars): return .mapped(scalars)
      default: break
    }
    switch self.isDeviation {
      case (true, let scalars): return .deviation(scalars)
      default: break
    }
    switch self.isDisallowedButMappedUsingSTD3ASCIIRules {
      case (true, let scalars):
        if std3 { return .mapped(scalars) }
        return .disallowed
      default: break
    }
    return nil
  }
}
    __UNICODE_SCALAR__IDNA__01__
    
  end
  module_function :write
end
