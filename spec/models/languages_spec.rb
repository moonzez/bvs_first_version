require 'rails_helper'

RSpec.describe Language, :type => :model do

  it "has a valid factory" do
    expect(FactoryGirl.create(:language)).to be_valid
  end

  it "includes 'Common' module" do
    language = FactoryGirl.build(:language)
    expect(language).to be_a_kind_of(Common)
  end

  it "is has and belongs to many users" do
    expect(Language.reflect_on_association(:users).macro).to eq(:has_and_belongs_to_many)
  end

  it "is invalid without 'language' attribute" do
    language = FactoryGirl.build(:language, :language => nil)
    expect(language).to be_invalid
    expect(language.errors.keys).to match_array([:language])
  end

  it "is invalid if language not unique" do
    FactoryGirl.create(:german)
    language = FactoryGirl.build(:language, :language => "Deutsch")

    expect(language).to be_invalid
    expect(language.errors.keys).to match_array([:language])
    error_message = I18n.t('activerecord.errors.models.language.attributes.language.taken')
    expect(language.errors.messages[:language].first).to eql(error_message)
  end

  context "is_in_use" do
    before do
      @user = FactoryGirl.create(:user)
    end

    it "returns true is there is at least one user who speeks this language" do
      german = FactoryGirl.create(:german)
      @user.languages << german

      expect(german.is_in_use).to eql(true)
    end

    it "returns false is no user speeks this language" do
      german = FactoryGirl.create(:german)
      expect(german.is_in_use).to eql(false)
    end
  end
end
