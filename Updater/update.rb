#!/usr/bin/ruby

=begin
 
update.rb
  ©︎ 2018 YOCKOW.
   Licensed under MIT License.
   See "LICENSE.txt" for more information.
 
=end

# Standard Libraries
require 'csv'
require 'fileutils'
require 'json'
require 'net/https'
require 'open-uri'
require 'pathname'
require 'tmpdir'

# Own
require_relative './modules/extensions.rb'

### CONSTANTS ######################################################################################

FILES = [
  :CFStringEncodings,
  :ContentDispositionParameterKey_IANARegistered,
  :ContentDispositionValue,
  :HTTPHeaderFieldName_IANARegistered,
  :HTTPMethod,
  :HTTPStatusCode,
  :MIMEType_PathExtension,
]

PROJECT_ROOT_DIR = Pathname(File.realpath('..', File.dirname(__FILE__)))
MODULES_DIR = PROJECT_ROOT_DIR + 'Updater/modules'
CONVERTERS_DIR = PROJECT_ROOT_DIR + 'Updater/converters'

OPTIONS = {
  :SKIP => [],
  :FORCE_UPDATE => []
}

#U_TERMS_OF_USE_URL = URI.parse('http://unicode.org/copyright.html')
#U_TERMS_OF_USE = U_TERMS_OF_USE_URL.content.
#                 match(%r{<a\s+name="License">(.+)</a>[\S\s]*<pre>\s*(\S[\S\s]*\S)\s*</pre>})[1,2].
#                 join("\n\n")

