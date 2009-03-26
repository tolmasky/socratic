def require_gem_with_feedback(gem)
  begin
    require gem
  rescue LoadError
    puts "You need to 'sudo gem install #{gem}' before we can proceed"
  end
end

class String
  def wiki_linked
    self.gsub!(/\b((?:[A-Z]\w+){2,})/) { |m| "<a href=\"/#{m}\">#{m}</a>" }
    self.gsub!(/\[(\w+){2,}\]/) { |m| 
      m.gsub!(/(\[|\])/, '')
      "<a href=\"/#{m}\">#{m}</a>" 
    }
    self
  end
end

class Time
  def for_time_ago_in_words
    "#{(self.to_i * 1000)}"
  end
end
