class AddTokenToStore < ActiveRecord::Migration
  def change
    add_column :stores, :authentication_token, :string
  end
end
