#!/usr/bin/ruby

=begin
 
update-sources.rb
  ©︎ 2017 YOCKOW.
   Licensed under MIT License.
   See "LICENSE.txt" for more information.
 
=end

require 'fileutils'
require 'optparse'

$ROOT = File.realpath('..', File.dirname(__FILE__))

Files = [
  :SwiftKeywords,
  :UnicodeLicenseAgreement,
#  :BonaFideCharacterSet_UnicodeGeneralCategory,
#  :ContentDispositionParameterKey,
#  :ContentDispositionValue,
  :HTTPHeaderFieldName_IANARegistered,
#  :HTTPMethod,
  :HTTPStatusCode,
  :MIMEType_PathExtension,
  :PublicSuffix,
  :UnicodeScalar_IDNA
]

Targets = {}
Files.each{|key| Targets[key] = true}

def failed(message)
  $stderr.puts("!!ERROR!! #{message}")
  exit(false)
end

OptionParser.new(__FILE__){|parser|
  parser.on('--all', 'Update all source files. [Default:ON]')
  parser.on('--only=COMMA_SEPARATED_FILENAMES',
            'Specify which files to be updated using a safelist') {|list|
    Targets.each_key{|kk| Targets[kk] = false}
    list.split(/,/).each{|filename|
      key = filename.sub(/\.(?:rb|swift)$/i, '').gsub(/[\+\-\.]/, '_').to_sym
      failed("Unknown file: #{filename}") if !Targets.has_key?(key)
      Targets[key] = true
    }
  }
  parser.on('--except=COMMA_SEPARATED_FILENAMES',
            'Specify which files to exclude from updating using a blocklist') {|list|
    list.split(/,/).each{|filename|
      key = filename.sub(/\.(?:rb|swift)$/i, '').gsub(/[\+\-\.]/, '_').to_sym
      failed("Unknown file: #{filename}") if !Targets.has_key?(key)
      Targets[key] = false
    }
  }
  begin
    parser.parse!(ARGV)
  rescue OptionParser::ParseError => ee
    failed(ee.message + "\n" + parser.help)
  end
}

Targets[:SwiftKeywords] = true
Targets[:UnicodeLicenseAgreement] = true

Files.each{|key|
  if !Targets[key]
    $stdout.puts("Skip updating: '#{key.to_s}'")
    next
  end
  
  begin
    require File.realpath('./', File.dirname(__FILE__)) + "/#{File.basename(__FILE__, '.*')}.modules/#{key.to_s}.rb"
    mod = Object.const_get(key)
    path = File.expand_path(mod.const_get(:PATH), $ROOT)
    
    $stdout.puts("Updating '#{File.basename(path)}'")
    
    backup_path = path.sub(/\.[0-9A-Z_a-z]+$/, '~\&')
    if FileTest.exist?(path)
      FileUtils.cp(path, backup_path)
    end
    
    file = File.open(path, 'w')
    mod.write(file)
    file.close
    
    FileUtils.rm(backup_path) if FileTest.exist?(backup_path)
    
    $stdout.puts('- done.')
  rescue LoadError, StandardError => ee
    failed(ee.to_s)
  end
}
