class ChangeUserIdInCardBecauseIamAnIdiot < ActiveRecord::Migration
  def up
    remove_column :cards, :user_id
    add_column :cards, :user_id, :integer
  end

  def down
    remove_column :cards, :user_id
    add_column :cards, :user_id, :string
  end
end
