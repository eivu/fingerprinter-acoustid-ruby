# frozen_string_literal: true

require_relative '../eivu-objects'
require 'active_support'

module Eivu
  module Objects
    class Match
      include Comparable

      MIN_THRESHOLD = 12

      attr_reader :release_group, :recording, :result_score,
                  :original_release_group_name, :matched_release_group_name

      delegate :duration, to: :recording
      delegate :title, to: :recording
      delegate :type, to: :release_group
      delegate :secondarytypes, to: :release_group
      delegate :secondary_types, to: :release_group

      def initialize(recording:, result_score:, release_group:, original_release_group_name:, matched_release_group_name:)
        @release_group               = release_group
        @recording                   = recording
        @result_score                = result_score
        @original_release_group_name = original_release_group_name
        @matched_release_group_name  = matched_release_group_name
      end

      # returns  1 if self > other
      # returns  0 if self == other
      # returns -1 if self < other
      def <=> (other)
        result_score <=> other.result_score
      end

      def distance
        @distance ||=
          begin
            orig_album    = original_release_group_name&.downcase
            matched_album = release_group.title&.downcase
            l_distance = Levenshtein.distance(orig_album, matched_album)
            if l_distance <= MIN_THRESHOLD
              l_distance
            else
              shorter, longer = [orig_album, matched_album].sort{|x,y| x.length <=> y .length}
              return MIN_THRESHOLD if longer.include?(shorter)

              raise 'fix this'
            end
          end
      end

      def print_artists
        puts "release_group: #{release_group.artists.collect(&:name).join(', ')}"
        puts "recording: #{recording.artists.collect(&:name).join(', ')}"
      end

      alias releasegroup release_group
    end
  end
end
