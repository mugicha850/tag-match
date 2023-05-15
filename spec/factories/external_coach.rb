FactoryBot.define do
  factory :external_coach do
    # インスタンスを生成
    japanese_user = Gimei.name

    # Faker::Internet.email メソッドに example.com を引数に与えることで、ランダムなアドレスに @example.com を付けることができます。
    email { Faker::Internet.email(domain: 'example.com') }

    family_name { japanese_user.last.kanji }
    given_name { japanese_user.first.kanji }
    family_name_kana { japanese_user.last.katakana }
    given_name_kana { japanese_user.first.katakana }

    # Faker::Alphanumeric.alphanumeric(number: 10)は、長さ10のランダムな英数字を生成します。
    password { Faker::Alphanumeric.alphanumeric(number: 10) }

    # BCrypt::Password.create(password)は、passwordをハッシュ化します。
    hashed_password { BCrypt::Password.create(password) }

    # 2022年1月1日から2022年12月31日までの範囲からランダムな日付を生成しています。
    start_date { Faker::Date.between(from: '2022-01-01', to: '2022-12-31') }
    end_date { Faker::Date.between(from: '2023-01-01', to: '2023-12-31') }
    
    # Faker::Boolean.booleanを使用することで、ランダムな真偽値を返すFakerを作成できます。
    suspended { Faker::Boolean.boolean }
    
    sport_id {1}
    area_id {1}
    #created_at
    #updated_at

    # 18歳以上65歳以下のランダムな誕生日が生成されます。
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }

    # Faker::Gender.binary_typeメソッドを使用することで、ランダムに男女を入力する値を生成することができます。
    sex { Faker::Gender.binary_type }
  end
end
