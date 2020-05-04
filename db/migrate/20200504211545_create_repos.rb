class CreateRepos < ActiveRecord::Migration[5.0]
  def change
    create_table :repos do |t|
      t.string :name
      t.string :description
      t.string :url
      t.boolean :private
      t.integer :owner_id
      t.integer :forks
      t.integer :stars
    end
  end
end
