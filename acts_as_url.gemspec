Gem::Specification.new do |s|
  s.name = %q{acts_as_url}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Molte Emil Strange Andersen"]
  s.date = %q{2010-09-23}
  s.description = %q{This acts_as extension adds the protocol (eg http) to a url database column if missing. It also validates the url against a regular expression.}
  s.email = %q{molte93@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "MIT-LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "acts_as_url.gemspec",
     "init.rb",
     "lib/acts_as_url.rb",
     "lib/acts_as_url/railtie.rb",
     "rails/init.rb",
     "test/acts_as_url_test.rb",
     "test/schema.rb",
     "test/test_helper.rb"
  ]
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{This acts_as extension adds the protocol to a url}
  s.test_files = [
    "test/acts_as_url_test.rb",
     "test/schema.rb",
     "test/test_helper.rb"
  ]

  s.add_development_dependency "bundler", "~> 1.10"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "activerecord", "~> 4.2.0"
  s.add_development_dependency "test-unit"
  s.add_development_dependency "sqlite3"
end

