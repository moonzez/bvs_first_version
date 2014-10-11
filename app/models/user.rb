class User < ActiveRecord::Base
  has_and_belongs_to_many :languages
  has_and_belongs_to_many :roles
  has_and_belongs_to_many :licenses

  before_destroy :can_be_removed?

  ACTIVITY = { activ: 'aktiv', inactiv: 'nicht aktiv', temporary: 'vorübergehend nicht aktiv' }

  acts_as_authentic do |config |
    config.transition_from_restful_authentication = true
  end

  enum gender: [:herr, :frau]
  enum activ: ACTIVITY.keys

  validates :gender, presence: true
  validates :lastname, presence: true
  validates :firstname, presence: true
  validates :username, presence: true
  validates :tel, presence: true
  validates :email, presence: true
  validates :bank, :blz, :konto, presence: true, if: :is_referent?

  %w(admin referent).each do |role|
    define_method("is_#{ role }?") { roles.include?(Role.find_by(title: role)) }
  end

  def assign_languages(languages_ids)
    languages.delete_all
    return nil if languages_ids.blank?
    languages_ids.each do |language_id|
      language = Language.find(language_id)
      languages << language
    end
  end

  def assign_roles(roles_ids)
    roles.delete_all
    return nil if roles_ids.blank?
    roles_ids.each do |role_id|
      role = Role.find(role_id)
      roles << role
    end
  end

  def assign_licenses(licenses_ids)
    licenses.delete_all
    return nil if licenses_ids.blank?
    licenses_ids.each do |license_id|
      license = License.find(license_id)
      licenses << license
    end
  end

  def full_name
    "#{ firstname } #{ lastname }"
  end

  def can_be_removed?
    if is_referent?
      errors.add(:base, "Referent #{ full_name } darf nicht gelöscht werden")
      return false
    end
    true
  end

  def check_referent(roles_ids)
    return true if roles_ids.blank?
    roles_ids.each do |role_id|
      role = Role.find(role_id)
      next if role.title != 'referent'
      [:bank, :blz, :konto].each do |attr|
        errors.add(attr, :blank) if self[attr].blank?
      end
    end
    !errors.present?
  end

  def save_with_params(roles = nil, languages = nil, licenses = nil)
    if check_referent(roles) && save
      assign_roles(roles)
      assign_languages(languages)
      assign_licenses(licenses)
      return true
    else
      return false
    end
  end

  def save_referent_with_params(languages = nil, licenses = nil)
    return false unless role = Role.find_by(title: 'referent')
    save_with_params([role.id], languages, licenses)
  end

  def update_referent_with_params(referent_params, languages = nil, licenses = nil)
    return false unless update(referent_params)
    assign_languages(languages)
    assign_licenses(licenses)
    true
  end

  def update_with_params(user_params, roles = nil, languages = nil, licenses = nil)
    return false unless update(user_params)
    assign_roles(roles)
    assign_languages(languages)
    assign_licenses(licenses)
    true
  end

  def update_myself(user_params, roles = nil, languages = nil, licenses = nil)
    if is_admin?
      update_with_params(user_params, roles, languages, licenses)
    else
      update_referent_with_params(user_params, languages, licenses)
    end
  end

  def identic?(user)
    self == user
  end

  def change_activ(new_state)
    method_name = new_state + '!'
    valid? # check before set activotherwice Exception will be thrown
    return false if errors.present?
    send(method_name)
  end

  def self.ordered_by_name(letter)
    if letter != '*'
      where('lastname LIKE :search', search: letter + '%').order(:lastname, :firstname)
    else
      order(:lastname, :firstname)
    end
  end

  def self.present_abc
    all_letters = all.map(&:lastname).map(&:first).map(&:upcase).uniq.sort
    all_letters.unshift('*')
  end

  def self.referents
    Role.find_by(title: 'referent').users
  end

  def self.all_except_inactiv
    where(activ: [activs[:activ], activs[:temporary]])
  end
end
