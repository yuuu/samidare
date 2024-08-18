# frozen_string_literal: true

module Samidare
  # Connection module
  module Packet
    class Packet
      attr_reader :fixed_header

      def initialize(fixed_header)
        @fixed_header = fixed_header
      end
    end
  end
end
