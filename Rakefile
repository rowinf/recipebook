require 'fileutils'
require 'pathname'
require 'rake'
require 'rake/clean'
require './modules/utils'

directory '.tmp'
directory 'docs/assets'
directory 'docs/assets/images'
directory 'docs/_posts'
ia_recipes = FileList.new(ENV["RECIPES_PATH"] + "*.md")

CLEAN.include(".tmp/*")

ia_recipes.each do |src|
  f = File.new(src)
  title = File.basename(f, ".*")
  slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  created_at = f.birthtime.strftime('%Y-%m-%d')
  post_filename = "#{created_at}-#{slug}.md"
  target = File.join('.tmp', post_filename)
  dest = File.join('docs/_posts', post_filename)
  file target => src do
    cp src, target
    data = Utils.tokenize_content(target)
    image = data[:background_image]
    fm = {
      "layout" => 'post',
      "title" => data[:title]
    }
    if image
      fm["background_image"] = "/assets/images#{data[:background_image]}"
    end
    Utils.write_post(target, data[:content], fm)
  end
  file dest => target do
    cp target, dest
  end
  task :import_recipes => target
  task :create_output => dest
end

task :default => ['.tmp', :import_recipes, 'docs/_posts', :create_output]
