
# Add the directory containing this file to the start of the load path if it
# isn't there already.
$:.push(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'xml'

require 'socratic/parser'

class Socratic

    VERSION = '1.0.0'
  
    def Socratic.load_files(file_names)
    
        @document = XML::Document.new
        @document.root = XML::Node.new('sources')
        
        file_names.each do |file_name|
            puts file_name
            @document.root << Parser.parse_file(file_name)
        end
    end

end
