module Pumper
  class Pump
    def initialize(options)
      @options = options
    end

    def perform
      project = Project.new(options)
      commands = Command::Repository.new(project)

      commands.add(Command::GemRebuildCommand)
      commands.add(Command::GemUninstallCommand, { gem_name: specification.name })

      if project.is_vendor
        commands.add(Command::GemInstallToVendorCommand, { project_path: project.path, gem_name: specification.name })
      else
        commands.add(
          Command::GemInstallCommand,
          {
            gem_name: specification.name,
            gem_file_name: specification.gem_file_name,
            project_path: project.path
          }
        )
      end

      project.bump_version!(specification)
      commands.execute
    end

    private

    attr_reader :options

    def specification
      @specification ||= Specification.new
    end
  end
end