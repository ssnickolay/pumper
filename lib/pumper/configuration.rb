module Pumper
  class Configuration
    class ProjectNotSet < StandardError; end

    class << self
      def configure!(options)
        validate(options)

        options
      end

      private

      def validate(options)
        raise ProjectNotSet if options[:project].nil?
      end
    end
  end
end