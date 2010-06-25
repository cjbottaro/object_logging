require "object_logging/metaclass"
require "object_logging/logger"

module ObjectLogging
  
  def self.included(mod)
    mod.send(:extend,  ClassMethods)
    mod.send(:include, InstanceMethods)
    mod.metaclass.class_eval do
      alias_method :inherited_without_object_logging, :inherited
      alias_method :inherited, :inherited_with_object_logging
    end
  end
  
  module ClassMethods
    
    def inherited_with_object_logging(mod)
      inherited_without_object_logging(mod)
      object_logging_copy = @object_logging && @object_logging.collect do |e|
        begin
          e.dup
        rescue TypeError
          e
        end
      end
      mod.instance_variable_set("@object_logging", object_logging_copy)
    end
    
    def object_logging(*args)
      if args.empty?
        @object_logging
      else
        options = args.last.kind_of?(Hash) ? args.pop : {}
        @object_logging = [args.first, options]
      end
    end
    
  end
  
  module InstanceMethods
    
    def object_logging
      if instance_of?(Class)
        self.metaclass.object_logging
      else
        self.class.object_logging
      end
    end
    
    def logger
      @logger ||= Logger.new(self)
      
      # User could have assigned a logger other than ObjectLogging::Logger to this object.
      @logger.objectify(self) if @logger.instance_of?(ObjectLogging::Logger) # Hence the guard.
      
      @logger
    end
    
    def logger=(logger)
      @logger = logger
    end
    
  end
  
end