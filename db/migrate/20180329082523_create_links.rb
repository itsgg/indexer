class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.string :name, null: false
      t.string :href, null: false
      t.references :url
      t.timestamps
    end
  end
end
