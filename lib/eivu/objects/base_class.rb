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
    end
  end
end
