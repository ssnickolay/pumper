module Bumper
  class ProjectGemfile
    class UndefinedGem < StandardError; end

    def initialize(project, is_absolute_path)
      @gemfile = find_gemfile(project, is_absolute_path)
    end

    def bump_version!(specification)
      text = File.read(gemfile)
      if gem_defined?(text, specification.name)
        File.open(gemfile, 'w') do |file|
          file.puts(text.gsub(/#{ gem_name(specification.name) }.*/, specification.for_gemfile))
        end
      else
        raise ProjectGemfile::UndefinedGem
      end
    end

    private

    attr_reader :gemfile

    def find_gemfile(project, is_absolute_path)
      if is_absolute_path
        "#{ project }/Gemfile"
      else
        File.join(Dir.pwd, "../#{ project }/Gemfile")
      end
    end

    def gem_defined?(gemfile_text, gem)
      gemfile_text.include?(gem_name(gem))
    end

    def gem_name(gem)
      "gem '#{ gem }'"
    end
  end
end