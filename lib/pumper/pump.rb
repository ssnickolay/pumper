module Pumper
  class Pump
    def initialize(options)
      @options = options
    end

    def perform
      project = UpdatingProject.new(options[:project], options[:absolute_path])
      commands = Command::Repository.new(project, options)

      commands.gem_rebuild

      system('mv ./Gemfile.lock ./Gemfile.lock.stash')

      commands.gem_uninstall(specification.name)

      if options[:vendor]
        commands.gem_install_to_vendor
      else
        commands.gem_install(specification)
      end

      project.bump_version!(specification)
      commands.execute

      system('mv ./Gemfile.lock.stash ./Gemfile.lock')
    end

    private

    attr_reader :options, :project

    def specification
      @specification ||= Specification.new(options[:gemspec])
    end
  end
end