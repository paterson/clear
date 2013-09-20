class RenameTypeToCardTypeInCards < ActiveRecord::Migration
  def up
    add_column :cards, :card_type, :string
    remove_column :cards, :type
  end

  def down
    add_column :cards, :type, :string
    remove_column :cards, :card_type
  end
end
