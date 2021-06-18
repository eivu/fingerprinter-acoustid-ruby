# frozen_string_literal: true

module Eivu
  module Objects
    class BaseClass
      alias_method :eql?, :==

      def ==(other)
        other.class == self.class && other&.id == id
      end

      def hash
        state.hash
      end

      # def ==(other)
      #   other.class == self.class && other.state == self.state
      # end

      # def state
      #   self.instance_variables.map { |variable| self.instance_variable_get variable }
      # end
    end
  end
end
