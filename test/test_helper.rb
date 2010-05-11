require 'rubygems'
require 'test/unit'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'object_logging'
require "set"

class Test::Unit::TestCase
end

class User
  include ObjectLogging
  
  def foo
    logger.debug("foo")
  end
  
  def bar
    logger.info("bar")
  end
  
  def thr
    logger.info("from thread #{Thread.current}")
  end
end

class Account
  include ObjectLogging
  
  def foi
    logger.debug("foi")
  end
  
  def baz
    logger.info("baz")
  end
  
end

class Person
  include ObjectLogging
  object_logging :rails_log
end

class Schmuck < Person
end

class Static
  class << self
    include ObjectLogging
    def foo
      logger.debug "hio"
    end
  end
end