class AddedTokenToCard < ActiveRecord::Migration
  def up
    add_column :cards, :token, :string
  end

  def down
    remove_column :cards, :token
  end
end
