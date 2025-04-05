# frozen_string_literal: true

require_relative "eivu_fingerprinter_acoustid/version"

require 'zeitwerk'
loader = Zeitwerk::Loader.for_gem
loader.setup # ready!

module EivuFingerprinterAcoustid
  class Error < StandardError; end
end
