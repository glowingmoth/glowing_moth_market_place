json.extract! asset, :id, :title, :description, :content, :price, :created_at, :updated_at
json.url asset_url(asset, format: :json)
