class AddGuildOnlyToPost < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :guild_only, :boolean
  end
end
