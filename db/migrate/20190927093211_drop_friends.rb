class DropFriends < ActiveRecord::Migration[5.2]
  def up
    drop_table :friends
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
