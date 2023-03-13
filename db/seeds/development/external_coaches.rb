50.times do |n|
  ExternalCoach.create!(
    email: "coach#{n+1}@example.com",
    family_name: "山田",
    given_name: "太郎",
    family_name_kana: "ヤマダ",
    given_name_kana: "タロウ",
    password: "password",
    start_date: Date.today,
    sport_id: 1,
    area_id: 1
  )
end

ClubAdvisor.create!(
  email: "tanakataro@example.com",
  family_name: "田中",
  given_name: "太郎",
  family_name_kana: "田中",
  given_name_kana: "タロウ",
  password: "password",
  start_date: Date.today,
  sport_id: 1,
  area_id: 1
)

EcArticle.create!(
  title: "テスト",
  body_1: "本文1",
  body_2: "本文2",
  body_3: "本文3",
  released_at: Date.today,
  external_coach_only: 0
)