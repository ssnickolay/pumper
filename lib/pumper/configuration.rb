module Pumper
  class Configuration
    class ProjectNotSet < StandardError; end
    class InvalidOptions < StandardError; end

    class << self
      def configure!(options)
        validate(options)

        options
      end

      private

      def validate(options)
        raise ProjectNotSet.new('You need set project (--project <PATH_TO_PROJECT>)') if options[:project].nil?
        raise InvalidOptions.new('Invalid options') if options[:config] && (options[:gemset] || options[:vendor])
      end
    end
  end
end