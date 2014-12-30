module Command
  class ExecuteError < StandardError; end

  class BaseCommand
    attr_reader :rvm_prefix, :options

    def initialize(rvm_prefix = nil, options = {})
      @rvm_prefix = rvm_prefix
      @options = options
    end

    def execute
      system(name) or raise Command::ExecuteError
    end

    def cancel
      raise NotImplementedError
    end

    def name
      raise NotImplementedError
    end

    private

    def clean(cmd)
      cmd.gsub(/\s+/, ' ').strip
    end
  end
end