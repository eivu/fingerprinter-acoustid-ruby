FactoryBot.define do
  factory :match, class: Eivu::Objects::Match do
    recording { build(:recording) }
    result_score { rand }
    release_group { build(:release_group) }
    original_release_group_name { 'xxxxxx' }
    matched_release_group_name { 'xxxxxx' }

    initialize_with do
      new(recording: recording, result_score: result_score,
          release_group: release_group,
          original_release_group_name: original_release_group_name,
          matched_release_group_name: matched_release_group_name)
    end
  end
end
