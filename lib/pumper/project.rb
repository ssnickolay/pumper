module Pumper
  class Project < Struct.new(:project, :is_absolute_path, :gemset, :is_vendor)
    class UndefinedGem < StandardError; end

    def initialize(options)
      set_options(options)
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
      is_absolute_path ?
        project :
        File.join(Dir.pwd, "../#{ project }")
    end

    private

    def set_options(options)
      members.each do |member|
        self.send("#{ member }=", options[member])
      end
    end

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