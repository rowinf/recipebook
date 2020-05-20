require 'fileutils'
require 'pathname'
require 'rake'
require 'rake/clean'

directory '.tmp'
directory 'assets'
directory '_recipes'
ia_recipes = FileList.new("/Users/rob/Dropbox/iawriter\\ dropbox/recipes/*.md")

CLEAN.include(".tmp/*")

ia_recipes.each do |src|
  target = File.join('.tmp', File.basename(src))
  dest = File.join('_recipes', File.basename(src))
  file target => src do
    cp src, target
    insert_frontmatter(target)
  end
  file dest => target do
    cp target, dest
  end
  task :import_recipes => target
  task :create_output => dest
end

task :default => ['.tmp', :import_recipes, '_recipes', :create_output]

def insert_frontmatter(target)
  template =
"""---
title: %s
layout: post
---
"""
  name = File.basename(target, ".*")
  content = template % [name]
  File.open(target, 'r') do |temp|
    title = false
    temp.each do |line|
      content << line
    end
  end
  content.gsub!(/^#[\s\w]+\n+/, '')
  File.open(target, 'w') do |f|
    f.write(content)
  end
end

