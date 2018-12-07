=begin
 
 MIMEType_PathExtension.rb
   ©︎ 2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end

require 'set'

module MIMEType_PathExtension
  PATH = 'Sources/Supporters/HTTP/MIMEType+PathExtension.swift'
  URLs = [
    URI.parse('https://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types'),
  ]
end

class MIMEType_
  RE_STR_TYPE = "(application|audio|example|font|image|message|model|multipart|text|video|chemical)"
  RE_STR_TREE = "(vnd|prs|x)"
  RE_STR_SUBTYPE = "([\+\-\.0-9A-Za-z]+?)"
  RE_STR_SUFFIX = "(xml|json|ber|der|fastinfoset|wbxml|zip|cbor)"
  MIME_TYPE_REGEX = %r{^#{RE_STR_TYPE}/(?:#{RE_STR_TREE}\.)?#{RE_STR_SUBTYPE}(?:\+#{RE_STR_SUFFIX})?$}i
  
  attr_reader :type, :tree, :subtype, :suffix
  def initialize(type, tree, subtype, suffix)
    @type = type
    @tree = tree
    @subtype = subtype
    @suffix = suffix
  end
  
  def self.parse(string)
    if string =~ MIME_TYPE_REGEX
      return MIMEType_.new($1, $2, $3, $4)
    else
      return nil
    end
  end

  def to_swift_mimetype_core_string
    type_string = ".#{@type}"
    tree_string = @tree.nil? ? "nil" : ".#{@tree}"
    subtype_string = "\"#{@subtype}\""
    suffix_string = @suffix.nil? ? "nil" : ".#{@suffix}"
    return "MIMEType._Core(type:#{type_string},tree:#{tree_string},subtype:#{subtype_string},suffix:#{suffix_string})"
  end
end

module MIMEType_PathExtension; class << self
  def write(remote_io, file)
    all_extensions = Set.new()
    type_to_ext_list = []
    ext_to_type_table = {}
    
    remote_io.each {|line|
      next if line =~ /^\s*\u0023/
      
      mime_type_string, *extensions = line.split(/\s+/)
      mime_type = MIMEType_.parse(mime_type_string)
      if !mime_type
        $stderr.puts("--- Skipped: #{line}")
      else
        all_extensions.merge(extensions)
        type_to_ext_list.push([mime_type, extensions])
        extensions.each{|ext| ext_to_type_table[ext] = mime_type }
      end
    }
    
    ## EXTENSIONS
    file.puts("extension MIMEType {")
    file.puts("  public enum PathExtension: String {")
    all_extensions.each {|ext|
      file.puts("    case #{ext.to_swift_identifier} = \"#{ext}\"")
    }
    file.puts("  }")
    file.puts("}")
    file.puts()
    
    get_ext_identifier = lambda {|ext|
      return '.' + ext.to_swift_identifier.gsub('`', '')
    }
    
    ## TYPE -> EXT
    file.puts("internal let _mimeType_to_ext:[MIMEType._Core:Set<MIMEType.PathExtension>] = [")
    type_to_ext_list.each {|info|
      ext_set_string = '[' + info[1].map{|ext| get_ext_identifier.call(ext) }.join(',') + ']'
      file.puts("  #{info[0].to_swift_mimetype_core_string}:#{ext_set_string},")
    }
    file.puts("]")
    file.puts()
    
    ## EXT -> TYPE
    file.puts("internal let _ext_to_mimeType:[MIMEType.PathExtension:MIMEType._Core] = [")
    ext_to_type_table.each_pair {|ext, mime_type|
      file.puts("  #{get_ext_identifier.call(ext)}:#{mime_type.to_swift_mimetype_core_string},")
    }
    file.puts("]")
  end
end; end

