class CreatePolls < ActiveRecord::Migration[5.2]
  def change
    create_table :polls do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.timestamps
    end

    add_index :polls, :user_id
    add_index :polls, :title
  end
end