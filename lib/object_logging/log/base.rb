require "thread"

module ObjectLogging
  module Log
    class Base
      
      def initialize(object, options)
        @storage = []
        @lock = Mutex.new
      end
      
      def log(level, context, message)
        @lock.synchronize{ @storage << [level, context, message] }
      end
      
      def entries
        @lock.synchronize{ @storage.dup }
      end
      
      def clear
        @lock.synchronize{ @storage.clear }
      end
      
    end
  end
end