FactoryBot.define do
  factory :match, class: Eivu::Objects::Match do
    recording { build(:recording) }
    result_score { rand }
    release_group { build(:release_group) }
    original_release_group_name { 'xxxxxx' }
    matched_release_group_name { 'xxxxxx' }
    result_id { Faker::Crypto.sha1 }

    initialize_with do
      new(recording: recording, result_score: result_score,
          release_group: release_group,
          original_release_group_name: original_release_group_name,
          matched_release_group_name: matched_release_group_name,
          result_id: result_id)
    end
  end
end
