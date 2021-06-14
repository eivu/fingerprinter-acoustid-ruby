# frozen_string_literal: true

require 'spec_helper'
require 'eivu/fingerprinter/acoustid'

describe Eivu::Fingerprinter::Acoustid do
  describe '#identify' do
    subject(:identify) { Eivu::Fingerprinter::Acoustid.identify(file) }
    let(:file) { "#{label}.mp3" }
    let(:fingerprint) { "#{folder}#{label}.txt" }

    before do
      allow_any_instance_of(described_class)
        .to receive(:execute_binary)
        .and_return(File.read(fingerprint))
    end

    context 'Adele - Skyfall' do
      let(:folder) { 'spec/fixtures/fingerprints/adele/skyfall/' }

      context 'Single Track' do
        let(:label) { '01_skyfall' }

        it 'returns the correct result', vcr: true do
          expect(identify['results'].count).to be(2)
          expect(identify['status']).to eq('ok')
          expect(identify.dig('results', 0, 'id')).to eq('94664ed5-1dc0-4c34-8679-a9b01f671800')
          expect(identify.dig('results', 1, 'id')).to eq('3989d11c-6bec-45fd-b1aa-ffc389d9bcf8')
        end
      end
    end

    context 'Justin Timberlake - Rock Your Body' do
      let(:folder) { 'spec/fixtures/fingerprints/justin_timberlake/justified/' }

      context 'Single Track' do
        let(:label) { '06_rock_your_body' }

        it 'returns the correct result', vcr: true do
          expect(identify['results'].count).to be(2)
          expect(identify['status']).to eq('ok')
          expect(identify.dig('results', 0, 'id')).to eq('7aa7281e-100f-425a-a9d6-0dd7376d6130')
          expect(identify.dig('results', 1, 'id')).to eq('a1b72c00-49ef-4826-8fcb-365f9d80364a')
        end
      end
    end

    context 'Album: Watch the throne' do
      let(:folder) { 'spec/fixtures/fingerprints/watch_the_throne/watch_the_throne/' }

      context '01 - No Church in the wild' do
        let(:label) { '01-01-No Church In The Wild' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(1)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('20daef69-936d-4a94-9ce3-5886b839e5a0')
          end
        end
      end

      context '02 - Lift Off' do
        let(:label) { '01-02- Lift Off' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(1)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('34001c38-a098-44a6-8166-39e03475d18e')
          end
        end
      end

      context '03 - 01-03- Ni**as In Paris' do
        let(:label) { '01-03- Ni**as In Paris' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(2)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('b4c008df-ce21-4950-b7ef-5e7f032bfb32')
            expect(identify.dig('results', 1, 'id')).to eq('1844c1f9-2711-41c5-9064-bb9b1e588bb9')
          end
        end
      end

      context '04 - 01-04- Otis' do
        let(:label) { '01-04- Otis' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(1)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('239f0604-6ad2-43da-8c0a-f5e0e136c4f6')
          end
        end
      end

      context '05 - 01-05- Gotta Have It' do
        let(:label) { '01-05- Gotta Have It' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(1)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('827abdc2-b091-4120-bc74-e2ba4fed5648')
          end
        end
      end

      context '06 - 01-06- New Day' do
        let(:label) { '01-06- New Day' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(1)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('8678e9d3-589f-4763-8a64-ec187ac35000')
          end
        end
      end

      context '07 - 01-07- That s My Bitch' do
        let(:label) { '01-07- That s My Bitch' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(1)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('2d9db730-0d42-455f-bd18-549337553088')
          end
        end
      end

      context '08 - 01-08- Welcome To The Jungle' do
        let(:label) { '01-08- Welcome To The Jungle' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(1)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('e65fc915-e421-414b-85a8-c9450c833ee5')
          end
        end
      end

      context '09 - 01-09- Who Gon Stop Me' do
        let(:label) { '01-09- Who Gon Stop Me' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(2)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('84be67b3-f72b-48fe-ac6e-5ea8cf352f0e')
            expect(identify.dig('results', 1, 'id')).to eq('e28399ce-43a6-49ed-8163-2ba764bb5a0d')
          end
        end
      end

      context '10 - 01-10- Murder To Excellence' do
        let(:label) { '01-10- Murder To Excellence' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(1)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('fc335638-17ab-4c25-bae0-a398d1172470')
          end
        end
      end

      context '11 - 01-11- Made In America' do
        let(:label) { '01-11- Made In America' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(2)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('aceb68bd-1447-4a6d-94b3-438772efbbdd')
            expect(identify.dig('results', 1, 'id')).to eq('99c99bc6-77d4-4163-a9b1-cb4f67aee738')
          end
        end
      end

      context '12 - 01-12- Why I Love You' do
        let(:label) { '01-12- Why I Love You' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(1)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('b78c0699-e46a-4e5b-9433-9fd854376057')
          end
        end
      end

      context '13 - 01-13- Illest Motherf ker Alive' do
        let(:label) { '01-13- Illest Motherf ker Alive' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(0)
            expect(identify['status']).to eq('ok')
          end
        end
      end

      context '01-14- H•A•M' do
        let(:label) { '01-14- H•A•M' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(1)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('a2ea80b3-54e4-4eba-ad1a-362aecb906d2')
          end
        end
      end

      context '15 - 01-15- Primetime' do
        let(:label) { '01-15- Primetime' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(1)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('79ea10ea-db1f-4e4e-906e-08471aa2eddd')
          end
        end
      end

      context '16 - 01-16- The Joy' do
        let(:label) { '01-16- The Joy' }

        it 'returns the correct result', vcr: true do
          aggregate_failures do
            expect(identify['results'].count).to be(1)
            expect(identify['status']).to eq('ok')
            expect(identify.dig('results', 0, 'id')).to eq('3382ca2e-1685-49c9-b27f-00b8abe56b96')
          end
        end
      end
    end
  end
end
