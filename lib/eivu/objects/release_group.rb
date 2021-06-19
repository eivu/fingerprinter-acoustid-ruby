# frozen_string_literal: true
require 'eivu/eivu-objects'

module Eivu
  module Objects
    class ReleaseGroup < BaseClass
      attr_reader :id, :type, :title, :artists, :secondarytypes

      def initialize(id:, type:, title:, artists: [], secondarytypes: nil)
        @id             = id
        @type           = type
        @title          = title
        @artists        = artists.collect { |a| Eivu::Objects::Artist.new(**a) }
        @secondarytypes = secondarytypes
      end
    end
  end
end
