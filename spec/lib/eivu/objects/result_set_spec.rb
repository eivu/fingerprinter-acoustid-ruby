# frozen_string_literal: true

require 'spec_helper'
require 'eivu/eivu-objects'

describe Eivu::Objects::ResultSet do
  subject(:instance) { described_class.new(**info) }

  describe '#new' do
    context 'with results' do
      let(:info) do
        Oj.load(
          File.read('spec/fixtures/objects/result_set_01_tank.json')
        ).deep_symbolize_keys
      end

      it 'parses the hash successfully' do
        aggregate_failures do
          expect(instance.results.count).to eq(1)
          expect(instance.results[0].id).to eq('75d9e6c8')
          expect(instance.results[0].recordings[0].id).to eq('72a74c8b')
          expect(instance.results[0].recordings[1].id).to eq('9737ce56')
          expect(instance.results[0].score).to eq(0.999934)
          expect(instance.status).to eq('ok')
        end
      end
    end

    context 'without results' do
      let(:info) { { results: [], status: 'ok' } }

      it 'parses the hash successfully' do
        expect(instance.results.count).to eq(0)
        expect(instance.status).to eq('ok')
      end
    end

    context 'challenge #1 - Ella & Louis - Willow Weep' do
      let(:info) do
        Oj.load(File.read('spec/fixtures/objects/result_set_2-08_willow_weep_for_me.json'))
          .deep_symbolize_keys
      end

      it 'parses the hash successfully' do
        aggregate_failures do
          expect(instance.results.count).to eq(2)
          expect(instance.results[0].id).to eq('cecca08d')
          expect(instance.results[1].id).to eq('de1ef7e2')
        end
      end
    end
  end

  describe 'best match' do
    subject(:best_match) { instance.best_match(duration: duration, release_group_name: album) }

    let(:info) { Oj.load(File.read(file_path)).deep_symbolize_keys }
    let(:instance) { described_class.new(**info) }
    let(:duration) { -1 }

    context 'challenge #1 - Ella & Louis - Willow Weep' do
      let(:file_path) { 'spec/fixtures/objects/result_set_2-08_willow_weep_for_me.json' }
      let(:album) { 'The Complete Ella and Louis on Verve' }
      let(:title) { 'Willow Weep For Me' }

      it 'parses the hash successfully' do
        aggregate_failures do
          expect(best_match.recording.id).to eq('4cde11be')
          expect(best_match.type).to eq('Album')
          expect(best_match.release_group.id).to eq('37012d18')
          expect(best_match.result_score).to eq(0.999934)
          expect(best_match.duration).to eq(259)
          expect(best_match.distance).to eq(0)
          expect(best_match).to be_kind_of(Eivu::Objects::Match)
          expect(best_match.release_group).to be_kind_of(Eivu::Objects::ReleaseGroup)
          expect(best_match.recording).to be_kind_of(Eivu::Objects::Recording)
        end
      end
    end

    context 'challenge #2 - no match found - Above & Beyond - Group Therapy 100 Live at MSQ' do
      let(:file_path) { 'spec/fixtures/objects/result_set_100_live_at_madison_square_garden_abgt10.json' }
      let(:album) { 'Group Therapy' }

      it 'parses the hash successfully' do
        expect(best_match).to be_nil
      end
    end

    context 'challenge #3 - empty file' do
      let(:file_path) { 'spec/fixtures/objects/result_set_empty.json' }
      let(:album) { 'Unknown Album' }

      it 'parses the hash successfully' do
        expect(best_match).to be_nil
      end
    end

    context 'challenge #4 - nil is provided as the album name' do
      let(:file_path) { 'spec/fixtures/objects/result_set_11_someone_like_you_1.json' }
      let(:album) { nil }
      let(:duration) { 287 }

      it 'parses the hash successfully' do
        pending 'need to improve nil matching'
        expect(best_match).to be_kind_of(Eivu::Objects::Match)
      end
    end
  end

  describe 'ok?' do
    subject(:response) { described_class.new(**info).ok? }

    context 'success' do
      let(:info) { { results: [], status: 'ok' } }

      it 'parses the hash successfully' do
        expect(response).to be(true)
      end
    end

    context 'failure' do
      let(:info) { { results: [], status: 'failure' } }

      it 'parses the hash successfully' do
        expect(response).to be(false)
      end
    end
  end
end
