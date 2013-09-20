class RenamedTokenFromCards < ActiveRecord::Migration
  def up
    remove_column :cards, :token
    add_column :cards, :paymill_token, :string
  end

  def down
    remove_column :cards, :paymill_token
    add_column :cards, :token, :string
  end
end
