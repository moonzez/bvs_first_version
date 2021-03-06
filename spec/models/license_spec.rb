require 'rails_helper'

RSpec.describe License, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:license)).to be_valid
  end

  it 'includes "Common" module' do
    license = FactoryGirl.build(:license)
    expect(license).to be_a_kind_of(Common)
  end

  it 'is has and belongs to many users' do
    expect(License.reflect_on_association(:users).macro).to eq(:has_and_belongs_to_many)
  end

  context 'presence validation' do
    it 'is invalid without title attribute' do
      license = FactoryGirl.build(:license, title: nil)
      expect(license).to be_invalid
      expect(license.errors.keys).to match_array([:title])
    end

    it 'is invalid without shortcut attribute' do
      license = FactoryGirl.build(:license, shortcut: nil)
      expect(license).to be_invalid
      expect(license.errors.keys).to match_array([:shortcut])
    end
  end

  context 'uniqueness validation' do

    before do
      FactoryGirl.create(:license, title: 'Taken title', shortcut: 'Taken shortcut')
    end

    it 'is invalid if title not unique' do
      license = FactoryGirl.build(:license, title: 'Taken title')
      expect(license).to be_invalid
      expect(license.errors.keys).to match_array([:title])
      error_message = I18n.t('activerecord.errors.models.license.attributes.title.taken')
      expect(license.errors.messages[:title].first).to eql(error_message)
    end

    it 'is invalid if shortcut not unique' do
      license = FactoryGirl.build(:license, shortcut: 'Taken shortcut')

      expect(license).to be_invalid
      expect(license.errors.keys).to match_array([:shortcut])
      error_message = I18n.t('activerecord.errors.models.license.attributes.shortcut.taken')
      expect(license.errors.messages[:shortcut].first).to eql(error_message)
    end
  end

  context 'can_be_deleted' do
    before do
      @license = FactoryGirl.create(:license)
    end

    it 'should be trigger on destroy license' do
      expect(@license).to receive(:can_be_deleted).with(:shortcut)
      @license.destroy
    end

    it 'should not destroy license if returns false' do
      user = FactoryGirl.create(:user)
      user.licenses << @license
      @license.destroy
      expect(License.count).to eql(1)
    end

    it 'should destroy license if can_be_deleted returns true' do
      @license.destroy
      expect(License.count).to eql(0)
    end
  end

  context 'default_scope' do
    it 'oders licenses by shortcut after alphabet' do
      b_license = FactoryGirl.create(:license, shortcut: 'Lizense B')
      a_license = FactoryGirl.create(:license, shortcut: 'Lizense A')
      c_license = FactoryGirl.create(:license, shortcut: 'Lizense C')

      expect(License.all).to eq([a_license, b_license, c_license])
    end
  end
end
