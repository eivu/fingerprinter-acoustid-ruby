FactoryBot.define do
  factory :artist, class: EivuFingerprinterAcoustid::Objects::Artist do
    id { Faker::Crypto.sha1 }
    name { Faker::Music.band }
    joinphrase { nil }

    trait :with_joinphrase do
      joinphrase { ' & '}
    end

    initialize_with { new(id: id, name: name, joinphrase: joinphrase) }
  end
end
