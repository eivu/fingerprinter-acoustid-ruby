# frozen_string_literal: true

require 'spec_helper'
require 'eivu/objects/release_group'

describe Eivu::Objects::ReleaseGroup do

  describe '#new' do
    subject(:instance) { described_class.new(**info) }

    context 'Audiobook' do
      let(:info) do
        {
          artists: [
            {
              id: 'af70e766',
              joinphrase: ' read by ',
              name: 'Saint Aurelius Augustinus'
            },
            {
              id: 'b238dee7',
              name: 'Bernard Mayes'
            }
          ],
          id: 'c04bec62',
          secondarytypes: ['Audiobook'],
          title: 'The Confessions of Saint Augustine',
          type: 'Other'
        }
      end

      it 'parses the hash successfully' do
        aggregate_failures do
          expect(instance.artists.count).to eq(2)
          expect(instance.artists[0].id).to eq('af70e766')
          expect(instance.artists[1].id).to eq('b238dee7')
          expect(instance.id).to eq('c04bec62')
          expect(instance.secondarytypes).to eq(['Audiobook'])
          expect(instance.title).to eq('The Confessions of Saint Augustine')
          expect(instance.type).to eq('Other')
        end
      end
    end

    context 'Album' do
      let(:info) do
        {
          id: '9d8e1974',
          title: 'Josh White Sings',
          type: 'Album'
        }
      end

      it 'parses the hash successfully' do
        aggregate_failures do
          expect(instance.artists).to be_empty
          expect(instance.id).to eq('9d8e1974')
          expect(instance.title).to eq('Josh White Sings')
          expect(instance.type).to eq('Album')
        end
      end
    end
  end

  context 'method aliases' do
    subject(:instance) { described_class.new(**info) }

    let(:info) { { id: '9d8e1974', title: 'Josh White Sings', type: 'Album' } }

    it 'has the function eql? which is ==' do
      expect(instance.method(:secondary_types)).to eq(instance.method(:secondarytypes))
    end
  end

  context 'inherited functions' do
    let(:info) do
      {
        artists: [ { id: 'af70e766', name: 'Saint A.' } ],
        id: 'af70e766',
        title: 'The Confessions of Saint Augustine'
      }
    end

    let(:fail_id) do 
      described_class.new(
        artists: [{ id: 'af70e766', name: 'Saint A.' }],
        id: 'xxxxxx',
        title: 'The Confessions of Saint Augustine'
      )
    end

    let(:fail_multi) do 
      described_class.new(
        artists: [{ id: 'af70e766', name: 'Saint A.' }],
        id: 'xxxxxx',
        title: 'xxxxxx'
      )
    end

    let(:instance_a) { described_class.new(**info) }
    let(:instance_b) { described_class.new(**info) }

    it_behaves_like 'an eivu object base class'
  end
end
