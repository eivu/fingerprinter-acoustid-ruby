# frozen_string_literal: true

require_relative '../objects'

module EivuFingerprinterAcoustid
  module Objects
    class ReleaseGroup < BaseClass
      attr_reader :id, :type, :title, :artists, :secondarytypes

      def initialize(id:, title: ,type: nil, artists: [], secondarytypes: nil)
        @id             = id
        @type           = type
        @title          = title
        @artists        = instantiate_artists(artists)
        @secondarytypes = secondarytypes
      end

      alias secondary_types secondarytypes
    end
  end
end
