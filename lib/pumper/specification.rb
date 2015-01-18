require 'delegate'
module Pumper
  class Specification < SimpleDelegator
    def initialize
      specification = File.read(gemspec_file)
      super(eval(specification))
    end

    def for_gemfile
      "gem '#{ name }', '~> #{ version }'"
    end

    def gem_file_name
      "#{ name }-#{ version }.gem"
    end

    def version
      super.to_s
    end

    private

    def gemspec_file
      Dir.glob("#{ Dir.pwd }/*.gemspec").first
    end
  end
end
