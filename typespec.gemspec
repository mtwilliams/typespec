$:.push File.expand_path(File.join(File.dirname(__FILE__), 'lib'))
require 'typespec/gem'

Gem::Specification.new do |s|
  s.name              = Typespec::Gem.name
  s.version           = Typespec::Gem.version
  s.platform          = Gem::Platform::RUBY
  s.author            = Typespec::Gem.author.name
  s.email             = Typespec::Gem.author.email
  s.homepage          = Typespec::Gem.homepage
  s.summary           = Typespec::Gem.summary
  s.description       = Typespec::Gem.description
  s.license           = Typespec::Gem.license

  s.required_ruby_version = '>= 1.9.3'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = %w(lib)
end
