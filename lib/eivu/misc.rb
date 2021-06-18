# frozen_string_literal: true
require 'eivu/eivu-objects'
require 'eivu/fingerprinter/acoustid'

module Eivu
  class Misc
    def self.traverse
      Dir.glob('spec/fixtures/source/**/*mp3').sort.each do |file|
        puts file
        fingerprinter = Eivu::Fingerprinter::Acoustid.new
        fingerprinter.generate(file)
        fingerprinter.submit
        # setup variables
        base_dirname  = File.dirname(file).downcase.gsub(' ','_').gsub(/[^0-9A-Za-z.\-\/_]/, '')
        base_filename = File.basename(file).gsub("'",'').gsub(/[^0-9A-Za-z.\-]/, '_').gsub('.mp3','').downcase
        # save fingerprint
        dirname = base_dirname.gsub('/source/', '/fingerprints/')
        FileUtils.mkdir_p dirname
        File.open("#{dirname}/#{base_filename}.txt", 'w') { |f| f.write(fingerprinter.calc_output) }
        # save acoustid response
        dirname = base_dirname.gsub('/source/', '/responses/acoustid/')
        FileUtils.mkdir_p dirname
        File.open("#{dirname}/#{base_filename}.json", 'w') { |f| f.write(fingerprinter.response.to_json) }
      end
    end
  end
end
