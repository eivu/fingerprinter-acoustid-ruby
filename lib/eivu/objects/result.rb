# frozen_string_literal: true

require_relative '../eivu-objects'

module Eivu
  module Objects
    class Result < BaseClass
      DURATION_ACCEPTANCE_RANGE = 15
      attr_reader :id, :recordings, :score

      def initialize(id:, recordings: [], score: nil)
        @id             = id
        @recordings     = recordings.collect { |r| Eivu::Objects::Recording.new(**r) }
        @score          = score
      end

      def generate_match(duration:, release_group_name: nil)
        filtered_recordings = filter_empty_recordings(recordings)

        if release_group_name.present?
          filter_recordings_via_release_group_name(filtered_recordings, release_group_name)
        elsif duration.present?
          filter_recordings_via_duration(filtered_recordings, duration)
        else
          nil
        end
      end

      def recordings?
        @has_recordings ||= recordings.present?
      end

      def no_recordings?
        @no_recordings ||= !recordings?
      end

      private

      def filter_recordings_via_duration(tmp_recordings, duration)
        tmp_recordings.filter do |r|
          r.duration.present? && (r.duration.to_i - duration) <= DURATION_ACCEPTANCE_RANGE
        end.first
        # data = tmp_recordings.filter do |r|
        #   r.duration.present? && (r.duration.to_i - duration) <= DURATION_ACCEPTANCE_RANGE
        # end
        # rg = data.sort do |a, b|
        #   (a.duration.to_i - duration).abs <=> (b.duration.to_i - duration).abs
        # end.last
      end

      def filter_recordings_via_release_group_name(tmp_recordings, release_group_name)
        filtered_albums = tmp_recordings.flat_map do |r|
          r.release_groups.collect(&:title)
        end

        # match album via fuzzy match
        matcher = FuzzyMatch.new(filtered_albums)
        match   = matcher.find(release_group_name)

        # return recording that matched the album found via fuzzy match
        tmp_recordings.each do |rec|
          rec.release_groups.each do |rg|
            if rg.title == match
              return Eivu::Objects::Match.new(release_group: rg,
                        recording: rec.shallow_clone,
                        result_score: score,
                        original_release_group_name: release_group_name,
                        matched_release_group_name: match,
                        result_id: id)
            end
          end
        end
        nil
      end

      def filter_empty_recordings(tmp_recordings)
        tmp_recordings.select { |r| r.title.present? }
      end

      def prune_bracketed_string(string)
        string.split(']').collect{ |x| x.split('[')[0] }.join
      end
    end
  end
end
