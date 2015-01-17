# Parse and validate options
#   * _options_ - user set options
# Return array of options hash (from .piper.yml) if set --config
# Return options hash unless set --config
require 'yaml'

module Pumper
  class Configuration
    class ProjectNotSet < StandardError; end
    class InvalidOptions < StandardError; end

    class << self
      def configure!(options)
        validate(options)

        options[:config] ? parse_from_config : options
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

      def parse_from_config
        file = File.read(File.join(Dir.pwd, '.piper.yml'))
        YAML.load(file)['projects'].each_with_object([]) do |(_, option), arr|
          arr.push(
            project: option['path'],
            is_absolute_path: option['absolute_path'],
            gemset: option['gemset'],
            is_vendor: option['vendor']
          )
        end
      end
    end
  end
end