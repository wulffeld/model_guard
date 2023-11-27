require_relative "lib/model_guard/version"

Gem::Specification.new do |spec|
  spec.name = "model_guard"
  spec.version = ModelGuard::VERSION
  spec.authors = ["Martin Moen Wulffeld"]
  spec.email = ["martin@wulffeld.dk"]

  spec.summary = "Various concerns for ActiveModel."
  spec.description = "Sometimes you want to protect your models from being updated or destroyed directly. This gem provides concerns for that."
  spec.homepage = "https://github.com/wulffeld/model_guard"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/wulffeld/model_guard"
  spec.metadata["changelog_uri"] = "https://github.com/wulffeld/model_guard/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "activerecord", "~> 7"
  spec.add_development_dependency "sqlite3"
end
