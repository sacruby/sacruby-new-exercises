class Template

  attr_reader :content
  attr_reader :vars

  def self.find( name )
    filename = "templates/#{ name }.tp"
    if File.exist?( filename )
      content = IO.read( filename )
      return self.new( content )
    else
      raise "Couldn't find template named #{ name }"
    end
  end

  def self.list
    Dir.entries('templates').select {|filename|
      filename.end_with?('.tp')
    }.map {|filename|
      filename.sub( /\.tp\z/, '' )
    }
  end

  def initialize( content )
    @content = content
    @vars = @content.scan( /(?<=\*\|)\w+(?=\|\*)/ ).uniq
  end

  def fill_vars( var_values )
    content_copy = @content.clone
    var_values.each do |var_name, value|
      content_copy.gsub!("*|#{var_name}|*", value)
    end
    return content_copy
  end

end
