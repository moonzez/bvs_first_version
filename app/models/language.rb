class Language < ActiveRecord::Base
  default_scope { order(:language) }
  has_and_belongs_to_many :users
  before_destroy -> (language) { language.can_be_deleted(:language) }

  validates :language, presence: true, uniqueness: true

  include Common
end
