# frozen_string_literal: true
require 'eivu/eivu-objects'
require 'eivu/fingerprinter/acoustid'
require 'id3tag'

module Eivu
  class Misc
    class << self
      def traverse
        Dir.glob('spec/fixtures/source/**/*mp3').sort.each do |file|
          puts file
          fingerprinter = Eivu::Fingerprinter::Acoustid.new
          fingerprinter.generate(file)
          fingerprinter.submit
          # setup variables
          base_dirname  = File.dirname(file).downcase.gsub(' ','_').gsub(/[^0-9A-Za-z.\-\/_]/, '')
          base_filename = File.basename(file).downcase.gsub("'",'').gsub(/[^0-9A-Za-z.\-]/, '_').gsub('.mp3','')
          # save fingerprint
          dirname = base_dirname.gsub('/source/', '/fingerprints/')
          FileUtils.mkdir_p dirname
          # File.open("#{dirname}/#{base_filename}.txt", 'w') { |f| f.write(fingerprinter.calc_output) }
          # File.open("#{dirname}/#{base_filename}.url", 'w') { |f| f.write(fingerprinter.fingerprint_url) }
          # save acoustid response
          dirname = base_dirname.gsub('/source/', '/responses/acoustid/')
          FileUtils.mkdir_p dirname
          # File.open("#{dirname}/#{base_filename}.json", 'w') { |f| f.write(fingerprinter.response.to_json) }

          # inspect the results
          mp3_file = File.open(file, 'rb')
          tagger   = ID3Tag.read(mp3_file)

          Eivu::Objects::ResultSet.new(fingerprinter.response).results.each do |r|
            puts '--------------'.light_blue
            match = r.best_recording(duration: fingerprinter.duration, release_group_name: tagger.album)
            puts "album: #{match.release_group.title}"
            puts "title: #{match.title}"
            match.print_artists
          end
        end
      end
    end
  end
end
