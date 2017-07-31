class CreateGlobalSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :global_settings do |t|
      t.string :tag
      t.text :content

      t.timestamps
    end
  end
end
