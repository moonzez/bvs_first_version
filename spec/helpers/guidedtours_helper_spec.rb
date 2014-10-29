require 'rails_helper'

RSpec.describe GuidedtoursHelper, type: :helper do
  describe 'find_out_special_class' do

    it 'returns show_70_years if wished date 2015-05-03' do
      tour = FactoryGirl.create(:guidedtour, date2: Date.new(2015, 5, 3), from2: Time.new, to2: Time.new)
      expect(find_out_special_class(tour)).to eql 'show_70_years'
    end

    it 'returns show_themetour if themetour' do
      tour = FactoryGirl.create(:guidedtour, themetour: true, topic: 'Something to discuss')
      expect(find_out_special_class(tour)).to eql 'show_themetour'
    end

    it 'returns show_themetour if themetour' do
      tour = FactoryGirl.create(:guidedtour, themetour: false)
      expect(find_out_special_class(tour)).to eql ''
    end
  end
end
