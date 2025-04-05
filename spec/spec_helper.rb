# frozen_string_literal: true
# require_relative '../config/environment'
require "active_support/all"
require 'factory_bot'
require "eivu_fingerprinter_acoustid"
require "fuzzy_match"
require "oj"
require 'faker'
require "pry"
require 'support/shared_examples/base_class_functionality_spec'

# RSpec.configure do |config|
#   # Enable flags like --only-failures and --next-failure
#   config.example_status_persistence_file_path = ".rspec_status"

#   # Disable RSpec exposing methods globally on `Module` and `main`
#   config.disable_monkey_patching!

#   config.expect_with :rspec do |c|
#     c.syntax = :expect
#   end
# end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    FactoryBot.find_definitions
  end
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
