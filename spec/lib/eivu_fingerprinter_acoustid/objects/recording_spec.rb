# frozen_string_literal: true

require "spec_helper"

describe EivuFingerprinterAcoustid::Objects::Recording do
  describe "#new" do
    context "with proper eivu objects as inputs" do
      subject(:instance) { build(:recording) }

      it "does not raise an error" do
        expect { instance }.not_to raise_error
      end
    end

    context "with improper objects as inputs" do
      context "with invalid artist(s)" do
        subject(:instance) { build(:recording, artists: ["String"]) }

        it "does not raise an error" do
          expect { instance }.to raise_error(ArgumentError, /Mismatched Type:/)
        end
      end

      context "with invalid release_group(s)" do
        subject(:instance) { build(:recording, releasegroups: ["String"]) }

        it "does not raise an error" do
          expect { instance }.to raise_error(ArgumentError, /Mismatched Type:/)
        end
      end
    end

    context "when passing in both release_groups and releasegroups" do
      subject(:instance) { described_class.new(**info) }

      let(:info) do
        {
          id: "111111", title: "today", release_groups: ["X"],
          releasegroups: ["X"], duration: 999
        }
      end

      it "raises an error" do
        expect { instance }.to raise_error(ArgumentError, /can not pass in both/)
      end
    end

    context "when passing in release_groups and NOT releasegroups" do
      subject(:instance) { described_class.new(**info) }

      let(:release_group) { build(:release_group) }
      let(:info) do
        { id: "111111", title: "today", duration: 999, release_groups: [release_group] }
      end

      it "raises an error" do
        expect { instance }.not_to raise_error
      end
    end

    context "when passing in releasegroups and NOT release_groups" do
      subject(:instance) { described_class.new(**info) }

      let(:releasegroup) { build(:releasegroup) }
      let(:info) do
        { id: "111111", title: "today", duration: 999, releasegroups: [releasegroup] }
      end

      it "raises an error" do
        expect { instance }.not_to raise_error
      end
    end

    context "with hashes as inputs" do
      subject(:instance) { described_class.new(**info) }

      context "success" do
        context "with duration" do
          let(:info) do
            Oj.load(
              File.read(
                "spec/fixtures/objects/recording_no-church-in-the-world.short.json"
              )
            ).deep_symbolize_keys
          end

          it "parses the hash successfully" do
            aggregate_failures do
              expect(instance.artists.count).to eq(4)
              expect(instance.artists[0].id).to eq("f82bcf78")
              expect(instance.artists[1].id).to eq("164f0d73")
              expect(instance.artists[2].id).to eq("e520459c")
              expect(instance.artists[3].id).to eq("66a4b9d2")
              expect(instance.duration).to eq(272)
              expect(instance.id).to eq("62851a84")
              expect(instance.release_groups.count).to eq(2)
              expect(instance.release_groups[0].id).to eq("a96597aa")
              expect(instance.release_groups[1].id).to eq("77c0e563")
              expect(instance.title).to eq("No Church in the Wild")
            end
          end
        end

        context "without duration" do
          let(:info) do
            {
              artists: [
                { id: "cc2c9c3c", name: "Adele" }
              ],
              id: "18f547ea",
              releasegroups: [
                {
                  id: "4307ecf9",
                  secondarytypes: ["Soundtrack"],
                  title: "Skyfall",
                  type: "Single"
                }
              ],
              title: "Skyfall (Shahaf Moran Extended Mix)"
            }
          end

          it "parses the hash successfully" do
            aggregate_failures do
              expect(instance.artists.count).to eq(1)
              expect(instance.artists[0].id).to eq("cc2c9c3c")
              expect(instance.duration).to be(nil)
              expect(instance.id).to eq("18f547ea")
              expect(instance.release_groups.count).to eq(1)
              expect(instance.release_groups[0].id).to eq("4307ecf9")
              expect(instance.title).to eq("Skyfall (Shahaf Moran Extended Mix)")
            end
          end
        end
      end
    end
  end

  context "support" do
    let(:info) do
      {
        artists: [{ id: "89a4b9d2", name: "The Dream" }],
        duration: 272,
        id: "12351a84",
        releasegroups: [
          {
            artists: [{ id: "89a4b9d2", name: "The Dream" }],
            id: "a96597aa",
            title: "NYC 2021!!!",
            type: "Album"
          }
        ],
        title: "Mayor of the City"
      }
    end

    context "method aliases" do
      subject(:instance) { described_class.new(**info) }

      it "has the function eql? which is ==" do
        expect(instance.method(:release_groups)).to eq(instance.method(:releasegroups))
      end
    end

    context "inherited functions" do
      let(:fail_id) do
        described_class.new(
          artists: [{ id: "89a4b9d2", name: "The Dream" }],
          duration: 272,
          id: "xxxxxx",
          releasegroups: [
            {
              artists: [{ id: "89a4b9d2", name: "The Dream" }],
              id: "a96597aa",
              title: "NYC 2021!!!",
              type: "Album"
            }
          ],
          title: "Mayor of the City"
        )
      end

      let(:fail_multi) do
        described_class.new(
          artists: [{ id: "89a4b9d2", name: "The Dream" }],
          duration: 272,
          id: "xxxxxx",
          releasegroups: [
            {
              artists: [{ id: "89a4b9d2", name: "The Dream" }],
              id: "a96597aa",
              title: "NYC 2021!!!",
              type: "Album"
            }
          ],
          title: "xxxxxx"
        )
      end

      let(:instance_a) { described_class.new(**info) }
      let(:instance_b) { described_class.new(**info) }

      it_behaves_like "an eivu object base class"
    end
  end
end
