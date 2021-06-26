# frozen_string_literal: true
require 'eivu/eivu-objects'

module Eivu
  module Objects
    class Match
      attr_reader :release_group, :recording,
                  :original_release_group_name, :matched_release_group_name

      def initialize(recording:, release_group:, original_release_group_name:, matched_release_group_name:)
        @release_group               = release_group
        @recording                   = recording
        @original_release_group_name = original_release_group_name
        @matched_release_group_name  = matched_release_group_name
      end

      alias releasegroup release_group
    end
  end
end
