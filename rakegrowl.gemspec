# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rakegrowl}
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sergio Gil P\303\251rez de la Manga - forked Sam Cavenagh"]
  s.date = %q{2010-06-14}
  s.email = %q{sgilperez@gmail.com - forked cavenaghweb@hotmail.com}
  s.extra_rdoc_files = ["README.md"]
  s.files = ["LICENSE", "README.md", "spec", "lib/rakegrowl.rb", "img/abort.png", "img/complete.png"]
  s.homepage = %q{http://github.com/o-sam-o/rakegrowl}
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Get Growled when your long running rake tasks finish}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end
