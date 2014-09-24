class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :title
    end

    create_table :roles_users, :id => false do |t|
      t.integer :role_id
      t.integer :user_id
    end

    roles = ["admin", "dbuser", "reader", "accounter", "referent"]

    roles.each do |role|
      Role.create(title: role)
    end
  end
end
