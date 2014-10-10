require 'rails_helper'

RSpec.describe Language, type: :model do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:language)).to be_valid
  end

  it 'includes "Common" module' do
    language = FactoryGirl.build(:language)
    expect(language).to be_a_kind_of(Common)
  end

  it 'is has and belongs to many users' do
    expect(Language.reflect_on_association(:users).macro).to eq(:has_and_belongs_to_many)
  end

  it 'is invalid without language attribute' do
    language = FactoryGirl.build(:language, language: nil)
    expect(language).to be_invalid
    expect(language.errors.keys).to match_array([:language])
  end

  it 'is invalid if language not unique' do
    FactoryGirl.create(:german)
    language = FactoryGirl.build(:language, language: 'Deutsch')

    expect(language).to be_invalid
    expect(language.errors.keys).to match_array([:language])
    error_message = I18n.t('activerecord.errors.models.language.attributes.language.taken')
    expect(language.errors.messages[:language].first).to eql(error_message)
  end

  context 'can_be_deleted' do
    before do
      @language = FactoryGirl.create(:language)
    end

    it 'should be triggered on delete language' do
      expect(@language).to receive(:can_be_deleted).with(:language)
      @language.destroy
    end

    it 'should not destroy language if returns false' do
      user = FactoryGirl.create(:user)
      user.languages << @language
      @language.destroy
      expect(Language.count).to eql(1)
    end

    it 'should destroy language if returns true' do
      @language.destroy
      expect(Language.count).to eql(0)
    end
  end

  context 'default_scope' do
    it 'oders language after alphabet' do
      german = FactoryGirl.create(:language, language: 'Deutsch')
      arabic = FactoryGirl.create(:language, language: 'Arabisch')
      spanish = FactoryGirl.create(:language, language: 'Spanisch')

      expect(Language.all).to eq([arabic, german, spanish])
    end
  end
end
