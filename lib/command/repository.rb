module Command
  class Repository
    def initialize(project)
      @project = project
      @cmds = []
    end

    def add(cmd, options = {})
      @cmds << cmd.new(rvm_prefix, options)
    end

    def execute
      with_transaction do |trash|
        while @cmds.any?
          command = @cmds.shift
          puts(command.name.brown)

          command.execute
          trash.unshift(command)
        end
      end

      puts 'Success bump current gem!'.green
    end

    private

    attr_reader :project

    def rvm_prefix
      if project.gemset
        "rvm #{ project.gemset } exec "
      end
    end

    def with_transaction
      trash = []
      wrapper = Command::StashGemfileLockCommand.new
      begin
        wrapper.execute
        yield(trash)
      rescue Exception => e
        trash.each(&:cancel)
        puts 'Fail bump current gem'.red
        raise Command::ExecuteError
      ensure
        wrapper.cancel
      end
    end
  end
end

class String
  def red;   "\033[31m#{self}\033[0m" end
  def green; "\033[32m#{self}\033[0m" end
  def brown; "\033[33m#{self}\033[0m" end
end