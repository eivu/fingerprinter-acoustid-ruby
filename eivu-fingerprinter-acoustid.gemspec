# frozen_string_literal: true

Gem::Specification.new do |s|
  s.authors = ['Robert Jenkins']
  s.email   = ['me@rkj3.com']

  s.name = 'eivu-fingerprinter-acoustid'
  s.version = '0.1.0'

  # s.homepage = "https://github.com/icalendar/icalendar"
  s.platform = Gem::Platform::RUBY
  s.summary = 'Ruby wrapper for the AcoustID service'
#   s.description = <<-EOD
# uby wrapper for the AcoustID service
#   EOD
  s.files       = ['lib/eivu-fingerprinter-acoustid.rb']
  s.require_paths = ['lib']
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