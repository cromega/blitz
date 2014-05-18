Gem::Specification.new do |s|
  s.name        = 'blitz'
  s.version     = '0.0.1'
  s.summary     = 'A simple auto complete engine on redis'
  s.description = 'A simple auto complete engine on redis'
  s.author      = 'Bence Monus'
  s.email       = 'crome@sublimia.nl'
  s.homepage    = 'http://github.com/cromega/blitz'
  s.files       = `git ls-files`.split("\n")
  s.test_files  = `git ls-files -- test/*`.split("\n")
  s.license     = 'MIT'

  s.required_ruby_version = '>= 1.8.7'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest', '~> 5.0.0'
end
