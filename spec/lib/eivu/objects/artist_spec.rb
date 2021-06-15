# frozen_string_literal: true

require 'spec_helper'
require 'eivu/objects/artist'

describe Eivu::Objects::Artist do
  subject(:instance) { described_class.new(**info) }

  describe '#new' do
    context 'Single Artist' do
      let(:info) { { id: 'f82bcf78', name: 'Jay-Z' } }

      it 'parses the hash successfully' do
        aggregate_failures do
          expect(instance.id).to eq('f82bcf78')
          expect(instance.name).to eq('Jay-Z')
        end
      end
    end

    context 'Single Artist' do
      let(:info) { { id: 'f82bcf78', name: 'Jay-Z', joinphrase: ' & ' } }

      it 'parses the hash successfully' do
        aggregate_failures do
          expect(instance.id).to eq('f82bcf78')
          expect(instance.name).to eq('Jay-Z')
          expect(instance.joinphrase).to eq(' & ')
        end
      end
    end
  end
end