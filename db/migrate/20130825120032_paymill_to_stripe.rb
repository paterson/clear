class PaymillToStripe < ActiveRecord::Migration
  def change
    remove_column :cards, :paymill_id
    remove_column :cards, :paymill_token
    remove_column :subscriptions, :paymill_id
    remove_column :payments, :paymill_id
    remove_column :users, :paymill_id
    remove_column :invoices, :paymill_id

    add_column :cards, :stripe_token, :string
    add_column :cards, :stripe_id, :string
    add_column :payments, :stripe_id, :string
    add_column :users, :stripe_id, :string
  end
end
