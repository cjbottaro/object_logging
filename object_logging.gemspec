# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{object_logging}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Christopher J. Bottaro"]
  s.date = %q{2010-05-11}
  s.description = %q{It's a pain to trudge through large log files.  Sometimes you just want to see log messages for one particular object.}
  s.email = %q{cjbottaro@alumni.cs.utexas.edu}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "CHANGELOG",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/object_logging.rb",
     "lib/object_logging/log/base.rb",
     "lib/object_logging/log/rails_cache.rb",
     "lib/object_logging/log/rails_log.rb",
     "lib/object_logging/log/stdout.rb",
     "lib/object_logging/logger.rb",
     "lib/object_logging/metaclass.rb",
     "object_logging.gemspec",
     "test/object_logging_test.rb",
     "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/cjbottaro/object_logging}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Super simple logging for objects.}
  s.test_files = [
    "test/object_logging_test.rb",
     "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

