require "object_logging/log/rails_cache"
require "object_logging/log/rails_log"
require "object_logging/log/stdout"

module ObjectLogging
  module Log
    class RailsCache < Base
      
      def initialize(object, options)
        @key = make_key(object, options)
      end
      
      def log(level, context, message)
        Rails.cache.write(key, entries << [level, context, message])
      end
      
      def entries
        Rails.cache.read(key) || []
      end
      
      def clear
        Rails.cache.delete(key)
      end
      
    private
      
      def key
        @key
      end
      
      def make_key(object, options)
        id = options[:id]
        if id.kind_of(Proc)
          key = id.call(object)
        else
          key = object.send(id)
        end
        "object_logging/#{key}"
      end
      
    end
  end
end