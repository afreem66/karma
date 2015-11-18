class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.references :user, index: true, foreign_key: true
      t.string :name, null: :false
      t.text :description
      t.string :location, null: :false
      t.string :url
      t.string :mission

      t.timestamps null: false
    end

    add_index :opportunities, :location
  end
end
