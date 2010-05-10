module ObjectLogging
  module Log
    class Base
      
      def initialize(object, options)
        @storage = []
      end
      
      def log(level, context, message)
        @storage << [level, context, message]
      end
      
      def entries
        @storage
      end
      
      def clear
        @storage = []
      end
      
    end
  end
end