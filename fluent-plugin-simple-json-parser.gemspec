# encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'fluent-plugin-to-simple-json-parser'
  gem.version     = '0.0.1'
  gem.authors     = ['Al-waleed Shihadeh']
  gem.email       = 'wshihadh@gmail.com'
  gem.homepage    = 'https://github.com/shihadeh/fluent-plugin-to-simple-json-parser'
  gem.description = 'fluentd parser plugin to flatten nested json objects'
  gem.summary     = gem.description
  gem.licenses    = ['MIT']

  gem.files       = `git ls-files`.split("\n")
  gem.test_files  = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = ['lib']

  gem.add_runtime_dependency 'fluentd', '~> 1.2.2'
  gem.add_development_dependency 'test-unit'
  gem.add_development_dependency 'rake'
end
