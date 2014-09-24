class Migrate < ActiveRecord::Migration
  def change

    referent_role = Role.find_by(title: "referent")

    User.all.each do |user|
      if user.role.blank?
        user.roles << referent_role
      else
        role = Role.find_by(title: user.role)
        user.roles << role
      end
    end
  end
end
