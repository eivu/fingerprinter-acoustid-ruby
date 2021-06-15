# frozen_string_literal: true
require 'eivu/objects/artist'

module Eivu
  module Objects
    class ReleaseGroup
      attr_reader :id, :type, :title, :artists, :secondarytypes

      def initialize(id:, type:, title:, artists:, secondarytypes:)
        @id             = id
        @type           = type
        @title          = title
        @artists        = artists.collect { |a| Eivu::Objects::Artist.new(**a) }
        @secondarytypes = secondarytypes
      end
    end
  end
end
