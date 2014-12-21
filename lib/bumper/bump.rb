module Bumper
  class Bump
    def initialize(options)
      @options = options
      @project = options[:project]
    end

    def perform
      gemfile = ProjectGemfile.new(project, options[:absolute_path])
      gemfile.bump_version!(specification)

      commands = CommandRepository.new(project)
      if options[:gemset]
        commands.add('[ -s "/usr/local/rvm/scripts/rvm" ] && . "/usr/local/rvm/scripts/rvm"')
        commands.add("rvm use #{ options[:gemset] }")
      end

      commands.add("gem cleanup #{ specification.name }")
      if options[:vendor]
        commands.add("cp pkg/* ../#{ project }/vendor/cache")
        commands.add("cd ../#{ project } && bundle install --local")
      else
        commands.add("gem install ./#{ specification.gem_file_name }")
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