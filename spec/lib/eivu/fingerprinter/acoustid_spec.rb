# frozen_string_literal: true

require 'spec_helper'
require 'eivu/fingerprinter/acoustid'

describe Eivu::Fingerprinter::Acoustid do
  describe '#identify' do
    subject(:identify) { Eivu::Fingerprinter::Acoustid.identify(file) }

    context 'Adele - Skyfall' do
      context 'sending full file' do
        let(:fingerprint) { 'spec/fixtures/fingerprints/01_skyfall.txt' }
        let(:file) { 'skyfall.mp3' }

        before do
          allow_any_instance_of(described_class)
            .to receive(:execute_binary)
            .and_return(File.read(fingerprint))
        end

        context 'success' do
          context 'when passing in audio file' do
            it 'works' do
              expect(identify['results'].count).to be(2)
              expect(identify['status']).to eq('ok')
              expect(identify.dig('results', 0, 'id')).to eq('94664ed5-1dc0-4c34-8679-a9b01f671800')
              expect(identify.dig('results', 1, 'id')).to eq('3989d11c-6bec-45fd-b1aa-ffc389d9bcf8')
            end
          end
        end
      end
    end

    context 'Watch the throne - Otis' do
      context 'sending full file' do
        let(:file) { "/Users/jinx/Dropbox/eivu/sample/library/Jay-Z\ \&\ Kanye\ West/Watch\ The\ Throne\ \(Deluxe\ Edition\)\ \[Explicit\]/01-11-\ Made\ In\ America\ \[feat\ Frank\ Ocean\]\ \[Explicit\].mp3" }

        context 'success' do
          context 'when passing in audio file' do
            it 'works' do
              expect(identify['results'].count).to be(2)
              expect(identify['status']).to eq('ok')
              expect(identify.dig('results', 0, 'id')).to eq('aceb68bd-1447-4a6d-94b3-438772efbbdd')
              expect(identify.dig('results', 1, 'id')).to eq('99c99bc6-77d4-4163-a9b1-cb4f67aee738')
            end
          end
        end
      end
    end
  end
end
