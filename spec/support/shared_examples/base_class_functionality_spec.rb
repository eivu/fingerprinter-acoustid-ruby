RSpec.shared_examples 'an eivu object base class' do

  describe 'inherited functions' do
    describe '==' do
      context 'success' do
        it 'knows when objects are the same' do
          expect(instance_a == instance_b).to be(true)
        end
      end

      context 'failure' do
        let(:struct) { OpenStruct.new(id: instance_a.id) }

        it 'knows when objects differ only by id' do
          expect(instance_a).not_to eq(fail_id)
        end

        it 'knows when objects differ by multiple attributes' do
          expect(instance_a).not_to eq(fail_multi)
        end

        it 'knows when objects have same id but are different classes' do
          aggregate_failures do
            expect(instance_a).not_to eq(struct)
            expect { instance_a == struct }.not_to raise_error
          end
        end

        it 'can compare an object and an integer' do
          aggregate_failures do
            expect(instance_a).not_to eq(1)
            expect { instance_a == 1 }.not_to raise_error
          end
        end

        it 'can compare an object and nil' do
          aggregate_failures do
            expect(instance_a).not_to eq(1)
            expect { instance_a == nil }.not_to raise_error
          end
        end
      end

      context 'method aliases' do
        it 'has the function eql? which is ==' do
          expect(instance_a.method(:eql?)).to eq(instance_a.method(:==))
        end

        it 'has the function equal? which is ==' do
          expect(instance_a.method(:eql?)).to eq(instance_a.method(:==))
        end
      end
    end
  end
end
