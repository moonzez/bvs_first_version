require 'rails_helper'

RSpec.describe Role, :type => :model do
    it "has a valid factory" do
    expect(FactoryGirl.create(:role)).to be_valid
  end

  it "is has and belongs to many users" do
    expect(Role.reflect_on_association(:users).macro).to eq(:has_and_belongs_to_many)
  end

  it "is invalid without 'title' attribute" do
    role = FactoryGirl.build(:role, :title => nil)
    expect(role).to be_invalid
    expect(role.errors.keys).to match_array([:title])
  end

  it "is invalid if title not unique" do
    FactoryGirl.create(:role, title: "Taken title")
    role = FactoryGirl.build(:role, :title => "Taken title")
    expect(role).to be_invalid
    expect(role.errors.keys).to match_array([:title])
  end

  context "the_only_admin" do

    before do
      @admin = FactoryGirl.create(:admin)
    end

    it "returns true if given user is the only admin" do
      expect(Role.the_only_admin(@admin)).to eq(true)
    end

    it "returns false if given user is not admin" do
      referent = FactoryGirl.create(:referent)
      expect(Role.the_only_admin(referent)).to eq(false)
    end

    it "returns false if the given user is not the only admin" do
      second_admin = FactoryGirl.create(:admin)
      expect(Role.the_only_admin(@admin)).to eq(false)
    end
  end
end
