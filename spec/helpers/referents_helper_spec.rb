require 'rails_helper'

RSpec.describe ReferentsHelper, type: :helper do
  describe 'build_activ_link' do
    before do
      @referent = FactoryGirl.create(:referent, activ: 'inactiv')
    end

    it 'creates link for referent to activate' do
      activ_link = build_activ_link(@referent, 'activ')
      expect(activ_link).to match(Regexp.new(change_activ_referent_path(@referent)))
      expect(activ_link).to match(/activate\.png/)
    end

    it 'creates link for referent to temporary deactivate' do
      temporary_link = build_activ_link(@referent, 'temporary')
      expect(temporary_link).to match(Regexp.new(change_activ_referent_path(@referent)))
      expect(temporary_link).to match(/temporary\.png/)
    end
  end
end
