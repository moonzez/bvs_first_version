class AddFieldsToUsers < ActiveRecord::Migration
  def change

    sql = "DELETE FROM schema_migrations"
    execute sql

    rename_column :users, :login, :old_login

    add_column :users, :username, :string
    add_column :users, :password_salt, :string
    add_column :users, :persistence_token, :string
    add_column :users, :email, :string
    add_column :users, :referent_id, :integer
    add_column :users, :gender, :integer
    add_column :users, :tel, :string
    add_column :users, :tel2, :string
    add_column :users, :remarc, :text
    add_column :users, :activ, :integer, :default => 0 # 0 == activ
    add_column :users, :zip, :string
    add_column :users, :city, :string
    add_column :users, :street, :string
    add_column :users, :country, :string
    add_column :users, :bank, :string
    add_column :users, :blz, :string
    add_column :users, :konto, :string
    add_column :users, :honorar, :boolean, :default => true

    change_column :users, :crypted_password, :string, :limit => 128, :null => false, :default => ""
    change_column :users, :salt, :string, :limit => 128, :null => false, :default => ""
  end
end
