# frozen_string_literal: true

require 'spec_helper'
require 'eivu/eivu-objects'

describe Eivu::Objects::Result do
  describe '#new' do
    subject(:instance) { described_class.new(**info) }

    context 'fully populated data' do
      let(:info) do
        Oj.load(File.read('spec/fixtures/objects/result.json'))
          .deep_symbolize_keys
      end

      it 'parses the hash successfully' do
        aggregate_failures do
          expect(instance.recordings.count).to eq(10)
          expect(instance.recordings[0].id).to eq('0731a828')
          expect(instance.recordings[1].id).to eq('18f547ea')
          expect(instance.recordings[2].id).to eq('228c547c')
          expect(instance.recordings[3].id).to eq('31edae1a')
          expect(instance.recordings[4].id).to eq('4dd209b9')
          expect(instance.recordings[5].id).to eq('70f45e42')
          expect(instance.recordings[6].id).to eq('86e5539')
          expect(instance.recordings[7].id).to eq('a89dc25d')
          expect(instance.recordings[8].id).to eq('c676ea1b')
          expect(instance.recordings[9].id).to eq('d74ce039')
          expect(instance.id).to eq('94664ed5')
          expect(instance.score).to eq(0.92972)
        end
      end
    end

    context 'data set only has id' do
      let(:info) { {id: 'dcdb3c23'} }

      it 'parses the hash successfully' do
        aggregate_failures do
          expect(instance.recordings).to be_empty
          expect(instance.id).to eq('dcdb3c23')
          expect(instance.score).to be_nil
        end
      end
    end
  end

  describe '#best_match' do
    subject(:match) do
      # instance.filter(duration: duration, release_name: release_name, release_group_name: album)
      instance.best_match(duration: duration, release_group_name: album)
    end

    let(:instance) { described_class.new(**info) }
    let(:duration) { 178 }
    let(:album) { 'Watch The Throne (Deluxe Edition) [Explicit]' }
    let(:release_name) { 'Otis [feat. Otis Redding] [Explicit]' }
    let(:info) do
      Oj.load(
        File.read('spec/fixtures/objects/result_otis.json')
      ).deep_symbolize_keys
    end

    it 'returns the best recording ' do
      aggregate_failures do
        expect(match).to be_kind_of(Eivu::Objects::Match)
        expect(match.release_group).to be_kind_of(Eivu::Objects::ReleaseGroup)
        expect(match.recording).to be_kind_of(Eivu::Objects::Recording)
        expect(match.recording.id).to eq('e67985c1-4e31-4d7b-b2af-1f97931df3cc')
        expect(match.duration).to eq(178)
        expect(match.title).to eq('Otis')
        expect(match.type).to eq('Album')
        expect(match.secondary_types).to be_nil
      end
    end
  end

  context 'inherited functions' do
    let(:info) { { id: 1231, recordings: [], score: 0.912 } }

    let(:fail_id) do
      described_class.new(id: 'xxxxxx', recordings: [], score: 0.912)
    end

    let(:fail_multi) do
      described_class.new(id: 'xxxxxx', recordings: [], score: 0.2311)
    end

    let(:instance_a) { described_class.new(**info) }
    let(:instance_b) { described_class.new(**info) }

    it_behaves_like 'an eivu object base class'
  end
end
