require "object_logging/log/base"

module ObjectLogging
  module Log
    class Stdout < Base
      
      def log(level, context, message)
        super
        puts "[#{level.downcase}] #{context} #{message}"
      end
      
    end
  end
end