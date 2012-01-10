# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "databasedotcom-rails"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Danny Burkes"]
  s.date = "2011-08-24"
  s.description = "Convenience classes to make using the databasedotcom gem with Rails apps even easier"
  s.email = ["dburkes@netable.com"]
  s.homepage = "http://github.com/dburkes/databasedotcom-rails"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.10"
  s.summary = "Convenience classes to make using the databasedotcom gem with Rails apps even easier"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<databasedotcom>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["= 2.6.0"])
      s.add_development_dependency(%q<rake>, ["= 0.8.6"])
    else
      s.add_dependency(%q<databasedotcom>, [">= 0"])
      s.add_dependency(%q<rspec>, ["= 2.6.0"])
      s.add_dependency(%q<rake>, ["= 0.8.6"])
    end
  else
    s.add_dependency(%q<databasedotcom>, [">= 0"])
    s.add_dependency(%q<rspec>, ["= 2.6.0"])
    s.add_dependency(%q<rake>, ["= 0.8.6"])
  end
end
