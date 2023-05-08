FactoryBot.define do
    factory :ca_article do
      # 英数字のランダムな文字列を生成する（100文字）
      title { Faker::Lorem.characters(number: 80) }
      body_1 { Faker::Lorem.characters(number: 2000) }
      body_2 { Faker::Lorem.characters(number: 2000) }
      body_3 { Faker::Lorem.characters(number: 2000) }
      released_at { Faker::Time.between(from: DateTime.now, to: DateTime.now + 1.year) }
      expired_at { Faker::Time.between(from: released_at, to: released_at + 1.year) }
      # club_advisor_only { Faker::Lorem.characters(number: 100) }
      created_at { Faker::Time.between(from: DateTime.now, to: DateTime.now + 1.year) }
      # updated_at { Faker::Lorem.characters(number: 100) }
      club_advisor_id { FactoryBot.create(:club_advisor).id }
      # status { Faker::Base.rand_in_range(["public", "draft"]) }
    end
  end