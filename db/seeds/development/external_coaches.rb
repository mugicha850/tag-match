1.times do |n|
  CaArticle.create!(
    title: "テスト",
    body_1: "本文1",
    body_2: "本文2",
    body_3: "本文3",
    released_at: Date.today,
    external_coach_only: 0,
    external_coach_id: 1,
    status: "draft"
  )