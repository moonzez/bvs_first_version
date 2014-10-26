require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'title' do
    before do
      @view_flow = ActionView::OutputFlow.new
    end

    it 'return default if no text given' do
      title
      expect(@view_flow.content[:title]).to eql 'BVS'
    end

    it 'return default value concatenated with text' do
      title('New Page')
      expect(@view_flow.content[:title]).to eql 'New Page'
    end
  end

  describe 'generate_errors_string' do
    before do
      @invalid_user = FactoryGirl.build(:user, firstname: nil)
    end

    it 'stringifies all object errors' do
      expected_str = 'Vorname darf nicht leer sein'
      @invalid_user.valid?
      expect(generate_errors_string(@invalid_user)).to eql expected_str
    end

    it 'separates errors string with ;- sign' do
      @invalid_user.gender = nil
      expected_str = 'Anrede darf nicht leer sein; Vorname darf nicht leer sein'
      @invalid_user.valid?
      expect(generate_errors_string(@invalid_user)).to eql expected_str
    end

    it 'remove empty strings from beginning and end odf the message' do
      @invalid_user.firstname = 'Given'
      @invalid_user.errors.add(:base, ' Some new error ')
      expect(generate_errors_string(@invalid_user)).to eql 'Some new error'
    end
  end

  describe 'to_date' do
    it 'returns date in format dd.mm.yyyy' do
      expect(to_date(Time.now)).to eql Time.now.strftime('%d.%m.%Y')
    end
  end

  describe 'get_gender' do
    it 'returns gender for locale' do
      expect(get_gender(:mr)).to eql 'Herr'
      I18n.locale = :en
      expect(get_gender(:mr)).to eql 'Mr'
      I18n.locale = :de
    end
  end

  describe 'get_day_name' do
    it 'returns day Name for locale' do
      sonday = Date.new(1990, 4, 1)
      expect(get_day_name(sonday)).to eql 'So'
      I18n.locale = :en
      expect(get_day_name(sonday)).to eql 'Sun'
      I18n.locale = :de
    end
  end

  describe 'get_hours_minutes' do
    it 'returns time in format hh:mm' do
      noon = Time.new(1990, 4, 1, 12, 30, 0)
      expect(get_hours_minutes(noon)).to eql '12:30'
    end
  end

  describe 'get_language' do
    it 'returns language name localized' do
      expect(get_language('de')).to eql 'Deutsch'
      I18n.locale = :it
      expect(get_language('de')).to eql 'Tedesco'
      I18n.locale = :de
    end
  end

  describe 'get_film' do
    it 'return string for boolean for locale' do
      expect(get_film(false)).to eql 'Nein'
      expect(get_film(true)).to eql 'Ja'
    end
  end
end
