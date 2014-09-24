require 'rails_helper'

RSpec.describe Common, type: :module do

  context "get_errors_for_remote" do

    it "returns translated error string for one error" do
      license = FactoryGirl.build(:license, title: nil)
      license.valid?
      message = I18n.t('activerecord.attributes.license.title') +
        " " + I18n.t('activerecord.errors.models.license.attributes.title.blank')
      expect(license.get_errors_for_remote).to eql message
    end

    it "returns ';' separated string for many errors" do
      license = FactoryGirl.build(:license, title: nil, shortcut: nil)
      license.valid?
      message = I18n.t('activerecord.attributes.license.title') +
        " " + I18n.t('activerecord.errors.models.license.attributes.title.blank') +
        "; " + I18n.t('activerecord.attributes.license.shortcut') +
        " " + I18n.t('activerecord.errors.models.license.attributes.shortcut.blank')
      expect(license.get_errors_for_remote).to eql message
    end

    it "returns empty string if no errors" do
      license = FactoryGirl.build(:license)
      license.valid?
      expect(license.get_errors_for_remote).to eql ""
    end
  end

  context "is_in_use for Language" do
    before do
      @user = FactoryGirl.create(:user)
    end

    it "returns true is there is at least one user who speeks this language" do
      german = FactoryGirl.create(:german)
      @user.languages << german

      expect(german.is_in_use).to eql true
    end

    it "returns false is no user speeks this language" do
      german = FactoryGirl.create(:german)
      expect(german.is_in_use).to eql false
    end
  end

end
