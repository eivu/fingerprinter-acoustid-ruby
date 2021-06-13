# frozen_string_literal: true

require 'spec_helper'
require 'eivu/fingerprinter/acoustid'

describe Eivu::Fingerprinter::Acoustid do
  describe '#identify' do
    subject(:identify) { Eivu::Fingerprinter::Acoustid.identify(file) }

    before do
      allow_any_instance_of(described_class)
        .to receive(:execute_binary)
        .and_return(File.read(fingerprint))
    end

    context 'Adele - Skyfall' do
      context 'sending full file' do
        let(:fingerprint) { 'spec/fixtures/fingerprints/01_skyfall.txt' }
        let(:file) { 'skyfall.mp3' }

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

    context 'Album: Watch the throne' do
      let(:folder) { 'spec/fixtures/fingerprints/watch_the_throne/watch_the_throne/' }

      context '01 - No Church in the wild ' do
        let(:file) { 'No Church In The Wild.mp3' }
        let(:fingerprint) { "#{folder}01-01-No Church In The Wild.txt" }

        it 'returns the correct result' do
          aggregate_failures do
            expect(identify['results'].count).to be(1)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('20daef69-936d-4a94-9ce3-5886b839e5a0')
          end
        end
      end

      context '02 - Lift Off' do
        let(:file) { '01-02- Lift Off.mp3' }
        let(:fingerprint) { "#{folder}01-02- Lift Off.txt" }

        it 'returns the correct result' do
          aggregate_failures do
            expect(identify['results'].count).to be(1)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('34001c38-a098-44a6-8166-39e03475d18e')
          end
        end
      end

      context '03 - 01-03- Ni**as In Paris' do
        let(:file) { '01-03- Ni**as In Paris.mp3' }
        let(:fingerprint) { "#{folder}01-03- Ni**as In Paris.txt" }

        it 'returns the correct result' do
          aggregate_failures do
            expect(identify['results'].count).to be(2)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('b4c008df-ce21-4950-b7ef-5e7f032bfb32')
            expect(identify.dig('results', 1, 'id')).to eq('1844c1f9-2711-41c5-9064-bb9b1e588bb9')
          end
        end
      end

      # context '04 - 01-03- Ni**as In Paris' do
      #   let(:file) { '01-03- Ni**as In Paris.mp3' }
      #   let(:fingerprint) { "#{folder}01-03- Ni**as In Paris.txt" }

      #   it 'returns the correct result' do
      #     aggregate_failures do
      #       expect(identify['results'].count).to be(2)
      #       expect(identify['status']).to eq('ok')
      #       expect(identify.dig('results', 0, 'id')).to eq('wrong')
      #       expect(identify.dig('results', 1, 'id')).to eq('wrong')
      #     end
      #   end
      # end

      # context '05 - 01-03- Ni**as In Paris' do
      #   let(:file) { '01-03- Ni**as In Paris.mp3' }
      #   let(:fingerprint) { "#{folder}01-03- Ni**as In Paris.txt" }

      #   it 'returns the correct result' do
      #     aggregate_failures do
      #       expect(identify['results'].count).to be(2)
      #       expect(identify['status']).to eq('ok')
      #       expect(identify.dig('results', 0, 'id')).to eq('wrong')
      #       expect(identify.dig('results', 1, 'id')).to eq('wrong')
      #     end
      #   end
      # end

      # context '06 - 01-03- Ni**as In Paris' do
      #   let(:file) { '01-03- Ni**as In Paris.mp3' }
      #   let(:fingerprint) { "#{folder}01-03- Ni**as In Paris.txt" }

      #   it 'returns the correct result' do
      #     aggregate_failures do
      #       expect(identify['results'].count).to be(2)
      #       expect(identify['status']).to eq('ok')
      #       expect(identify.dig('results', 0, 'id')).to eq('wrong')
      #       expect(identify.dig('results', 1, 'id')).to eq('wrong')
      #     end
      #   end
      # end

      # context '07 - 01-03- Ni**as In Paris' do
      #   let(:file) { '01-03- Ni**as In Paris.mp3' }
      #   let(:fingerprint) { "#{folder}01-03- Ni**as In Paris.txt" }

      #   it 'returns the correct result' do
      #     aggregate_failures do
      #       expect(identify['results'].count).to be(2)
      #       expect(identify['status']).to eq('ok')
      #       expect(identify.dig('results', 0, 'id')).to eq('wrong')
      #       expect(identify.dig('results', 1, 'id')).to eq('wrong')
      #     end
      #   end
      # end

      # context '08 - 01-03- Ni**as In Paris' do
      #   let(:file) { '01-03- Ni**as In Paris.mp3' }
      #   let(:fingerprint) { "#{folder}01-03- Ni**as In Paris.txt" }

      #   it 'returns the correct result' do
      #     aggregate_failures do
      #       expect(identify['results'].count).to be(2)
      #       expect(identify['status']).to eq('ok')
      #       expect(identify.dig('results', 0, 'id')).to eq('wrong')
      #       expect(identify.dig('results', 1, 'id')).to eq('wrong')
      #     end
      #   end
      # end

      # context '09 - 01-03- Ni**as In Paris' do
      #   let(:file) { '01-03- Ni**as In Paris.mp3' }
      #   let(:fingerprint) { "#{folder}01-03- Ni**as In Paris.txt" }

      #   it 'returns the correct result' do
      #     aggregate_failures do
      #       expect(identify['results'].count).to be(2)
      #       expect(identify['status']).to eq('ok')
      #       expect(identify.dig('results', 0, 'id')).to eq('wrong')
      #       expect(identify.dig('results', 1, 'id')).to eq('wrong')
      #     end
      #   end
      # end

      # context '10 - 01-03- Ni**as In Paris' do
      #   let(:file) { '01-03- Ni**as In Paris.mp3' }
      #   let(:fingerprint) { "#{folder}01-03- Ni**as In Paris.txt" }

      #   it 'returns the correct result' do
      #     aggregate_failures do
      #       expect(identify['results'].count).to be(2)
      #       expect(identify['status']).to eq('ok')
      #       expect(identify.dig('results', 0, 'id')).to eq('wrong')
      #       expect(identify.dig('results', 1, 'id')).to eq('wrong')
      #     end
      #   end
      # end

      # context '11 - 01-03- Ni**as In Paris' do
      #   let(:file) { '01-03- Ni**as In Paris.mp3' }
      #   let(:fingerprint) { "#{folder}01-03- Ni**as In Paris.txt" }

      #   it 'returns the correct result' do
      #     aggregate_failures do
      #       expect(identify['results'].count).to be(2)
      #       expect(identify['status']).to eq('ok')
      #       expect(identify.dig('results', 0, 'id')).to eq('wrong')
      #       expect(identify.dig('results', 1, 'id')).to eq('wrong')
      #     end
      #   end
      # end

      # context '12 - 01-03- Ni**as In Paris' do
      #   let(:file) { '01-03- Ni**as In Paris.mp3' }
      #   let(:fingerprint) { "#{folder}01-03- Ni**as In Paris.txt" }

      #   it 'returns the correct result' do
      #     aggregate_failures do
      #       expect(identify['results'].count).to be(2)
      #       expect(identify['status']).to eq('ok')
      #       expect(identify.dig('results', 0, 'id')).to eq('wrong')
      #       expect(identify.dig('results', 1, 'id')).to eq('wrong')
      #     end
      #   end
      # end

      # context '13 - 01-03- Ni**as In Paris' do
      #   let(:file) { '01-03- Ni**as In Paris.mp3' }
      #   let(:fingerprint) { "#{folder}01-03- Ni**as In Paris.txt" }

      #   it 'returns the correct result' do
      #     aggregate_failures do
      #       expect(identify['results'].count).to be(2)
      #       expect(identify['status']).to eq('ok')
      #       expect(identify.dig('results', 0, 'id')).to eq('wrong')
      #       expect(identify.dig('results', 1, 'id')).to eq('wrong')
      #     end
      #   end
      # end

      # context '14 - 01-03- Ni**as In Paris' do
      #   let(:file) { '01-03- Ni**as In Paris.mp3' }
      #   let(:fingerprint) { "#{folder}01-03- Ni**as In Paris.txt" }

      #   it 'returns the correct result' do
      #     aggregate_failures do
      #       expect(identify['results'].count).to be(2)
      #       expect(identify['status']).to eq('ok')
      #       expect(identify.dig('results', 0, 'id')).to eq('wrong')
      #       expect(identify.dig('results', 1, 'id')).to eq('wrong')
      #     end
      #   end
      # end

      # context '15 - 01-03- Ni**as In Paris' do
      #   let(:file) { '01-03- Ni**as In Paris.mp3' }
      #   let(:fingerprint) { "#{folder}01-03- Ni**as In Paris.txt" }

      #   it 'returns the correct result' do
      #     aggregate_failures do
      #       expect(identify['results'].count).to be(2)
      #       expect(identify['status']).to eq('ok')
      #       expect(identify.dig('results', 0, 'id')).to eq('wrong')
      #       expect(identify.dig('results', 1, 'id')).to eq('wrong')
      #   end
      # end

      # context '16 - 01-03- Ni**as In Paris' do
      #   let(:file) { '01-03- Ni**as In Paris.mp3' }
      #   let(:fingerprint) { "#{folder}01-03- Ni**as In Paris.txt" }

      #   it 'returns the correct result' do
      #     aggregate_failures do
      #       expect(identify['results'].count).to be(2)
      #       expect(identify['status']).to eq('ok')
      #       expect(identify.dig('results', 0, 'id')).to eq('wrong')
      #       expect(identify.dig('results', 1, 'id')).to eq('wrong')
      #     end
      #   end
      # end
    end
  end
end
