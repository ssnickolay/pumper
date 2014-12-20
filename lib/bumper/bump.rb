require 'pry'
module Bumper
  class Bump
    class << self
      def perform(options)
        system('rm -rf pkg')
        system('rake build')
        projects = Array(options[:project])

        projects.each do |project|
          system("cp pkg/* ../#{ project }/vendor/cache")
          gemfile = File.join(Dir.pwd, "../#{ project }/Gemfile")
          text = File.read(gemfile)
          File.open(gemfile, 'w') do |file|
            file.puts(
              text.gsub(/gem '#{ specification.name }'.*/, "gem '#{ specification.name }', '~> #{ specification.version }'")
            )
          end

          puts "copied to #{ project }"
        end
      end

      private

      def specification
        @specification ||= Specification.new
      end
    end
  end

  class Specification < SimpleDelegator
    def initialize
      super(eval(File.read(gemspec_file)))
    end

    private

    def gemspec_file
      File.join(Dir.pwd, Dir.glob('*.gemspec'))
    end
  end
end