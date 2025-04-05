# frozen_string_literal: true

require_relative '../objects'
require 'active_support/all'
require "damerau-levenshtein"

module EivuFingerprinterAcoustid
  module Objects
    class Match
      include Comparable

      THRESHOLD_MIN = 12
      OFFSET_IN_STRING = 1
      OFFSET_REORDERED = 5
      THRESHOLD_REORDERED = 0.85

      attr_reader :release_group, :recording, :result_score,
                  :original_release_group_name, :matched_release_group_name,
                  :result_id

      delegate :duration, to: :recording
      delegate :title, to: :recording
      delegate :type, to: :release_group
      delegate :secondarytypes, to: :release_group
      delegate :secondary_types, to: :release_group

      def initialize(recording:, result_score:, release_group:, original_release_group_name:, matched_release_group_name:, result_id:)
        @release_group               = release_group
        @recording                   = recording
        @result_score                = result_score
        @original_release_group_name = original_release_group_name
        @matched_release_group_name  = matched_release_group_name
        @result_id                   = result_id
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
            l_distance = DamerauLevenshtein.distance(orig_album, matched_album)
            if l_distance <= THRESHOLD_MIN
              l_distance
            else
              shorter, longer = [orig_album, matched_album].sort{|x,y| x.length <=> y .length}
              return THRESHOLD_MIN + OFFSET_IN_STRING if longer.include?(shorter)

              shorter_cleansed = shorter.gsub(/[^0-9a-z ]/i, '')
              longer_cleansed  = longer.gsub(/[^0-9a-z ]/i, '')
              find_count = shorter_cleansed.split.count do |word|
                longer_cleansed.include?(word)
              end
              reordered_percentage = find_count / shorter_cleansed.split.count.to_f
              return THRESHOLD_MIN + OFFSET_REORDERED if reordered_percentage >= THRESHOLD_REORDERED

              raise "fix this: distance is #{l_distance}"
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
