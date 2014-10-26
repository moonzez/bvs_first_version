require 'rails_helper'

RSpec.describe Guidedtour, type: :model do

  it 'has a valid factory' do
    expect(FactoryGirl.create(:guidedtour)).to be_valid
  end

  it 'includes "Event" module' do
    tour = FactoryGirl.build(:guidedtour)
    expect(tour).to be_a_kind_of(Event)
  end

  context 'validations' do
    [:gender, :firstname, :lastname, :schoolname, :street, :city, :zip, :country,
     :date1, :from1, :email, :participants, :cellphone].each do |attr|
      it "is invalid without #{attr}" do
        tour = FactoryGirl.build(:guidedtour, attr => nil)
        expect(tour).to be_invalid
        expect(tour.errors.keys).to eql([attr])
      end
    end

    context 'email' do
      ['qwert', 'qwert@kkk@de', 'qwettt.mail.ru' '123'].each do |attr|
        it "is invalid for #{attr}" do
          tour = FactoryGirl.build(:guidedtour, email: attr)
          expect(tour).to be_invalid
          expect(tour.errors.keys).to eql([:email])
        end
      end

      ['qwert@bvs.de', 'qwert.asdf@hotmail.com', 'qwettt_123@mail.edu.fr'].each do |attr|
        it "is valid for #{attr}" do
          tour = FactoryGirl.build(:guidedtour, email: attr)
          expect(tour).to be_valid
          expect(tour.errors.keys).to eql([])
        end
      end
    end

    context 'participants' do
      it 'is invalid for negativ numbers' do
        tour = FactoryGirl.build(:guidedtour, participants: -12)
        expect(tour).to be_invalid
        expect(tour.errors.keys).to eql([:participants])
      end

      it 'is invalid for null' do
        tour = FactoryGirl.build(:guidedtour, participants: 0)
        expect(tour).to be_invalid
        expect(tour.errors.keys).to eql([:participants])
      end

      it 'is invalid for 1 or greater' do
        tour = FactoryGirl.build(:guidedtour, participants: 1)
        expect(tour).to be_valid
        expect(tour.errors.keys).to eql([])
      end
    end

    it 'valid without cellphone on update' do
      tour = FactoryGirl.create(:guidedtour)
      tour.cellphone = ''
      expect(tour).to be_valid
      expect(tour.errors.keys).to eql([])
    end

    it 'is invalid without hl_number if paid eql transferred' do
      tour = FactoryGirl.create(:guidedtour)
      tour.paid = :transferred
      expect(tour).to be_invalid
      expect(tour.errors.keys).to eql([:hl_number])
    end

    it 'is invalid without topic if themetour set' do
      tour = FactoryGirl.create(:guidedtour)
      tour.themetour = 1
      expect(tour).to be_invalid
      expect(tour.errors.keys).to eql([:topic])
    end

    it 'is invalid without age and schoolgrade schooltype set' do
      tour = FactoryGirl.build(:guidedtour, schooltype: 'High school')
      expect(tour).to be_invalid
      expect(tour.errors.keys).to match_array [:age, :schoolgrade]
    end
  end

  context 'languages_array' do
    # TODO: depending on locals
    it 'retuns languages relevant for guidedtour' do
      expect(Guidedtour.tour_languages).to match_array Language.all.map(&:language)
    end
  end

  context 'get_given_price' do
    it 'return current price' do
      expect(Guidedtour.find_given_price).to eql 70_000
    end
  end

  context 'set_groupnumber' do

    it 'sets grooupnumber to 1 if less or equal 30 participants' do
      tour = FactoryGirl.create(:guidedtour, participants: 30)
      expect(tour.groupnumber).to eql 1
    end

    it 'sets groupnumber to 2 if more then 30 and less then 60 participants' do
      tour = FactoryGirl.create(:guidedtour, participants: 59)
      expect(tour.groupnumber).to eql 2
    end

    it 'does not set groupnumber on update' do
      tour = FactoryGirl.create(:guidedtour, participants: 59)
      tour.update(participants: 13)
      expect(tour).not_to receive(:set_groupnumber)
      expect(tour.groupnumber).to eql 2
      expect(tour.participants).to eql 13
    end
  end

  context 'find_opened' do
    it 'returns all guidedtours in state opened' do
      FactoryGirl.create(:guidedtour, state: :confirmed)
      opened1 = FactoryGirl.create(:guidedtour, state: :opened)
      opened2 = FactoryGirl.create(:guidedtour, state: :opened)
      FactoryGirl.create(:guidedtour, state: :canceled)
      expect(Guidedtour.find_opened).to match_array [opened1, opened2]
    end
  end
end
