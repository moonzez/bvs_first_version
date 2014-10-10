require 'rails_helper'

RSpec.describe Role, type: :model do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:role)).to be_valid
  end

  it 'is has and belongs to many users' do
    expect(Role.reflect_on_association(:users).macro).to eq(:has_and_belongs_to_many)
  end

  it 'is invalid without "title" attribute' do
    role = FactoryGirl.build(:role, title: nil)
    expect(role).to be_invalid
    expect(role.errors.keys).to match_array([:title])
  end

  it 'is invalid if title not unique' do
    FactoryGirl.create(:role, title: 'Taken title')
    role = FactoryGirl.build(:role, title: 'Taken title')
    expect(role).to be_invalid
    expect(role.errors.keys).to match_array([:title])
  end
end
