Gem::Specification.new do |gem|
  gem.name = "pilha"
  gem.version = "0.1.7"
  gem.authors = ["Dalto Curvelano Junior"]
  gem.description = "A ruby wrapper to the Stack Exchange (Stack Overflow and friends) API."
  gem.summary = "A ruby wrapper to the Stack Exchange (Stack Overflow and friends) API."
  gem.license = 'MIT'
  gem.homepage = "http://github.com/dlt/pilha"

  gem.files = Dir.glob("{lib}/**/*") + %w(README.rdoc)
  gem.test_files = Dir.glob("{spec}/**/*")

  gem.require_path = 'lib'

  gem.add_development_dependency "rspec"

end
