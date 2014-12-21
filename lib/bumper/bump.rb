module Bumper
  class Bump
    def initialize(options)
      @options = options
    end

    def perform
      system('rm -rf pkg')
      system('rake build')
      projects = Array(options[:project])

      projects.each do |project|
        system("cp pkg/* ../#{ project }/vendor/cache")
        #gemfile = File.join(Dir.pwd, "../#{ project }/Gemfile")
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

    attr_reader :options

    def specification
      @specification ||= Specification.new(options[:gemspec])
    end

    def gemfile
      @gemfile ||= ProjectGemfile.new(project)
    end
  end
end