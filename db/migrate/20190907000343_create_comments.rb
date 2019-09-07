class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments, id: false do |t|
      t.string :id,         null: false
      t.string :author_id,  foreign_key: true
      t.string :post_id,    foreign_key: true
      t.string :content

      t.timestamps
    end

    add_index :comments, :id , unique: true
    add_index :comments, [:author_id, :post_id]
  end
end
