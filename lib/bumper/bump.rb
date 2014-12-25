module Bumper
  class Bump
    def initialize(options)
      @options = options
      @project = options[:project]
    end

    def perform
      gemfile = ProjectGemfile.new(project, options[:absolute_path])
      gemfile.bump_version!(specification)

      commands = CommandRepository.new(project, options)

      commands.add("gem uninstall #{ specification.name } --all -x", :rvm)
      if options[:vendor]
        commands.add("cp pkg/* ../#{ project }/vendor/cache")
        commands.add("cd ../#{ project }")
        commands.add('bundle install --local', :rvm)
      else
        commands.add("gem install ./pkg/#{ specification.gem_file_name }", :rvm)
      end

      commands.run!
    end

    private

    attr_reader :options, :project

    def specification
      @specification ||= Specification.new(options[:gemspec])
    end
  end
end