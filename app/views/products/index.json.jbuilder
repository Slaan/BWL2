json.array!(@products) do |product|
  json.extract! product, :id, :name, :description, :price, :amount, :since, :until
  json.url product_url(product, format: :json)
end
