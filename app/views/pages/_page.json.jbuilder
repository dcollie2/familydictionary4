json.extract! page, :id, :permalink, :title, :contents, :created_at, :updated_at
json.url page_url(page, format: :json)
json.contents page.contents.to_s
