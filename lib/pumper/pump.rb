module Pumper
  class Pump
    def initialize(options)
      @options = options
    end

    def perform
      project = UpdatingProject.new(options[:project], options[:absolute_path])
      commands = CommandRepository.new(project, options)

      commands.gem_rebuild
      commands.gem_uninstall(specification.name)

      if options[:vendor]
        commands.gem_install_to_vendor
      else
        commands.gem_install(specification)
      end

      project.bump_version!(specification)
      commands.run!
    end

    private

    attr_reader :options, :project

    def specification
      @specification ||= Specification.new(options[:gemspec])
    end
  end
end