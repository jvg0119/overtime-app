class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.date :date
      t.text :rational

      t.timestamps null: false
    end
  end
end
