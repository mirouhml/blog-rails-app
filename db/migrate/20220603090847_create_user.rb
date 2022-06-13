class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, default: "John"
      t.string :photo
      t.string :bio
      t.integer :PostsCounter, default: 0

      t.timestamps
    end
  end
end
