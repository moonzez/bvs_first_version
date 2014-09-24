class Language < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :language, :presence => true, :uniqueness => true

  include Common

end
