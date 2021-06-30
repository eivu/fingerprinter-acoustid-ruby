# frozen_string_literal: true

require 'spec_helper'
require 'eivu/misc'
require 'eivu/eivu-objects'
require 'eivu/fingerprinter/acoustid'


describe Eivu::Misc do
  subject(:traversal) { described_class.traverse }
  let(:snooze_duration) { 0.25 }

  # describe '.traverse' do
  #   it 'works', vcr: true do
  #     traversal
  #   end
  # end

  describe '.inspect' do
    Dir.glob('spec/fixtures/source/**/*mp3').sort.each do |file|
      it "finds the best match for #{Eivu::Misc.file_paths_for(file)[:vcr]}", vcr: true do
        puts file
        mp3_file    = File.open(file, 'rb')
        tagger      = ID3Tag.read(mp3_file)
        response_path = Eivu::Misc.file_paths_for(file)[:response]

        fingerprinter = Eivu::Fingerprinter::Acoustid.new
        if File.exists?(response_path)
          response = Oj.load(File.read(response_path)).deep_symbolize_keys
          puts "skipping......."
        else
          sleep(snooze_duration)
          fingerprinter.generate(file)
          fingerprinter.submit
          response = fingerprinter.response
          described_class.store_data_for(fingerprinter, file)
        end

        result_set = Eivu::Objects::ResultSet.new(response)
        match = result_set.best_match(duration: fingerprinter&.duration, release_group_name: tagger.album)
        puts "rec id: #{match.recording.id}"
        puts "album: #{match.release_group.title}"
        puts "orig: #{tagger.album}" 
        puts "title: #{match.title}"
        puts "distance: #{Levenshtein.distance(tagger.album&.downcase, match.release_group.title&.downcase)}"
        puts '--------------'.light_blue
      end
    end
  end
end
