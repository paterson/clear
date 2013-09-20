class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :type
      t.string :last_four
      t.string :paymill_id
      t.timestamp :expires
      t.string :user_id
      t.timestamps
    end
  end
end
