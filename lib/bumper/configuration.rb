module Bumper
  class Configuration
    class << self
      def configure!(options)
        validate(options)
      end

      private

      def validate(options)
         raise
      end
    end
  end
end