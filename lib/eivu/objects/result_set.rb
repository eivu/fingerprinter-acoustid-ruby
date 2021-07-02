# frozen_string_literal: true
require_relative '../eivu-objects'

module Eivu
  module Objects
    class ResultSet
      attr_reader :results, :status

      OK_STATUS = 'ok'

      def initialize(results:, status:)
        @results = results.collect { |r| Eivu::Objects::Result.new(**r) }
        @status  = status
      end

      def best_match(duration:, release_group_name: nil)
        raise(ArgumentError, 'ResultSet did not return OK') unless ok?

        # generate array of matches
        matches = results.collect {|r| r.generate_match(duration: duration, release_group_name: release_group_name) }
        # prune nil results and return highest scoring match
        matches.compact.max
      end

      def ok?
        @status == OK_STATUS
      end
    end
  end
end
