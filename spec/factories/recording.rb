FactoryBot.define do
  factory :recording, class: EivuFingerprinterAcoustid::Objects::Recording do
    id { Faker::Crypto.sha1 }
    title { Faker::Book.title }
    artists do
      rand(1..3).times.map { build(:artist) }
    end
    releasegroups do
      rand(1..3).times.map { build(:releasegroup) }
    end
    duration { rand(45..3000) }

    initialize_with { new(id: id, title: title, artists: artists, releasegroups: releasegroups, duration: duration) }
  end
end
