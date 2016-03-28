require './lib/nmax/version'

Gem::Specification.new 'nmax', NMax::VERSION do |s|
  s.homepage    = 'http://rubygems.org/gems/nmax'
  s.date        = '2016-03-28'
  s.summary     = 'NMax'
  s.description = 'NMax'
  s.author      = 'Vladislav Petrov'
  s.email       = 'electronicchest@gmail.com'
  s.license     = 'MIT'
  s.platform    = Gem::Platform::RUBY
  s.post_install_message = 'Thanks for installing!'

  s.required_ruby_version = '>= 2.1.2'

  s.files         = `git ls-files`.split
  s.test_files    = `git ls-files -- {test,spec,features}`.split
  s.executables   = `git ls-files -- bin`.split.map { |f| File.basename(f) }
  s.require_paths = ['lib']
end
