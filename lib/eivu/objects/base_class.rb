# frozen_string_literal: true

module Eivu
  module Objects
    class BaseClass

      def ==(other)
        other.class == self.class && other&.id == id
      end

      def hash
        state.hash
      end

      def state
        instance_variables.map { |variable| instance_variable_get variable }
      end

      # def ==(other)
      #   other.class == self.class && other.state == self.state
      # end

      alias eql?   ==
      alias equal? ==

      private

      def instantiate_artists(artists)
        artists.collect do |a|
          case a.class.name
          when 'Hash'
            Eivu::Objects::Artist.new(**a)
          when 'Eivu::Objects::Artist'
            a
          else
            raise ArgumentError, "Mismatched Type: #{a.class} passed to create artist"
          end
        end
      end
    end
  end
end
