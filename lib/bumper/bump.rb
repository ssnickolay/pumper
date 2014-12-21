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
        gemfile = ProjectGemfile.new(project, options[:absolute_path])
        gemfile.bump_version!(Specification.new(options[:gemspec]))

        system("cp pkg/* ../#{ project }/vendor/cache")
        puts "copied to #{ project }"
      end
    end

    private

    attr_reader :options
  end
end