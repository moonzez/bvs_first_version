module ApplicationHelper
  def title(text = nil)
    content_for(:title) do
      text ? 'BVS - ' + text : 'BVS'
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
end
