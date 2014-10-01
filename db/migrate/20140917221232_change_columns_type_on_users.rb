class ChangeColumnsTypeOnUsers < ActiveRecord::Migration
  def change
    change_column :users, :crypted_password, :string, limit: 128, null: false, default: ''
    change_column :users, :salt, :string, limit: 128, null: false, default: ''
  end
end
