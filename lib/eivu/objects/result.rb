# frozen_string_literal: true
require 'eivu/eivu-objects'

module Eivu
  module Objects
    class Result < BaseClass
      DURATION_ACCEPTANCE_RANGE = 15
      attr_reader :id, :recordings, :score

      def initialize(id:, recordings:, score:)
        @id             = id
        @recordings     = recordings.collect { |r| Eivu::Objects::Recording.new(**r) }
        @score          = score
      end

      # def filter(duration:, release_name: nil, release_group_name: nil)
      def best_recording(duration:, release_group_name: nil)
        filtered_recordings_via_duration = filter_recordings_via_duration(duration)

        # short circuit if we don't have release_group_name
        return filtered_recordings_via_duration if release_group_name.nil?

        # collect all release group titles of matching recordings
        filtered_albums = filtered_recordings_via_duration.flat_map do |r|
          r.release_groups.collect(&:title)
        end

        # match album via fuzzy match
        matcher = FuzzyMatch.new(filtered_albums)
        match   = matcher.find(release_group_name)

        # return recording that matched the album found via fuzzy match
        filtered_recordings_via_duration.detect do |r|
          r.release_groups.collect(&:title).include? match
        end
      end

      private

      def filter_recordings_via_duration(duration)
        recordings.select do |r|
          r.duration.present? && (r.duration.to_i - duration) <= DURATION_ACCEPTANCE_RANGE
        end
      end

      def prune_bracketed_string(string)
        string.split(']').collect{ |x| x.split('[')[0] }.join
      end
    end
  end
end
