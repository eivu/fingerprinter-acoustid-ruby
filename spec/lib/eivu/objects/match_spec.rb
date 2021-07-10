# frozen_string_literal: true

require 'spec_helper'
require 'eivu/eivu-objects'

describe Eivu::Objects::Match do
  describe '#new' do
    subject(:instance) do
      described_class.new(release_group: rg, recording: rec.shallow_clone,
                          result_score: score,
                          original_release_group_name: title,
                          matched_release_group_name: title,
                          result_id: result_id)
    end

    let(:rg) { build(:release_group) }
    let(:rec) { build(:recording) }
    let(:score) { 0.87 }
    let(:title) { 'xxxxxx' }
    let(:result_id) { 'xyz123' }

    it 'generates the object successfully' do
      aggregate_failures do
        expect(instance.release_group).to eq(rg)
        expect(instance.recording).to eq(rec)
        expect(instance.result_score).to eq(score)
        expect(instance.result_id).to eq(result_id)
        expect(instance.original_release_group_name).to eq(title)
        expect(instance.matched_release_group_name).to eq(title)
      end
    end
  end

  describe '<=>' do
    subject(:instance_a) { build(:match, result_score: score) }
    subject(:instance_b) { build(:match, result_score: 0.5) }

    context 'when score is higher' do
      let(:score) { 0.9 }

      it 'is greater' do
        expect(instance_a).to be > instance_b
      end
    end

    context 'when score is lower' do
      let(:score) { 0.1 }

      it 'is greater' do
        expect(instance_a).to be < instance_b
      end
    end

    context 'when score is equal' do
      let(:score) { 0.5 }

      it 'is greater' do
        aggregate_failures do
          # tests value (ie compares scores)
          expect(instance_a).to eq(instance_b)
          # tests identity
          expect(instance_a).not_to eql(instance_b)
        end
      end
    end
  end
end
