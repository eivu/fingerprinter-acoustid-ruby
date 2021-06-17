# frozen_string_literal: true

require 'spec_helper'
require 'eivu/eivu-objects'

describe Eivu::Objects::Recording do
  subject(:instance) { described_class.new(**info) }

  describe '#new' do
    describe 'success' do
      let(:info) {
        Oj.load(
          File.read(
            'spec/fixtures/objects/recording_no-church-in-the-world.short.json'
          )
        ).deep_symbolize_keys
      }

      it 'parses the hash successfully' do
        aggregate_failures do
          expect(instance.artists.count).to eq(4)
          expect(instance.artists[0].id).to eq('f82bcf78')
          expect(instance.artists[1].id).to eq('164f0d73')
          expect(instance.artists[2].id).to eq('e520459c')
          expect(instance.artists[3].id).to eq('66a4b9d2')
          expect(instance.duration).to eq(272)
          expect(instance.id).to eq('62851a84')
          expect(instance.release_groups[0].id).to eq('a96597aa')
          expect(instance.release_groups[1].id).to eq('77c0e563')
          expect(instance.title).to eq('No Church in the Wild')
        end
      end
    end

    describe 'failure' do
      let(:info) do
        {
          artists: [
            {
              id: 'f82bcf78',
              name: 'Jay-Z'
            }
          ],
          duration: 272,
          id: '62851a84',
          title: 'No Church in the Wild'
        }
      end

      it 'fails to parse the hash successfully' do
        expect { instance }.to raise_error(ArgumentError, /releasegroups or release_groups must be passed in/)
      end
    end
  end
end