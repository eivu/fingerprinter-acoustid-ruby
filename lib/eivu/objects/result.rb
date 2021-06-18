# frozen_string_literal: true
require 'eivu/eivu-objects'

module Eivu
  module Objects
    class Result
      attr_reader :id, :recordings, :score

      def initialize(id:, recordings:, score:)
        @id             = id
        @recordings     = recordings.collect { |a| Eivu::Objects::Recording.new(**a) }
        @score          = score
      end
    end
  end
end
