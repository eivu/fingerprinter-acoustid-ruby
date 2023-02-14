# frozen_string_literal: true

Gem::Specification.new do |s|
  s.authors = ['Robert Jenkins']
  s.email   = ['me@rkj3.com']

  s.name = 'eivu-fingerprinter-acoustid'
  s.version = '0.1.0'

  s.license          = 'MIT'
  s.homepage         = 'https://github.com/eivu/eivu-fingerprinter-acoustid-ruby'

  s.platform = Gem::Platform::RUBY
  s.summary = 'Ruby wrapper for the AcoustID service'
#   s.description = <<-EOD
# uby wrapper for the AcoustID service
#   EOD
  s.files         = ['lib/eivu-fingerprinter-acoustid.rb']
  s.require_paths = ['lib']

  s.add_dependency 'amatch', '~> 0.4.0' # library for approximate string matching and searching in strings
  s.add_dependency 'activesupport', '>= 6.1.4', '< 8.0' # handy rails functions
  s.add_dependency 'colorize', '~> 0.8.1'
  s.add_dependency 'factory_bot', '~> 6.2' # factory_bot provides a framework and DSL for defining and using factories 
  s.add_dependency 'faker', '~> 2.18' # easily generate fake data: names, addresses, phone numbers, etc
  s.add_dependency 'fuzzy_match', '~> 2.1' # Find a needle (a document or record) in a haystack using string similarity and (optionally) regular expression rules. Uses Dice's Coefficient (aka Pair Similiarity) and Levenshtein Distance internally.
  s.add_dependency 'id3tag', '~> 0.14.1' # mp3 id3 tagger
  s.add_dependency 'levenshtein-ffi', '~> 1.1' # implementation of the levenshtein distance algorithm.
  s.add_dependency 'oj', '~> 3.3', '>= 3.3.5' # The fastest JSON parser and object serializer.
  s.add_dependency 'pry', '~> 0.14.1' # Debugger
  s.add_dependency 'rest-client', '~> 2.1'
  s.add_dependency 'rspec', '~> 3.10' # testing lib
  s.add_dependency 'rubocop', '~> 1.17'
  s.add_dependency 'vcr', '~> 6.0'
  s.add_dependency 'webmock', '~> 3.13'

  # s.files = `git ls-files`.split "\n"
  # s.test_files = `git ls-files -- {test,spec,features}/*`.split "\n"
  # s.executables = `git ls-files -- bin/*`.split("\n").map { |f| File.basename f }
  # s.require_paths = ['lib']

  # s.required_ruby_version = '>= 2.4.0'

  # s.add_dependency 'ice_cube', '~> 0.16'

  # s.add_development_dependency 'rake', '~> 13.0'
  # s.add_development_dependency 'bundler', '~> 2.0'

  # # test with all groups of tzinfo dependencies
  # # tzinfo 2.x
  # # s.add_development_dependency 'tzinfo', '~> 2.0'
  # # s.add_development_dependency 'tzinfo-data', '~> 1.2020'
  # # tzinfo 1.x
  # s.add_development_dependency 'activesupport', '~> 6.0'
  # s.add_development_dependency 'i18n', '~> 1.8'
  # s.add_development_dependency 'tzinfo', '~> 1.2'
  # s.add_development_dependency 'tzinfo-data', '~> 1.2020'
  # # tzinfo 0.x
  # # s.add_development_dependency 'tzinfo', '~> 0.3'
  # # end tzinfo

  # s.add_development_dependency 'timecop', '~> 0.9'
  # s.add_development_dependency 'rspec', '~> 3.8'
  # s.add_development_dependency 'simplecov', '~> 0.16'
end