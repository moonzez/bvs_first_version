module Common
  def generate_errors_for_remote
    error_text = []
    errors.each do |attr, msg|
      error_text << I18n.t("activerecord.attributes.#{ self.class.name.downcase }.#{ attr }") + " #{ msg }"
    end
    error_text.join('; ')
  end

  def can_be_deleted(what)
    if users.any?
      errors.add(:base, I18n.t('is_in_use', what: self[what]))
      return false
    end
    true
  end
end
