module Bumper
  class CommandRepository
    def initialize(project)
      @project = project
      @cmds = []
      init_cmds
    end

    def add(cmd)
      @cmds << cmd
    end

    def run!
      @cmds.each do |cmd|
        puts(cmd)
        system(cmd)
      end

      puts "Success bump current gem in #{ @project }"
    end

    def debug
      @cmds.join("\n")
    end

    private

    def init_cmds
      add('rm -rf pkg')
      add('rake build')
    end
  end
end