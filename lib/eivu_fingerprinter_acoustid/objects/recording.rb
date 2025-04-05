# frozen_string_literal: true

require_relative '../objects'

module EivuFingerprinterAcoustid
  module Objects
    class Recording < BaseClass
      attr_reader :id, :duration, :releasegroups, :title, :artists

      def initialize(id:, title: nil, artists: [], release_groups: [], releasegroups: [], duration: nil)
        if release_groups.present? && releasegroups.present?
          raise ArgumentError, 'can not pass in both release_groups AND releasegroups to constructor'
        end

        @id             = id
        @duration       = duration
        @title          = title
        @artists        = instantiate_artists(artists)
        @releasegroups  = releasegroups.collect do |rg|
          case rg.class.name
          when 'Hash'
            EivuFingerprinterAcoustid::Objects::ReleaseGroup.new(**rg)
          when 'EivuFingerprinterAcoustid::Objects::ReleaseGroup'
            rg
          else
            raise ArgumentError, "Mismatched Type: #{rg.class} passed to create release group"
          end
        end
      end

      # will delete before completion
      def shallow_clone
        EivuFingerprinterAcoustid::Objects::Recording.new(id: id, title: title, artists: artists, releasegroups: [], duration: duration)
      end

      alias release_groups releasegroups
    end
  end
end
