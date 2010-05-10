require "object_logging/log/base"

module ObjectLogging
  module Log
    class RailsLog < Base
      
      def log(level, context, message)
        super
        Rails.logger.send(level.downcase, "#{context} #{message}")
      end
      
    end
  end
end