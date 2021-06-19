# frozen_string_literal: true
require 'eivu/eivu-objects'

module Eivu
  module Objects
    class Result < BaseClass
      attr_reader :id, :recordings, :score

      def initialize(id:, recordings:, score:)
        @id             = id
        @recordings     = recordings.collect { |r| Eivu::Objects::Recording.new(**r) }
        @score          = score
      end
    end
  end
end
