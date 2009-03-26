#!/usr/bin/env ruby

require 'rubygems'
require 'textpow'
require 'socratic/processor'


class Socratic

    class Parser
        
        @@syntaxes = nil
        @@processor = nil
        
        def Parser.syntax_for_file file_name
    
            load_bundles unless @@syntaxes
            first_line = nil
            
            @@syntaxes.each do |key, value|
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
    
        def Parser.parse_file file_name
        
            @@processor = Processor.new unless @@processor
            
            File.open(file_name) do |file|
                syntax_for_file(file_name).parse(file.read, @@processor)
            end
            
            @@processor.root
        end

    private
    
        def Parser.load_bundles
        
            @@syntaxes = {}
            
            bundles.each do |file|
                @@syntaxes[File.basename(file, '.tmSyntax')] = Textpow::SyntaxNode.load(file)
            end
        end
        
        def Parser.bundles
            Dir.glob(File.join(File.dirname(__FILE__), '..', '..', 'data', 'bundles', '*.tmSyntax'))
        end
    end
end
