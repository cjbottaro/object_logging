module ObjectLogging
  class Logger
    
    def initialize(object)
      @log = instantiate_log(object)
    end
    
    def objectify(object)
      (@object = object) and self
    end
    
    %w[debug info warn error fatal].each do |level|
      class_eval <<-str
        def #{level}(message, options = {})
          make_entry("#{level}", message, options)
        end
      str
    end
    
    def log
      entries.collect do |level, context, message|
        "[#{level}] #{context} #{message}"
      end.join("\n")
    end
    
    def entries
      @log.entries
    end
    
    def clear
      @log.clear
    end
    
  private
    
    def instantiate_log(object)
      type, options = object.class.object_logging
      type = "base", options = {} if type.nil?
      class_name = type.to_s.split("_").collect{ |word| word.capitalize }.join
      klass = ObjectLogging::Log.const_get(class_name)
      klass.new(object, options)
    end
    
    def make_entry(level, message, options)
      method_name = options[:method_name] || get_method_name
      class_name  = options[:class_name] || get_class_name(method_name)
      context = "#{class_name}##{method_name}"
      @log.log(level.upcase, context, message)
    end
    
    def get_method_name
      m = caller[2].match(/`(.+)'/)
      if m
        m[1]
      else
        "(unknown)"
      end
    end
    
    def get_class_name(method_name)
      if @object.respond_to?(method_name.to_sym)
        @object.class.name
      else
        "(unknown)"
      end
    end
    
  end
end