require 'fileutils'
require 'rspec'
require "rspec/expectations"

# test command
# rspec --require ./modules/utils.rb spec/

mock_content = """
### I am file content
Stuff I want in the file
"""
RSpec.describe Utils do
  let(:file) { "Title-Of Recipe.md" }
  let(:opath) { "#{__dir__}/#{file}" }
  let(:path) { "#{__dir__}/../.tmp/#{file}" }
  before(:example) do
    FileUtils.cp opath, path
  end
  after(:example) do
    FileUtils.rm path
  end
  describe "#tokenize_content" do
    it "parses content into a struct" do
      title = File.basename(path, ".*")
      data = Utils.tokenize_content(path)
      expect(data[:title]).to eq(title)
      expect(data[:content]).not_to eq('')
      expect(data[:content]).not_to include(title)
      expect(data[:content]).not_to include(data[:background_image])
    end
  end
  describe "#write_post" do
    it "inserts front matter to the top of the file" do
      title = File.basename(path, ".*")
      fm = {
        "title" => title
      }
      content = mock_content
      Utils.write_post(path, content, fm)
      File.open(path, 'r') do |f|
        yml_boundary = 0
        f.each do |line|
          yml_boundary = yml_boundary + 1 if line.include?('---')
        end
        expect(yml_boundary).to eq(2)
      end
    end
  end
end
