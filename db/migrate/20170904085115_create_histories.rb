class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :user_id
      t.integer :post_id
      t.timestamp :push_time
      t.integer :push_price
      t.timestamps null: false
    end
  end
end
