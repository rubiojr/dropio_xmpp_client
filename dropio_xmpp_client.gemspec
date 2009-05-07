Gem::Specification.new do |s|
  s.name = %q{dropio_xmpp_client}
  s.version = "0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Sergio Rubio"]
  s.date = %q{2009-05-07}
  s.default_executable = %q{dropio_monitor}
  s.description = %q{drop.io XMPP Client}
  s.email = %q{sergio@rubio.namesergio@rubio.name}
  s.executables = ["dropio_monitor"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/dropio_monitor", "lib/dropio/xmpp/client.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/rubiojr/dropio_xmpp_client}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{dropio_xmpp_client}
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{drop.io XMPP Client Library}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 1.12.1"])
    else
      s.add_dependency(%q<hoe>, [">= 1.12.1"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.12.1"])
  end
end
