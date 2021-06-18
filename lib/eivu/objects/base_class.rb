# frozen_string_literal: true

module Eivu
  module Objects
    class BaseClass
      # alias eql?  ==
      # alias equal ==

      def ==(other)
        other.class == self.class && other&.id == id
      end

      # def eql?(other)
      #   self == other
      # end

      def hash
        state.hash
      end

      # def ==(other)
      #   other.class == self.class && other.state == self.state
      # end

      # def state
      #   self.instance_variables.map { |variable| self.instance_variable_get variable }
      # end

      alias_method :eql?,  :==
      alias_method :equal?, :==
    end
  end
end
