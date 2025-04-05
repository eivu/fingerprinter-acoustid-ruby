# frozen_string_literal: true

require_relative "lib/eivu/fingerprinter_acoustid/version"

Gem::Specification.new do |spec|
  spec.name = "eivu_fingerprinter_acoustid"
  spec.version = "0.1.4"
  spec.authors = ["Rob Jenkins"]
  spec.email = ["384403+dabobert@users.noreply.github.com"]

  spec.summary = "Ruby wrapper for the AcoustID service"
  spec.homepage = "https://github.com/eivu/eivu-fingerprinter-acoustid-ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.5"
  spec.description = <<-MARKDOWN
    ruby wrapper for the [AcoustID](https://acoustid.org/) service
  MARKDOWN

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/eivu/eivu-fingerprinter-acoustid-ruby"
  spec.metadata["changelog_uri"] = "https://github.com/eivu/eivu-fingerprinter-acoustid-ruby/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 6.1.4", "< 8.0" # handy rails functions
  spec.add_dependency "amatch", "~> 0.4.0" # library for approximate string matching and searching in strings
  spec.add_dependency "colorize", "~> 0.8.1"
  spec.add_dependency "factory_bot", "~> 6.2" # factory_bot provides a framework and DSL for defining and using factories
  spec.add_dependency "faker", "~> 2.18" # easily generate fake data: names, addresses, phone numbers, etc
  spec.add_dependency "fuzzy_match", "~> 2.1" # Find a needle (a document or record) in a haystack using string similarity and (optionally) regular expression rules. Uses Dice's Coefficient (aka Pair Similiarity) and Levenshtein Distance internally.
  spec.add_dependency "id3tag", "~> 1.1" # mp3 id3 tagger
  spec.add_dependency "levenshtein-ffi", "~> 1.1" # implementation of the levenshtein distance algorithm.
  spec.add_dependency "oj", "~> 3.3", ">= 3.3.5" # The fastest JSON parser and object serializer.
  spec.add_dependency "pry", "~> 0.14.1" # Debugger
  spec.add_dependency "rest-client", "~> 2.1"
  spec.add_dependency "rspec", "~> 3.10" # testing lib
  spec.add_dependency "rubocop", "~> 1.17"
  spec.add_dependency "vcr", "~> 6.0"
  spec.add_dependency "webmock", "~> 3.13"
  spec.metadata["rubygems_mfa_required"] = "true"
end
