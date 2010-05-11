require 'test_helper'

class ObjectLoggingTest < Test::Unit::TestCase
  
  def test_basic
    u = User.new
    u.foo
    u.bar
    expected = [
      ["DEBUG", "User#foo", "foo"],
      ["INFO", "User#bar", "bar"]
    ]
    assert_equal expected, u.logger.entries
  end
  
  def test_usurping
    u = User.new
    a = Account.new
    
    u.foo
    a.foi
    
    u_logger = u.logger
    u.logger = a.logger
    
    u.bar
    a.baz
    
    u.logger = u_logger
    
    u.foo
    a.foi
    
    expected = [
      ["DEBUG", "User#foo", "foo"],
      ["DEBUG", "User#foo", "foo"]
    ]
    assert_equal expected, u.logger.entries
    
    expected = [
      ["DEBUG", "Account#foi", "foi"],
      ["INFO", "User#bar", "bar"],
      ["INFO", "Account#baz", "baz"],
      ["DEBUG", "Account#foi", "foi"],
    ]
    assert_equal expected, a.logger.entries
  end
  
  def test_inheritance
    p = Person.new
    s = Schmuck.new
    assert_equal p.class.object_logging, s.class.object_logging
    assert_not_equal p.class.object_logging.object_id, s.class.object_logging.object_id
    assert_equal([:rails_log, {}], s.class.object_logging)
  end
  
  def test_static
    Static.foo
    assert_equal([["DEBUG", "Static.foo", "hio"]], Static.logger.entries)
  end
  
  def test_threads
    u = User.new
    threads = (1..10).collect{ Thread.new{ u.thr } }
    threads.each{ |thread| thread.join }
    expected = threads.collect{ |thread| "[INFO] User#thr from thread #{thread}" }.to_set
    actual = u.logger.entries.collect{ |level, context, message| "[#{level}] #{context} #{message}" }.to_set
    assert_equal expected, actual
  end
  
end
