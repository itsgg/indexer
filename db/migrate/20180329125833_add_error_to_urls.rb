class AddErrorToUrls < ActiveRecord::Migration[5.1]
  def change
    add_column :urls, :error, :text
  end
end
