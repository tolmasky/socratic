#!/usr/bin/env ruby

require 'xml'


class Processor

    attr_accessor :root;
    
    def initialize
    end
    
    def open_tag name, position
    
         @node_stack.last << @line[@position...position] if position > @position
        
        node = XML::Node.new(name)
        
        @node_stack.last << node
        @node_stack << node
            
        @position = position
    end

    def close_tag name, position

        @node_stack.last << @line[@position...position] if position > @position
        
        @node_stack.pop
        @position = position
    end

    def new_line line

        @node_stack.last << @line[@position..-1] if @line
        
        @position = 0
        @line = line
    end

    def start_parsing name
    
        @node_stack = []
        @position = 0
        @line = nil
        
        @root = XML::Node.new(name)

        @node_stack << @root
    end

    def end_parsing name
        @root
    end

end
