class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.string :content
      t.integer :start_price
      t.integer :bn_price
      t.integer :start_time
      t.integer :up_price
      t.string :tags
      t.string :image1
      t.string :image2
      t.string :image3
      t.boolean :expire
      t.integer :like
      t.integer :view
    


      t.timestamps null: false
    end
  end
end
