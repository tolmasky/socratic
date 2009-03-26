=begin
require 'rexml/document'
include REXML

Sources = Document.new
Sources.add_element('Sources')
=end

require 'rubygems'
require 'textpow'

class Socratic

    class Language
        @@languages = nil
        def initialize(syntax_node)
            @syntax_node = syntax_node
        end
        
        def name
            return @syntax_node.name
        end
        
        def Language.language_for_file file_name
    
        load_languages unless @@languages
        first_line = nil
        
        @@languages.each do |key, value|
            if value.fileTypes
                value.fileTypes.each do |t|
                    if t == File.basename(file_name) || t == File.extname(file_name)[1..-1]
                        return value
                    end
                end
            end
         
            unless first_line
                File.open(file_name, 'r') do |file|
                    while (first_line = file.readline).strip.size == 0; end
                end
            end
            
            if value.firstLineMatch && value.firstLineMatch =~ first_line
               return value 
            end
        end
        
        return nil
    end

    private
    
        def Language.load_languages
        
            @@languages = {}
            
            language_files.each do |file|
                @@languages[File.basename(file, '.tmSyntax')] = Language.new(Textpow::SyntaxNode.load(file))
            end
        end
        
        def Language.language_files
        puts Dir.glob(File.join(File.dirname(__FILE__), '..', '..', 'data', 'languages', '*.tmSyntax')).to_s
            Dir.glob(File.join(File.dirname(__FILE__), '..', '..', 'data', 'languages', '*.tmSyntax'))
        end
    end
end