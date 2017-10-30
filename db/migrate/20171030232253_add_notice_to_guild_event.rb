class AddNoticeToGuildEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :guild_events, :notice, :integer
  end
end
