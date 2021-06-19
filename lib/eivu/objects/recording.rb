# frozen_string_literal: true
require 'eivu/eivu-objects'

module Eivu
  module Objects
    class Recording < BaseClass
      attr_reader :id, :duration, :releasegroups, :title, :artists

      def initialize(id:, title:, artists:, releasegroups:, duration: nil)
        @id             = id
        @duration       = duration
        @releasegroups  = releasegroups.collect { |rg| Eivu::Objects::ReleaseGroup.new(**rg) }
        @title          = title
        @artists        = artists.collect { |a| Eivu::Objects::Artist.new(**a) }
      end

      alias release_groups releasegroups
    end
  end
end
