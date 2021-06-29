# frozen_string_literal: true
require 'eivu/eivu-objects'
require 'eivu-fingerprinter-acoustid'
require 'id3tag'

module Eivu
  class Misc
    class << self
      def file_paths_for(file)
        base_dirname = File.dirname(file).downcase.gsub(' ', '_')
        base_filename = File.basename(file).downcase.gsub(' ', '_')

        {
          vcr: "#{base_dirname.gsub('fixtures/source/','')}/#{base_filename}"
        }
      end

      def store_data_for(fingerprint, file)
        # setup variables
      #   base_dirname  = File.dirname(file).downcase.gsub(' ','_').gsub(/[^0-9A-Za-z.\-\/_]/, '')
      #   base_filename = File.basename(file).downcase.gsub("'",'').gsub(/[^0-9A-Za-z.\-]/, '_').gsub('.mp3','')

      #   # create fingerprint dir
      #   dirname = base_dirname.gsub('/source/', '/fingerprints/')
      #   FileUtils.mkdir_p dirname

      #   # next if File.exists?("#{dirname}/#{base_filename}.txt")
      #   File.open("#{dirname}/#{base_filename}.txt", 'w') { |f| f.write(fingerprint.calc_output) }
      #   File.open("#{dirname}/#{base_filename}.url", 'w') { |f| f.write(fingerprint.cleansed_fingerprint_url) }
      #   # save acoustid response
      #   dirname = base_dirname.gsub('/source/', '/responses/acoustid/')
      #   FileUtils.mkdir_p dirname
      #   File.open("#{dirname}/#{base_filename}.json", 'w') { |f| f.write(fingerprint.response.to_json) }
      end

      # def traverse
      #   Dir.glob('spec/fixtures/source/**/*mp3').sort.each do |file|
      #     puts file
      #     # setup variables
      #     base_dirname  = File.dirname(file).downcase.gsub(' ','_').gsub(/[^0-9A-Za-z.\-\/_]/, '')
      #     base_filename = File.basename(file).downcase.gsub("'",'').gsub(/[^0-9A-Za-z.\-]/, '_').gsub('.mp3','')
      #     # save fingerprint
      #     dirname = base_dirname.gsub('/source/', '/fingerprints/')
      #     FileUtils.mkdir_p dirname

      #     next if File.exists?("#{dirname}/#{base_filename}.txt")
      #     # File.open("#{dirname}/#{base_filename}.txt", 'w') { |f| f.write(fingerprint.calc_output) }
      #     # File.open("#{dirname}/#{base_filename}.url", 'w') { |f| f.write(fingerprint.fingerprint_url) }
      #     # save acoustid response
      #     dirname = base_dirname.gsub('/source/', '/responses/acoustid/')
      #     FileUtils.mkdir_p dirname
      #     # File.open("#{dirname}/#{base_filename}.json", 'w') { |f| f.write(fingerprint.response.to_json) }

      #     # inspect the results
      #     mp3_file = File.open(file, 'rb')
      #     tagger   = ID3Tag.read(mp3_file)

      #     sleep(0.5)
      #     fingerprint = Eivu::fingerprint::Acoustid.new
      #     fingerprint.generate(file)
      #     fingerprint.submit

      #     result_set = Eivu::Objects::ResultSet.new(fingerprint.response)
      #     match = result_set.best_match(duration: fingerprint.duration, release_group_name: tagger.album)
      #     puts "rec id: #{match.recording.id}"
      #     puts "album: #{match.release_group.title}"
      #     puts "title: #{match.title}"
      #     match.print_artists
      #     puts '--------------'.light_blue
      #   end
      # end
    end
  end
end
