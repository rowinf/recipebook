require 'fileutils'
require 'pathname'
require 'rake'
require 'rake/clean'
require './modules/utils'

directory '.tmp'
directory 'docs/assets'
directory 'docs/assets/images'
directory 'docs/_posts'

=begin
define rake tasks for copying a collection of files to be the content for this blog.
metadata from the source files is used to generate the title and dates.
rake is used because 'file' tasks automatically detect changes.
=end
def define_tasks
  CLEAN.include(".tmp/*")
  FileList[ENV["RECIPES"]].each do |src|
    f = File.new(src)
    title = File.basename(f, ".*")
    slug = title.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    created_at = f.birthtime.strftime('%Y-%m-%d')
    post_filename = "#{created_at}-#{slug}.md"
    target = File.join('.tmp', post_filename)
    dest = File.join('docs/_posts', post_filename)
    desc "file task #{src} -> #{target}
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
    desc "copy #{target} -> #{dest} "
    file dest => target do
      cp target, dest
    end
    desc "import_recipes for #{target}"
    task :import_recipes => target
    desc "create_output for #{dest}"
    task :create_output => dest
  end
end

define_tasks

desc "import_recipes: a glob of files become the blog posts for this jekyll site"
task :default => ['.tmp', :import_recipes, 'docs/_posts', :create_output]
