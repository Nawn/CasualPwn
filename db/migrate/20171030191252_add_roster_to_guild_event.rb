class AddRosterToGuildEvent < ActiveRecord::Migration[5.1]
  def change
    add_column :guild_events, :roster, :string
  end
end
