=begin
 
 BonaFideCharacterSet_UnicodeGeneralCategory.rb
   ©︎ 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end

require File.realpath('./_common_.rb', File.dirname(__FILE__))
require File.realpath('./_swift_common_.rb', File.dirname(__FILE__))
require File.realpath('./_unicode_common_.rb', File.dirname(__FILE__))

module BonaFideCharacterSet_UnicodeGeneralCategory
  PATH = 'Sources/CGIResponder/BonaFideCharacterSet+UnicodeGeneralCategory.swift'
  URLs = [
    URI.parse('https://www.unicode.org/Public/UCD/latest/ucd/extracted/DerivedGeneralCategory.txt')
  ]
  
  extend SWIFT_COMMON
  extend UNICODE_COMMON
  
  def write(file)
    info = {}
    URLs.each {|url|
      $stdout.puts("- Fetching #{url}")
      url.open.each {|line|
        if line =~ /^([0-9A-Fa-f]+(?:\.\.[0-9A-Fa-f]+)?)\s*;\s*([A-Z][a-z])\s*/
          info[$2] = [] if !info[$2]
          info[$2].push($1)
        end
      }
    }
    raise "No data." if info.keys.count < 1
    
    file.puts(head(PATH, URLs))
    file.puts("/*\n")
    unicode_license_agreement().each_line{|line| file.puts('  ' + line)}
    file.puts("\n */\n\n")
    
    names = {
      "Cn" => "unassigned",
      "Lu" => "uppercaseLetter",
      "Ll" => "lowercaseLetter",
      "Lt" => "titlecaseLetter",
      "Lm" => "modifierLetter",
      "Lo" => "otherLetter",
      "Mn" => "nonspacingMark",
      "Me" => "enclosingMark",
      "Mc" => "spacingMark",
      "Nd" => "decimalNumber",
      "Nl" => "letterNumber",
      "No" => "otherNumber",
      "Zs" => "spaceSeparator",
      "Zl" => "lineSeparator",
      "Zp" => "paragraphSeparator",
      "Cc" => "control",
      "Cf" => "format",
      "Co" => "privateUse",
      "Cs" => "surrogate",
      "Pd" => "dashPunctuation",
      "Ps" => "openPunctuation",
      "Pe" => "closePunctuation",
      "Pc" => "connectorPunctuation",
      "Po" => "otherPunctuation",
      "Sm" => "mathSymbol",
      "Sc" => "currencySymbol",
      "Sk" => "modifierSymbol",
      "So" => "otherSymbol",
      "Pi" => "initialPunctuation",
      "Pf" => "finalPunctuation"
    }
    
    file.puts('extension BonaFideCharacterSet {')
    info.keys.each {|category|
      next if category == "Cn" || category == "Cs"
      name = names[category]
      raise "Unknown category: #{category}" if !name
      file.puts("  /// General Category \"#{category}\"")
      file.puts("  internal static let #{name}: BonaFideCharacterSet = ({ () -> BonaFideCharacterSet in")
      file.puts("    var set = BonaFideCharacterSet()")
      info[category].each {|range|
        if range =~ /^[0-9A-Fa-f]+$/
          file.puts("    set.insert(\"\\u{#{range}}\")")
        else
          splitted = range.split(/\.\./)
          file.puts("    set.insert(charactersIn:\"\\u{#{splitted[0]}}\"...\"\\u{#{splitted[1]}}\")")
        end
      }
      file.puts("    return set")
      file.puts("  })()")
    }
    file.puts('}')
  end
  
  module_function :write
end
