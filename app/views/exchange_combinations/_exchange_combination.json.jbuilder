json.extract! exchange_combination,
              :id, :base, :target, :amount, :wait, :created_at, :updated_at
json.url exchange_combination_url(exchange_combination, format: :json)
