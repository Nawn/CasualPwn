class AddGuildMemberToGuildEvent < ActiveRecord::Migration[5.1]
  def change
    add_reference :guild_events, :guild_member, foreign_key: true
  end
end
