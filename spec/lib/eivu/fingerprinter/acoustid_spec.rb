# frozen_string_literal: true

require 'spec_helper'
require 'eivu/fingerprinter/acoustid'

describe Eivu::Fingerprinter::Acoustid do
  describe '#identify' do
    subject(:identify) { Eivu::Fingerprinter::Acoustid.identify(file) }

    context 'Adele - Skyfall' do
      context 'sending full file' do
        let(:file) { "/Users/jinx/Dropbox/eivu/sample/library/Adele/Skyfall/01\ -\ Skyfall\ \(Full\ Length\).mp3" }

        context 'success' do
          context 'when passing in audio file' do
            it 'works' do
              expect(identify.dig('status', 'msg')).to eq('Success')
              expect(identify.dig('metadata', 'music', 0, 'acrid')).to eq('90b2803a611bb7015ff71634053a7538')
            end
          end
        end
      end
    end

    context 'Watch the throne - Otis' do
      context 'sending full file' do
        let(:file) { "/Users/jinx/Dropbox/eivu/sample/library/Adele/Skyfall/01\ -\ Skyfall\ \(Full\ Length\).mp3" }

        context 'success' do
          context 'when passing in audio file' do
            it 'works' do
              expect(identify.dig('status', 'msg')).to eq('Success')
              expect(identify.dig('metadata', 'music', 0, 'acrid')).to eq('90b2803a611bb7015ff71634053a7538')
            end
          end
        end
      end
    end
  end
end
