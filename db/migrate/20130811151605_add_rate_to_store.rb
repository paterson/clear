class AddRateToStore < ActiveRecord::Migration
  def change
    add_column :stores, :rate, :integer # set default
  end
end
