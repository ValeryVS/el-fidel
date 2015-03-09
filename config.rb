require 'tempfile'
require 'jekyll'
require 'jekyll-assets'
require 'fileutils'

http_images_path = 'assets'
images_dir = File.join('_assets', 'images')
sprite_load_path = File.join('_assets', 'images')
http_generated_images_path = ''

on_sprite_saved do |filename|
  $site.static_files.push Jekyll::StaticFile.new($site, File.join('_assets', 'images'), '', File.basename(filename))
end
