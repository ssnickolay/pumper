module Bumper
  class Specification < SimpleDelegator
    def initialize(gemspec)
      specification = File.read(gemspec_file(gemspec))
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

    def gemspec_file(gemspec)
      gemspec || File.join(Dir.pwd, Dir.glob('*.gemspec'))
    end
  end
end