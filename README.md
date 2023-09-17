# Recipe book

[view site](https://rowinf.github.io/recipebook/)

Converts some Markdown files I wrote in IA Writer into a jekyll page so I can reference anywhere when I'm thinking about when to cook and I can share if needed.

I've tried to include the source for each recipe, each came from a great resource.

`$ rake` will rebuild the recipes from the given file blob. I use a separate markdown editor IA Writer to edit the recipes.

Changes to master will be automatically deployed to github pages

Some utilities were written to help parse the content from IA writer. The command to run tests:

`$ rspec --require ./modules/utils.rb spec/`
