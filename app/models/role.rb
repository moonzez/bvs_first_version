class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :title, :presence => true, :uniqueness => true

  def self.the_only_admin(user)
    all_admins = self.find_by(title: "admin").users
    return false unless all_admins.include?(user)
    all_admins == [user]
  end
end
