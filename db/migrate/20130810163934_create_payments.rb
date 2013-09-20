class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :ip
      t.string :country
      t.timestamp :local_time
      t.string :paymill_id
      t.integer :card_id
      t.integer :user_id
      t.integer :store_id

      t.timestamps
    end
  end
end
