# frozen_string_literal: true
require 'eivu/eivu-objects'

module Eivu
  module Objects
    class Recording
      attr_reader :id, :duration, :release_groups, :title, :artists

      def initialize(id:, title:, artists:, duration: nil, releasegroups: nil, release_groups: nil)
        temp_rg = release_groups || releasegroups
        raise ArgumentError, 'releasegroups or release_groups must be passed in' if temp_rg.blank?

        @id             = id
        @duration       = duration
        @release_groups = temp_rg.collect { |rg| Eivu::Objects::ReleaseGroup.new(**rg) }
        @title          = title
        @artists        = artists.collect { |a| Eivu::Objects::Artist.new(**a) }
      end
    end
  end
end
