FactoryBot.define do
  factory :release_group, class: EivuFingerprinterAcoustid::Objects::ReleaseGroup, aliases: [:releasegroup] do
    id { Faker::Crypto.sha1 }
    type { %w[Album Single].sample }
    title { Faker::Music.album }
    artists do
      rand(1..3).times.map { build(:artist) }
    end
    # secondarytypes { [] }

    initialize_with { new(id: id, type: type, title: title, artists: artists) }
  end
end
