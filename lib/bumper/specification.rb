module Bumper
  class Specification < SimpleDelegator
    def initialize(gemspec)
      specification = File.read(gemspec_file(gemspec))
      super(eval(specification))
    end

    private

    def gemspec_file(gemspec)
      gemspec || File.join(Dir.pwd, Dir.glob('*.gemspec'))
    end
  end
end