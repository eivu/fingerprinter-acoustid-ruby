# frozen_string_literal: true
require 'eivu/eivu-objects'

module Eivu
  module Objects
    class Recording < BaseClass
      attr_reader :id, :duration, :releasegroups, :title, :artists

      def initialize(id:, title: nil, artists: [], releasegroups: [], duration: nil)
        @id             = id
        @duration       = duration
        @title          = title
        @releasegroups  = releasegroups.collect do |rg|
          case rg.class.name
          when 'Hash'
            Eivu::Objects::ReleaseGroup.new(**rg)
          when 'Eivu::Objects::Artist'
            rg
          else
            raise "Unknown Type: #{rg.class}"
          end
        end
        @artists = artists.collect do |a|
          case a.class.name
          when 'Hash'
            Eivu::Objects::Artist.new(**a)
          when 'Eivu::Objects::Artist'
            a
          else
            raise "Unknown Type: #{a.class}"
          end
        end
      end

      def shallow_clone
        Eivu::Objects::Recording.new(id: id, title: title, artists: artists, releasegroups: [], duration: duration)
      end

      alias release_groups releasegroups
    end
  end
end
