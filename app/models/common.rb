module Common

  def get_errors_for_remote
    error_text = []
    self.errors.each do |k, v|
      error_text << I18n.t("activerecord.attributes.#{ self.class.name.downcase }.#{ k }") + " #{ v }"
    end
    error_text.join("; ")
  end

  def self.present_abc(attribute)
    all.collect(&(attribute.to_sym)).collect(&:first).uniq.sort
  end

  def is_in_use
    self.users.any?
  end

end
