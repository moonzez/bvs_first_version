module ApplicationHelper
  def title(text = nil)
    content_for(:title) do
      text ? text : 'BVS'
    end
  end

  def generate_errors_string(object)
    error_text = []
    object.errors.each do |attr, msg|
      error = I18n.t("activerecord.attributes.#{ object.class.name.downcase }.#{ attr }") + " #{ msg }"
      error_text << error.strip
    end
    error_text.join('; ')
  end

  def to_date(time)
    I18n.l time
  end

  def get_gender(gender)
    t("events.genders.#{ gender }")
  end

  def get_day_name(date)
    I18n.l date, format: :dayname
  end

  def get_hours_minutes(time)
    I18n.l time, format: :hours_minutes unless time.blank?
  end

  def get_language(language)
    I18n.t("languages.full_name.#{language}")
  end

  def get_film(film)
    I18n.t("answers.#{film ? 'yes' : 'no' }")
  end

  def get_pdf_text(value)
    return '___' if value.blank?
    value
  end

  def get_havebeen(value)
    I18n.t("events.havebeen.#{ value }")
  end

  def get_theme_type(value)
    I18n.t("events.themetours.#{ value }") unless value.blank?
  end
end
