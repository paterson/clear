class AddResetTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :reset_token, :boolean, :default => true
  end
end
