json.array!(@event_comments) do |event_comment|
  json.extract! event_comment, :id, :content, :user_id, :event_id
  json.url event_comment_url(event_comment, format: :json)
end
