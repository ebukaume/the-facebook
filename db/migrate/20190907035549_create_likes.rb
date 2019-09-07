class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes, id: false do |t|
      t.string :id,  null: false
      t.string :liker_id
      t.string :likeable_id
      t.string :likeable_type

      t.timestamps
    end

    add_index :likes, :id, unique: true
    add_index :likes, [:likeable_id, :likeable_type, :liker_id]
  end
end
