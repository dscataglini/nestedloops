json.extract! todo_item, :id, :description, :completed, :todo_list_id, :timestamps, :created_at, :updated_at
json.url todo_item_url(todo_item, format: :json)
