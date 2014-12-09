require_relative 'spec_helper'

describe Template do
  after do
    Dir.entries('templates').reject {|filename|
      filename.start_with?('.')
    }.each do |filename|
      File.delete("templates/#{filename}")
    end
  end

  describe '::find' do
    before do
      @template_name = 'password_reset'
      @content = "Please reset your password with the following link: *|reset_url|*\n"
      @filepath = "templates/#{@template_name}.tp"
      File.open(@filepath, 'w') {|file| file.puts @content}
    end

    it "initializes a Template instance if corresponding file is found" do
      Template.find(@template_name).must_be_instance_of Template
    end

    it "initializes a Template with the content found in the file" do
      Template.find(@template_name).content.must_equal(@content)
    end
  end

  describe '::list' do
    before do
      (1..2).each {|n| File.open("templates/template_#{n}.tp", 'w')}
      File.open('templates/not_a_template.pt', 'w')
    end

    it "returns an array of filenames ending in '.tp' found in 'templates'" do
      Template.list.must_equal(['template_1','template_2'])
    end
  end

  describe '#vars' do
    it "returns an array of vars found in the template's content" do
      content = "Thanks for becoming a backer of *|project_name|* by *|creator_name|*."
      template = Template.new(content)
      template.vars.must_equal(['project_name','creator_name'])
    end
  end

  describe '#fill_vars' do
    before do
      @template = Template.new("Happy birthday, *|name|*!")
    end

    it "returns its content with vars replaced by values in hash" do
      @template.fill_vars({'name' => 'Ruby'}).must_equal("Happy birthday, Ruby!")
    end

    it "doesn't alter its original content" do
      @template.fill_vars({'name' => 'Perl'})
      @template.content.must_equal("Happy birthday, *|name|*!")
    end
  end
end
