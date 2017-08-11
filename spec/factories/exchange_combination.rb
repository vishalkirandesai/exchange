FactoryGirl.define do
  factory :exchange_combination do
    id '1'
    base 'AUD'
    target 'HUF'
    wait '12'
    amount '25'
  end
end