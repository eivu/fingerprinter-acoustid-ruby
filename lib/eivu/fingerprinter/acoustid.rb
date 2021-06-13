# frozen_string_literal: true

require 'rest_client'
require 'pry'
require 'oj'

module Eivu
  module Fingerprinter
    class Acoustid
      # SERVICE_LOOKUP_URL = 'https://api.acoustid.org/v2/lookup'
      # SETTINGS = 'recordings+releasegroups+compress'

      def self.identify(path_to_file = nil)
        instance = new(path_to_file)
        # instance.generate(path_to_file)
        instance.submit
      end

      # def initialize
      #   @client_id = ENV['ACOUSTID_CLIENT_ID']
      # end

      # def generate(path_to_file)
      #   # call fingerprint calculator
      #   output = execute_binary(path_to_file)
      #   # output is in the format of:
      #   # DURATION=267
      #   # FINGERPRINT=AQADtHKTZFJG7LSwHxeJuGmhj4i6Bj
      #   info = output.split("\n").each_with_object({}) do |line, hash|
      #     key, value = line.strip.split('=')
      #     hash[key.downcase.to_sym] = value
      #   end
      #   @fingerprint = info[:fingerprint]
      #   @duration    = info[:duration]&.to_i
      # end

      # def submit
      #   binding.pry
      #   @raw_response = RestClient.get(fingerprint_url)
      #   @response     = Hashie::Mash.new(Oj.load(@raw_response))
      # end

      # private

      # def execute_binary(path_to_file)
      #   `fpcalc "#{path_to_file}"`
      # end

      # def fingerprint_url
      #   "#{SERVICE_LOOKUP_URL}?client=#{@client_id}&#{@duration}=#{@duration}&fingerprint=#{@fingerprint}&meta=#{SETTINGS}"
      # end

      def initialize(path_to_file=nil)
        path_to_file ||= "/home/bobert/files/Kendrick_Lamar_&_The_Weeknd_&_SZA/Black_Panther_The_Album_Music_From_And_Inspired_By_[Explicit]/B078SGLXJR_(disc_1)_03_-_X_[Explicit].mp3"
        @path_to_file = path_to_file
        perform
      end

      def perform
        # call fingerprint calculator
        @output = `fpcalc "#{@path_to_file}"`
        # output is in the format of:
        # DURATION=267
        # FINGERPRINT=AQADtHKTZFJG7LSwHxeJuGmhj4i6Bj
        @output.split("\n").each do |line|
          key, value = line.strip.split("=")
          instance_variable_set("@#{key.downcase}", value)
        end
      end

      def submit
        @fp_url = "https://api.acoustid.org/v2/lookup?client=o4Wf01oR4K&duration=#{@duration}&fingerprint=#{@fingerprint}&meta=recordings+releasegroups+compress"
        @raw_response = RestClient.get @fp_url
        @response = Oj.load @raw_response
      end
    end
  end
end
