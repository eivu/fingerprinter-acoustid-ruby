# frozen_string_literal: true

require 'spec_helper'
require 'eivu/eivu-objects'

describe Eivu::Objects::Result do
  subject(:instance) { described_class.new(**info) }

  describe '#new' do
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
end
