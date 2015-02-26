module Event
  extend ActiveSupport::Concern

  included do
    before_create :set_given_price
    after_create :set_invoice_number

    enum gender: [:mr, :mrs, :miss, :ms]
    enum havebeen: [:no, :yes, :some]
    enum state: [:opened, :confirmed, :canceled, :rejected]
    enum paid: [:not_paid, :transferred, :cash, :costfree]

    def get_form_language
      #TODO reimplement when language table done with shortcuts
      case form_language
      when 'fr'
        'Französisch'
      when 'it'
        'Italienisch'
      when 'en'
        'Englisch'
      when 'ger'
        'Deutsch'
      else
        form_language
      end
    end
  end

  module ClassMethods
    def permitted_params
      column_names.map(&:to_sym) - [:id]
    end
  end

  private

  def set_given_price
    return if given_price.present? && given_price != 0
    self.given_price = self.class.find_given_price
  end

  def set_invoice_number
    return if invoice_number.present?
    self.invoice_number = "#{ self.class.name.first }#{ id }"
  end

end
