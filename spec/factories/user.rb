FactoryGirl.define do
  factory :user do
    id '1'
    email 'a@b.com'
    password 'password'
    password_confirmation 'password'
    confirmed_at Date.today
  end
end
