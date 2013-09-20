class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :description
      t.string :paymill_id
      t.string :user_id
      t.string :card_id
      t.string :store_id
      t.integer :amount
      t.timestamp :frequency
      t.timestamp :next_due

      t.timestamps
    end
  end
end