SWIFT_KEYWORDS_URL = URI.parse('https://raw.githubusercontent.com/apple/swift/master/utils/gyb_syntax_support/Token.py')
SWIFT_KEYWORD_TYPES = ['DeclKeyword', 'StmtKeyword', 'StmtKeyword', 'Keyword']
SWIFT_KEYWORD_SCRIPT_REGEX = %r{^\s*(?:#{SWIFT_KEYWORD_TYPES.join('|')})\s*\(\s*'[A-Z_a-z]+'\s*,\s*'([A-Z_a-z]+)'}
SWIFT_KEYWORDS = SWIFT_KEYWORDS_URL.to_file.each.
                 map {|line| next $1 if line =~ SWIFT_KEYWORD_SCRIPT_REGEX }.
                 select {|item| item }

## CHECK OPTIONS
argv_index = 0
while true
  break if argv_index + 1 > ARGV.count
  
  key = nil
  arg = ARGV[argv_index]
  
  if arg =~ /\A(?:\-f|\-\-force)\Z/
    key = :FORCE_UPDATE
  elsif arg =~ /\A(?:\-s|\-\-skip)\Z/
    key = :SKIP
  else
    $stderr.puts('Unexpected argument: ' + arg)
  end
  
  if key
    file = ARGV[argv_index + 1]
    if !file || file !~ /\A[0-9A-Z_a-z]+\Z/
      $stderr.puts("\"#{file}\" is invalid as a parameter to specify the file.")
    elsif file =~ /\Aall\Z/i
      file = 'ALL'
    end
    
    file_sym = file.to_sym
    if FILES.include?(file_sym) || file_sym == :ALL
      OPTIONS[key].push(file_sym)
    else
      $stderr.puts("\"#{file}\" is unknown module name.")
    end
    
    argv_index += 2
  else
    argv_index += 1
  end
end

### /CONSTANTS #####################################################################################

### FUNCTIONS ######################################################################################

def failed(message)
  $stderr.puts("!!ERROR!! #{message}")
  exit(false)
end

def converter_module_for(id)
  begin
    module_path = CONVERTERS_DIR + (id.to_s + '.rb')
    require module_path
    return Object.const_get(id)
  rescue LoadError, StandardError => error
    failed(error.to_s)
  end
end

def last_modified_of(urls)
  result = Time.at(0)
  urls.each {|url|
    failed("Non-URI object is given: #{url}") if !url.kind_of?(URI)
    last_modified = url.last_modified
    return nil if !last_modified
    result = last_modified if last_modified > result
  }
  return result
end

def etags_of(urls)
  result = []
  urls.each {|url|
    failed("Non-URI object is given: #{url}") if !url.kind_of?(URI)
    etag = url.etag
    # etag can be nil
    result.push(etag)
  }
  return result
end

### /FUNCTIONS #####################################################################################

#failed("Cannot fetch the Unicode license.") if U_TERMS_OF_USE.length < 1
failed("Cannot fetch the Swift keywords.") if SWIFT_KEYWORDS.count < 1

#### LET'S UPDATE ##################################################################################

FILES.each {|key|
  $stdout.puts()
  
  mod = converter_module_for(key)
  
  rel_path = mod.const_get(:PATH)
  local_path = PROJECT_ROOT_DIR + rel_path
  $stdout.puts("* Path to the local file to be updated: #{rel_path.to_s}")
  
  local_last_modified = nil
  local_etag_list = []
  if FileTest.exist?(local_path)
    # check last-modified date
    File.open(local_path, 'r') {|file|
      file.each {|line|
        if line =~ %r{^\s*//\s*Last\-Modified\s*\:\s*(.+)}i
          local_last_modified = Time.parse($1)
        elsif line =~ %r{^\s*//\s*ETags\s*\:\s*(.+)}i
          local_etag_list = JSON.parse($1)
        elsif line == "\n"
          break
        end
      }
    }
  end
  $stdout.puts("** Last-Modified Date of the local file: #{local_last_modified ? local_last_modified : 'unknown'}")
  if local_etag_list.count > 0
    $stdout.puts("** ETag List of the local file: #{local_etag_list.join(', ')}")
  end
  
  # Check the last modified date of the remote file
  urls = mod.const_get(:URLs)
  remote_last_modified = last_modified_of(urls)
  $stdout.puts("** Last-Modified Date of the remote file: #{remote_last_modified ? remote_last_modified : 'unknown'}")
  
  remote_etag_list = etags_of(urls)
  if remote_etag_list.any?{|etag| etag != nil }
    $stdout.puts("** ETag List of the remote file: #{remote_etag_list.join(', ')}")
  end
  
  remote_is_new = lambda {
    return true if local_last_modified != nil && remote_last_modified != nil && local_last_modified < remote_last_modified
    
    if local_etag_list.count == 0
      return true if local_last_modified == nil || remote_last_modified == nil
      return false if remote_etag_list.all?{|etag| etag == nil }
    else
      return true if local_etag_list.count != remote_etag_list.count
      
      (0..(local_etag_list.count - 1)).each {|ii|
        return true if local_etag_list[ii] != remote_etag_list[ii]
      }
    end
    return false
  }
  
  must_update = (
    OPTIONS[:FORCE_UPDATE].include?(:ALL) ||
    OPTIONS[:FORCE_UPDATE].include?(key) ||
    remote_is_new.call()
  ) ? true : false
  
  should_skip = (
    OPTIONS[:SKIP].include?(key)
  ) ? true : false
  
  if !must_update || should_skip
    $stdout.puts("** The local file is up to date.\n")
    next
  end
  
  backup_path = Pathname(local_path.to_s.sub(/\.[0-9A-Z_a-z]+$/, '~\&'))
  if FileTest.exist?(local_path)
    # create backup file
    FileUtils.cp(local_path, backup_path)
  end
  
  File.open(local_path, 'w+') { |local_file|
    local_file.puts("// DO NOT EDIT THIS FILE MANUALLY.")
    local_file.puts("// This file was created automatically")
    local_file.puts("//   from " + urls.map{|url| url.to_s}.join("\n//        "))
    if remote_last_modified
      local_file.puts("//     Last-Modified: #{remote_last_modified}")
    end
    if remote_etag_list.any?{|etag| etag != nil }
      local_file.puts("//     ETags: #{JSON.generate(remote_etag_list)}")
    end
    local_file.puts()
    
#    local_file.puts("/*\n")
#    U_TERMS_OF_USE.each_line{|line| local_file.puts('  ' + line)}
#    local_file.puts("\n */\n\n")
#    local_file.puts()
    
    # open the remote files
    urls.each { |url|
      remote_file = url.to_file
      $stdout.puts("*** Converting and Writing Data...")
      mod.write(remote_file, local_file)
    }
  }
  
  $stdout.puts("* DONE")
  FileUtils.rm(backup_path) if FileTest.exist?(backup_path)
}
