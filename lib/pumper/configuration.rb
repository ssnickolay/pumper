# Parse and validate options
#   * _options_ - user's set options
# Return array of options hash (from .pumper.yml if set --config)
require 'yaml'

module Pumper
  class Configuration
    class ProjectNotSet < StandardError; end
    class InvalidOptions < StandardError; end

    class << self
      def configure!(options)
        validate(options)

        options[:config] ? by_config(options[:list]) : [ options ]
      end

      private

      def validate(options)
        if options[:config] && (options[:project] || options[:gemset] || options[:vendor])
          raise InvalidOptions.new('Error: config option must be used without [project|gemset|vendor] options')
        end

        if options[:list] && options[:config].nil?
          raise InvalidOptions.new('Option --list should be used with --config')
        end

        if options[:project].nil? && options[:config].nil?
          raise ProjectNotSet.new('You need to set project (--project <PATH_TO_PROJECT>) or use --config')
        end
      end

      def by_config(list)
        config = parse_config
        slice_config =
          list.nil? ? config : slice(config, list)

        slice_config.values
      end

      def parse_config
        file = File.read(File.join(Dir.pwd, '.pumper.yml'))
        YAML.load(file)['projects'].each_with_object({}) do |(project, option), hash|
          hash[project] =
            {
              project: option['path'],
              is_absolute_path: option['absolute_path'],
              gemset: option['gemset'],
              is_vendor: option['vendor']
            }
        end
      end

      def slice(config, list)
        config.select { |project, _| list.include?(project) }
      end
    end
  end
end
