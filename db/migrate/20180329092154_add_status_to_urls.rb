class AddStatusToUrls < ActiveRecord::Migration[5.1]
  def change
    add_column :urls, :status, :integer, default: 0, null: false # started: 0, completed: 1
  end
end
