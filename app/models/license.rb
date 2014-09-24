class License < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :title, :shortcut, :presence => true, :uniqueness => true

  include Common
end
