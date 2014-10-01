class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :title
    end

    create_table :roles_users, id: false do |t|
      t.integer :role_id
      t.integer :user_id
    end

    %w(admin dbuser reader accounter referent).each do |role|
      Role.create(title: role)
    end
  end
end
