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

        fingerprinter = Eivu::Fingerprinter::Acoustid.new
        fingerprinter.generate(file)
        fingerprinter.submit

        described_class.store_data_for(fingerprinter, file)
        sleep(snooze_duration)
        result_set = Eivu::Objects::ResultSet.new(fingerprinter.response)
        match = result_set.best_match(duration: fingerprinter.duration, release_group_name: tagger.album)
        puts "rec id: #{match.recording.id}"
        puts "album: #{match.release_group.title}"
        puts "title: #{match.title}"
        match.print_artists
        puts '--------------'.light_blue
      end
    end
  end

end
