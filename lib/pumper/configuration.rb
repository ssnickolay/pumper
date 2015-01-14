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
        if options[:config] && (options[:project] || options[:gemset] || options[:vendor])
          raise InvalidOptions.new('Error: config option use without [project|gemset|vendor] options')
        end

        if options[:project].nil? && options[:config].nil?
          raise ProjectNotSet.new('You need set project (--project <PATH_TO_PROJECT>) or use config')
        end
      end
    end
  end
end