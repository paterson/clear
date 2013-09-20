class AddedNameToCard < ActiveRecord::Migration
  def up
    add_column :cards, :name, :string
  end

  def down
    remove_column :cards, :name
  end
end
