module Command
  class Repository
    attr_reader :options

    def initialize(project, options)
      @project = project
      @options = options
      @cmds = []
      @trash = []
    end

    def add(cmd, options = {})
      @cmds << cmd.new(rvm_prefix, options)
    end

    def execute
      @cmds.count.times do
        command = @cmds.shift
        puts(command.name)

        command.execute
        @trash.unshift(command)
      end
      puts "Success bump current gem in #{ project.project }"

    rescue => e
      @trash.each(&:cancel)

      puts 'Fail bump gem'
      raise Command::ExecuteError(e.message)
    end

    def debug
      @cmds.map(&:name).join("\n")
    end

    private

    attr_reader :project

    def rvm_prefix
      if options[:gemset]
        "rvm #{ options[:gemset] } exec "
      end
    end
  end
end