require 'rails_helper'

RSpec.describe Event, type: :module do

  context 'set_given_price' do

    it 'is called on new object' do
      guidedtour = FactoryGirl.build(:guidedtour)
      expect(guidedtour).to receive(:set_given_price)
      guidedtour.save
    end

    it 'is not called on persistent object' do
      guidedtour = FactoryGirl.create(:guidedtour)
      expect(guidedtour).not_to receive(:set_given_price)
      guidedtour.update(firstname: 'other name')
    end

    it 'sets given_price if no value given' do
      allow(Guidedtour).to receive(:find_given_price).and_return(80_000)
      guidedtour = FactoryGirl.create(:guidedtour)
      expect(guidedtour.given_price).to eql 80_000
    end

    it 'does not set given_price if given' do
      guidedtour = FactoryGirl.create(:guidedtour, given_price: 20_000)
      expect(guidedtour.given_price).to eql 20_000
    end
  end

  context 'set_invoice_number' do

    it 'is called on new object' do
      guidedtour = FactoryGirl.build(:guidedtour)
      expect(guidedtour).to receive(:set_invoice_number)
      guidedtour.save
    end

    it 'is not called on persistent object' do
      guidedtour = FactoryGirl.create(:guidedtour)
      expect(guidedtour).not_to receive(:set_invoice_number)
      guidedtour.update(firstname: 'other name')
    end

    it 'sets invoice_number if no value given' do
      guidedtour = FactoryGirl.create(:guidedtour)
      expect(guidedtour.invoice_number).to eql "G#{ guidedtour.id }"
    end

    it 'does not set invoive_number if given' do
      guidedtour = FactoryGirl.create(:guidedtour, invoice_number: 'AB20')
      expect(guidedtour.invoice_number).to eql 'AB20'
    end
  end

end
