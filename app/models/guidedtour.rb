class Guidedtour < ActiveRecord::Base
  include Event

  before_create :set_groupnumber

  validates :gender, presence: true
  validates :firstname, presence: true
  validates :lastname, presence: true
  validates :schoolname, presence: true
  validates :street, presence: true
  validates :city, presence: true
  validates :zip, presence: true
  validates :country, presence: true
  validates :date1, presence: true
  validates :from1, presence: true

  validates :email, presence: true
  validates :email, format: {
    with: /\A([-a-z0-9!\#$%&'*+\/=?^_`{|}~]+\.)*[-a-z0-9!\#$%&'*+\/=?^_`{|}~]+@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  }

  validates :participants, presence: true
  validates :participants, numericality: { greater_than_or_equal_to: 1 }

  validates :hl_number, presence: true, if: "paid.eql?('transferred')"
  validates :topic, presence: true, if: 'themetour'
  validates :schoolgrade, presence: true, if: 'schooltype.present?', on: :create
  validates :age, presence: true, if: 'schooltype.present?', on: :create
  validates :cellphone, presence: true, on: :create

  def self.tour_languages
    # TODO: build array [language, shortcut]
    Language.all.map(&:language)
  end

  def self.find_given_price
    70_000
  end

  private

  def set_groupnumber
    return if groupnumber.present?
    divmod = participants.divmod(30)
    groups = divmod.first
    groups += 1 if divmod.last > 0
    self.groupnumber = groups
  end
end
