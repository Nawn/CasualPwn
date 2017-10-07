class AddGuildMemberRefToPosts < ActiveRecord::Migration[5.1]
  def change
    add_reference :posts, :guild_member, foreign_key: true
  end
end
