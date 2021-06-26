# frozen_string_literal: true
require 'eivu/eivu-objects'

module Eivu
  module Objects
    class Match
      attr_reader :release_group, :recording, :result_score,
                  :original_release_group_name, :matched_release_group_name

      delegate :duration, to: :recording
      delegate :title, to: :recording
      delegate :album, to: :release_group
      delegate :album, to: :release_group
      delegate :secondarytypes, to: :release_group
      delegate :secondary_types, to: :release_group

      def initialize(recording:, result_score:, release_group:, original_release_group_name:, matched_release_group_name:)
        @release_group               = release_group
        @recording                   = recording
        @result_score                = result_score
        @original_release_group_name = original_release_group_name
        @matched_release_group_name  = matched_release_group_name
      end

      def print_artists
        puts "release_group: #{release_group.artists.collect(&:name).join(', ')}"
        puts "recording: #{recording.artists.collect(&:name).join(', ')}"
      end

      alias releasegroup release_group
    end
  end
end
