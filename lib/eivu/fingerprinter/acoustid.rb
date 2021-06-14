# frozen_string_literal: true

require 'rest_client'
require 'pry'
require 'oj'

module Eivu
  module Fingerprinter
    class Acoustid
      SERVICE_LOOKUP_URL = 'https://api.acoustid.org/v2/lookup'
      SETTINGS = 'recordings+releasegroups+compress'

      def self.identify(path_to_file = nil)
        instance = new
        instance.generate(path_to_file)
        instance.submit
      end

      def initialize
        @client_id = ENV['ACOUSTID_CLIENT_ID']
      end

      def generate(path_to_file)
        # call fingerprint calculator
        output = execute_binary(path_to_file)
        # output is in the format of:
        # DURATION=267
        # FINGERPRINT=AQADtHKTZFJG7LSwHxeJuGmhj4i6Bj
        info = output.split("\n").each_with_object({}) do |line, hash|
          key, value = line.strip.split('=')
          hash[key.downcase.to_sym] = value
        end
        @fingerprint = info[:fingerprint]
        @duration    = info[:duration]&.to_i
      end

      def submit
        @raw_response = RestClient.get(fingerprint_url)
        @response = Oj.load @raw_response
      end

      def fingerprint_url
        "#{SERVICE_LOOKUP_URL}?client=#{@client_id}&duration=#{@duration}&fingerprint=#{@fingerprint}&meta=#{SETTINGS}"
      end

      private

      def execute_binary(path_to_file)
        `fpcalc "#{path_to_file}"`
      end
    end
  end
end
