module Pumper
  class Project
    class UndefinedGem < StandardError; end

    attr_reader :project

    def initialize(project, is_absolute_path)
      @project = project
      @is_absolute_path = is_absolute_path
      @gemfile = gemfile_path
    end

    def bump_version!(specification)
      text = File.read(@gemfile)
      if gem_defined?(text, specification.name)
        File.open(@gemfile, 'w') do |file|
          file.puts(text.gsub(/#{ gem_name(specification.name) }.*/, specification.for_gemfile))
        end
      else
        raise Project::UndefinedGem
      end
    end

    def path
      @is_absolute_path ?
        @project :
        File.join(Dir.pwd, "../#{ @project }")
    end

    private

    def gemfile_path
      "#{ path }/Gemfile"
    end

    def gem_defined?(gemfile_text, gem)
      gemfile_text.include?(gem_name(gem))
    end

    def gem_name(gem)
      "gem '#{ gem }'"
    end
  end
end