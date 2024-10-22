# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "chat_stew/version"

Gem::Specification.new do |s|
  s.name        = "chat_stew"
  s.version     = ChatStew::VERSION
  s.authors     = ["Gabe Berke-Williams"]
  s.email       = ["gabe@thoughtbot.com"]
  s.homepage    = ""
  s.summary     = %q{An Adium log parser with an easy interface. Supports custom parsers too.}
  s.description = s.summary

  s.rubyforge_project = "chat_stew"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("nokogiri", "~> 1.5.0")

  s.add_development_dependency("rspec", "~> 2.6.0")
  s.add_development_dependency("bourne", "~> 1.0")
end
