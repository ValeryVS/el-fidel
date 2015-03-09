require 'uglifier'
require 'sprockets'
require 'sass'
require 'compass'

compass_config = File.expand_path(File.join('..', '..', 'config.rb'), __FILE__)
puts File.join('..', '..', 'config.rb', __FILE__).inspect
Compass.add_project_configuration(compass_config)
Compass.discover_extensions!

require 'sprockets-helpers'
require 'jekyll-assets'

module Jekyll
  module AssetsPlugin
    class Environment < Sprockets::Environment
      def self.instance; return @instance; end
      def self.instance=(val); @instance = val; end
      alias_method :original_initialize, :initialize
      def initialize site
        original_initialize(site)
        self.class.instance = self
      end
    end
  end
end

require 'jekyll-assets/compass'
    
class CleanupGenerator < Jekyll::Generator
  priority :lowest
  def generate(site)
    $site = site
    if File.exists?(File.join('_assets', 'images'))
      Dir[File.join('_assets', 'images' ,'*.png')].each do |filename|
        $site.static_files.push Jekyll::StaticFile.new($site, File.join('_assets', 'images'), '', File.basename(filename))
      end
    end
  end
end