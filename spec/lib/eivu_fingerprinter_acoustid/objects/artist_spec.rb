# frozen_string_literal: true

require 'spec_helper'

describe EivuFingerprinterAcoustid::Objects::Artist do
  describe '#new' do
    subject(:instance) { described_class.new(**info) }

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

  context 'inherited functions' do
    let(:info) { { id: 'f82bcf78', name: 'Jay-Z' } }
    let(:fail_multi) { described_class.new(id: 'xxxxxxxx', name: 'xxxxxxxx') }
    let(:fail_id)    { described_class.new(id: 'xxxxxxxx', name: 'Jay-Z') }
    let(:instance_a) { described_class.new(**info) }
    let(:instance_b) { described_class.new(**info) }

    it_behaves_like 'an eivu object base class'
  end
end
