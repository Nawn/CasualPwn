class CreateGuildEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :guild_events do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :title
      t.text :description
      t.string :category
      t.boolean :guild_only
      t.integer :roster_size

      t.timestamps
    end
  end
end
