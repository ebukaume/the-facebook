class CreateFriendships < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships, id: false do |t|
      t.string :id,         null: false
      t.string :user_id,    foreign_key: true
      t.string :friend_id,  foreign_key: true
      t.boolean :confirmed, default: false

      t.timestamps
    end

    add_index :friendships, :id, unique: true
    add_index :friendships, [:user_id, :friend_id]
  end
end
