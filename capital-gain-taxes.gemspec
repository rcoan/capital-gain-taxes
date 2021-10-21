Gem::Specification.new do |spec|
  spec.name          = 'capital-gain-taxex'
  spec.version       = '0.0.1'
  spec.authors       = ['Raul Coan']
  spec.email         = ['rvc.coan@gmail.com']

  spec.summary = 'This gem calculates the amoun of taxes paid for each sell operation'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6.4')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'pry'
end
