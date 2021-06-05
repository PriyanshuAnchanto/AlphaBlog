class AddLogsColInUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :log, :string
  end
end
