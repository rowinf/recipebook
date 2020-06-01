require 'fileutils'
require 'pathname'
require 'rake'
require 'rake/clean'
require 'yaml'

directory '.tmp'
directory 'assets'
directory '_posts'
ia_recipes = FileList.new("/Users/rob/Dropbox/iawriter\\ dropbox/recipes/*.md")

CLEAN.include(".tmp/*")

ia_recipes.each do |src|
  f = File.new(src)
  title = File.basename(f, ".*")
  created_at = f.birthtime.strftime('%Y-%m-%d')
  modified_at = f.mtime.strftime('%Y-%m-%d')
  slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  post_filename = "#{created_at}-#{slug}.md"
  target = File.join('.tmp', post_filename)
  dest = File.join('_posts', post_filename)
  data = {
    "layout" => 'post',
    "title" => title
  }
  file target => src do
    cp src, target
    insert_frontmatter(target, data)
  end
  file dest => target do
    cp target, dest
  end
  task :import_recipes => target
  task :create_output => dest
end

task :default => ['.tmp', :import_recipes, '_posts', :create_output]

def insert_frontmatter(target, data)
  content = "#{data.to_yaml}---\n"
  File.open(target, 'r') do |temp|
    temp.each do |line|
      content << line
    end
  end
  content.gsub!(/^#[\s\w]+\n+/, '')
  File.open(target, 'w') do |f|
    f.write(content)
  end
end

