# frozen_string_literal: true

json.products do
  json.array!(@products) do |product|
    json.name product.product_name
    json.url product_path(product)
  end
end
