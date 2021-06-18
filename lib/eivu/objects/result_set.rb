# frozen_string_literal: true
require 'eivu/eivu-objects'
require 'eivu/fingerprinter/acoustid'

module Eivu
  module Objects
    class ResultSet
      attr_reader :results, :status

      OK_STATUS = 'ok'

      def initialize(results:, status:)
        @results = results.collect { |r| Eivu::Objects::Result.new(**r) }
        @status  = status
      end

      def ok?
        @status == OK_STATUS
      end
    end
  end
end
