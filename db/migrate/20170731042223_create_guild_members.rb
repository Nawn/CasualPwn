class CreateGuildMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :guild_members do |t|
      t.string :username
      t.string :discord_id
      t.string :password_digest
      t.string :confirm_token
      t.string :guild_wars_username
      t.string :discord_nick
      t.integer :guild_rank

      t.timestamps
    end
    add_index :guild_members, :username
    add_index :guild_members, :discord_id, unique: true
    add_index :guild_members, :confirm_token
    add_index :guild_members, :guild_wars_username, unique: true
  end
end
