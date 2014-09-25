class User < ActiveRecord::Base

  has_and_belongs_to_many :languages
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :licenses

  ACTIVITY = { activ: "aktiv", inactiv: "nicht aktiv", temporary: "vorübergehend nicht aktiv" }

  acts_as_authentic do |c |
    c.transition_from_restful_authentication = true
  end

  enum gender: [:herr, :frau]
  enum activ: ACTIVITY.keys


  validates :gender, :presence => true
  validates :lastname, :presence => true
  validates :firstname, :presence => true
  validates :username, presence: true
  validates :tel, :presence => true
  validates :email, :presence => true
  validates :bank, :blz, :konto, presence: true, if: :is_referent?

  %w(admin referent).each do |role|
    define_method("is_#{ role }?") { self.roles.include?(Role.find_by(title: role)) }
  end

  def assign_languages(languages_ids)
    self.languages.delete_all
    if !languages_ids.blank?
      languages_ids.each do |language_id|
        language = Language.find(language_id)
        self.languages << language
      end
    end
  end

  def assign_roles(roles_ids)
    self.roles.delete_all
    if !roles_ids.blank?
      roles_ids.each do |role_id|
        role = Role.find(role_id)
        self.roles << role
      end
    end
  end

  def full_name
    "#{ self.firstname } #{ self.lastname }"
  end

  def can_be_removed
    if is_admin?
     return !Role.the_only_admin(self)
    elsif is_referent?
      return false
    end
    true
  end

  def check_referent(roles_ids)
    return true if roles_ids.blank?
    roles_ids.each do |role_id|
      role = Role.find(role_id)
      if role.title == "referent"
        self.errors.add(:bank, :blank) if self.bank.blank?
        self.errors.add(:blz, :blank) if self.blz.blank?
        self.errors.add(:konto, :blank) if self.konto.blank?
      end
    end
    return !self.errors.present?
  end

  def self.ordered_by_name(letter)
    if letter != "*"
      where("lastname LIKE :search", search: letter + "%").order(:lastname, :firstname)
    else
      order(:lastname, :firstname)
    end
  end

  def self.present_abc
    all_letters = all.collect(&:lastname).collect(&:first).collect(&:upcase).uniq.sort
    all_letters.unshift("*")
  end

  def self.referents
    Role.find_by(title: "referent").users
  end

  private

end
