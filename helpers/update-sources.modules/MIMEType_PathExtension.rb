=begin
 
 MIMEType_PathExtension.rb
   ©︎ 2017 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 
=end

require File.realpath('./_common_.rb', File.dirname(__FILE__))
require File.realpath('./_swift_common_.rb', File.dirname(__FILE__))

module MIMEType_PathExtension
  PATH = 'Sources/CGIResponder/MIMEType+PathExtension.swift'
  URLs = [
    URI.parse('http://svn.apache.org/repos/asf/httpd/httpd/trunk/docs/conf/mime.types')
  ]
  
  extend SWIFT_COMMON
  
  def write(file)
    typeToExt = {}
    extToType = []
    listOfExtensions = []
    
    re_toplevel = '(application|audio|example|font|image|message|model|multipart|text|video|chemical)'
    re_tree     = '(vnd|prs|x)'
    re_suffix   = '(xml|json|ber|der|fastinfoset|wbxml|zip|cbor)'
    
    URLs.each {|url|
      $stdout.puts("- Fetching #{url}")
      url.open.each {|line|
        next if line =~ /^\s*\#/
        line.gsub!(/\#.*$/, '')
        mime_type, *extensions = line.split(/\s+/)
        
        type = nil
        tree = nil
        subtype = nil
        suffix = nil
                   
        original_mime_type = "#{mime_type}"
        
        if !(mime_type.gsub!(%r{^#{re_toplevel}/}) {|ww| type = $1; ''})
          $stderr.puts("-- skipped '#{original_mime_type}'")
          next
        end
        
        mime_type.gsub!(%r{\+#{re_suffix}$}) {|ww| suffix = $1; '' }
        mime_type.gsub!(%r{^#{re_tree}\.}) {|ww| tree = $1; ''}
        subtype = "#{mime_type}"
        
        mime_type = "#{original_mime_type}"
        
        if !subtype
          $stderr.puts("-- skipped '#{origninal_mime_type}'")
          next
        end

        tree_key = tree.nil? ? '__nil__' : tree
        suffix_key = suffix.nil? ? '__nil__' : suffix
        typeToExt[type] = {} if !typeToExt.has_key?(type)
        typeToExt[type][tree_key] = {} if !typeToExt[type].has_key?(tree_key)
        typeToExt[type][tree_key][subtype] = {} if !typeToExt[type][tree_key].has_key?(subtype)
        typeToExt[type][tree_key][subtype][suffix_key] = [] if !typeToExt[type][tree_key][subtype].has_key?(suffix_key)
        
        extensions_keywords = extensions.map{|ext| ext.gsub(/^[0-9]/, '_\&').gsub(/\-/, '_') }

                   
        typeToExt[type][tree_key][subtype][suffix_key].concat(extensions_keywords)
                   
        extensions.each_index {|ii|
          next if listOfExtensions.include?(extensions[ii])
          listOfExtensions.push(extensions[ii])
                   
          extToType.push([extensions[ii],
                         extensions_keywords[ii],
                         {:type => type,
                          :tree => tree,
                          :subtype => subtype,
                          :suffix => suffix}
                        ])
        }
      }
    }
    raise "No data about MIME Types" if extToType.count < 1
    
    file.puts(head(PATH, URLs))
                   
    file.puts('extension MIMEType {')
    
    file.puts('  public enum PathExtension: String {')
    extToType.each{|info|
      file.write('    case ')
      file.write((info[1].reserved?) ? "`#{info[1]}`" : "#{info[1]}")
      file.puts(" = \"#{info[0]}\"")
    }
    file.puts('  }')
                   
    file.puts('  public init?(pathExtension:PathExtension, parameters:[String:String]? = nil) {')
    file.puts('    switch pathExtension {')

    cases = []
    typeToExt.each_key {|type|
      typeToExt[type].each_key {|tree|
        typeToExt[type][tree].each_key {|subtype|
          typeToExt[type][tree][subtype].each_key {|suffix|
            keywords = typeToExt[type][tree][subtype][suffix]
            keywords = keywords.select{|kk| !cases.include?(kk)}
            next if keywords.size < 1
            file.puts("    case " + keywords.map{|kk| ".#{kk}"}.join(', ') + ':')
            file.write('      self.init(')
            file.write("type:.#{type}, ")
            file.write('tree:' + (tree == '__nil__' ? 'nil' : ".#{tree}") + ', ')
            file.write("subtype:\"#{subtype}\", ")
            file.write('suffix:' + (suffix == '__nil__' ? 'nil' : ".#{suffix}") + ', ')
            file.write('parameters:parameters')
            file.puts(')')
            keywords.each{|kk| cases.push(kk)}
          }
        }
      }
    }
    file.puts('    // default: return nil // default will never be executed')
    file.puts('    }')
    file.puts('  }')
    
    file.puts('  public var pathExtensions: [PathExtension]? {')
    file.puts('    switch (self.type, self.tree, self.subtype, self.suffix) {')
    typeToExt.each_key {|type|
      typeToExt[type].each_key {|tree|
        typeToExt[type][tree].each_key {|subtype|
          typeToExt[type][tree][subtype].each_key {|suffix|
            keywords = typeToExt[type][tree][subtype][suffix]
            file.write("    case (.#{type}, ")
            file.write((tree == '__nil__' ? 'nil' : ".some(.#{tree})") + ', ')
            file.write("\"#{subtype}\", ")
            file.puts((suffix == '__nil__' ? 'nil' : ".some(.#{suffix})") + '):')
            file.write('      return [')
            file.write(keywords.map{|kk| ".#{kk}"}.join(', '))
            file.puts(']')
          }
        }
      }
    }
    file.puts('    default: return nil')
    file.puts('    }')
    file.puts('  }')

    file.puts('}')
  end
  module_function :write
end
