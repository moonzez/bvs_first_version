require 'rails_helper'

RSpec.describe Common, type: :module do

  context 'generate_errors_for_remote' do

    it 'returns translated error string for one error' do
      license = FactoryGirl.build(:license, title: nil)
      license.valid?
      message = I18n.t('activerecord.attributes.license.title') +
        ' ' + I18n.t('activerecord.errors.models.license.attributes.title.blank')
      expect(license.generate_errors_for_remote).to eql message
    end

    it 'returns ; separated string for many errors' do
      license = FactoryGirl.build(:license, title: nil, shortcut: nil)
      license.valid?
      message = I18n.t('activerecord.attributes.license.title') +
        ' ' + I18n.t('activerecord.errors.models.license.attributes.title.blank') +
        '; ' + I18n.t('activerecord.attributes.license.shortcut') +
        ' ' + I18n.t('activerecord.errors.models.license.attributes.shortcut.blank')
      expect(license.generate_errors_for_remote).to eql message
    end

    it 'returns empty string if no errors' do
      license = FactoryGirl.build(:license)
      license.valid?
      expect(license.generate_errors_for_remote).to eql ''
    end
  end

  context 'can_be_deleted for Language' do
    before do
      @user = FactoryGirl.create(:user)
    end

    it 'returns false is there is at least one user who speeks this language' do
      german = FactoryGirl.create(:german)
      @user.languages << german

      expect(german.can_be_deleted(:language)).to eql false
    end

    it 'adds an error to base if there is a user speeking this language' do
      german = FactoryGirl.create(:german)
      @user.languages << german

      german.can_be_deleted(:language)
      expect(german.errors).to include(:base)
    end

    it 'returns true if no user speeks this language' do
      german = FactoryGirl.create(:german)
      expect(german.can_be_deleted(:language)).to eql true
    end
  end
end
