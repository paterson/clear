class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :description
      t.string :paymill_id
      t.string :user_id
      t.string :card_id
      t.string :store_id
      t.integer :amount
      t.string :status
      t.string :currency

      t.timestamps
    end
  end
end
