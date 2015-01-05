module Command
  class Repository
    attr_reader :options

    def initialize(options)
      @options = options
      @cmds = []
    end

    def add(cmd, options = {})
      @cmds << cmd.new(rvm_prefix, options)
    end

    def execute
      with_transaction do |trash|
        while @cmds.any?
          command = @cmds.shift
          puts(command.name)

          command.execute
          trash.unshift(command)
        end
      end

      puts 'Success bump current gem'
    end

    private

    def rvm_prefix
      if options[:gemset]
        "rvm #{ options[:gemset] } exec "
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
        puts 'Fail bump current gem'
        raise Command::ExecuteError
      ensure
        wrapper.cancel
      end
    end
  end
end