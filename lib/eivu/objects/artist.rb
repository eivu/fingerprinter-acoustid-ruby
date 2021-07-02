# frozen_string_literal: true

require_relative 'base_class'

module Eivu
  module Objects
    class Artist < BaseClass
      attr_reader :id, :name, :joinphrase

      def initialize(id:, name:, joinphrase: nil)
        @id         = id
        @name       = name
        @joinphrase = joinphrase
      end
    end
  end
end
