json.extract! guild_event, :id, :start_time, :end_time, :title, :description, :category, :guild_only, :roster_size, :created_at, :updated_at
json.url guild_event_url(guild_event, format: :json)
