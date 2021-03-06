require_relative 'lib/liri/version'

Gem::Specification.new do |spec|
  spec.name          = "liri"
  spec.version       = Liri::VERSION
  spec.authors       = ["Rodrigo Fernández", "Leslie López"]
  spec.email         = ["rofaccess@gmail.com", "leslyee.05@gmail.com"]

  spec.summary     = "TFG Project"
  spec.description = "Test distributor executor"
  spec.homepage      = "https://github.com/rofaccess/tfg"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://github.com/rofaccess/tfg"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/rofaccess/tfg"
  spec.metadata["changelog_uri"] = "https://github.com/rofaccess/tfg/blob/master/liri/README.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
