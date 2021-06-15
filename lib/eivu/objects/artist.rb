# frozen_string_literal: true

module Eivu
  module Objects
    class Artist
      attr_reader :id, :name, :joinphrase

      def initialize(id:, name:, joinphrase: nil)
        @id         = id
        @name       = name
        @joinphrase = joinphrase
      end
    end
  end
end
