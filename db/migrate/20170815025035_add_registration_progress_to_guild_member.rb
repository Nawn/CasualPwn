class AddRegistrationProgressToGuildMember < ActiveRecord::Migration[5.1]
  def change
    add_column :guild_members, :registration_progress, :integer
  end
end
