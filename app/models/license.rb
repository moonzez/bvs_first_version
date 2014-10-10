class License < ActiveRecord::Base
  default_scope { order(:shortcut) }
  has_and_belongs_to_many :users
  before_destroy -> (license) { license.can_be_deleted(:shortcut) }

  validates :title, :shortcut, presence: true, uniqueness: true

  include Common
end
