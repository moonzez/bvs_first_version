require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe 'title' do
    before do
      @view_flow = ActionView::OutputFlow.new
    end

    it 'return default if no text given' do
      title
      expect(@view_flow.content[:title]).to eql 'BVS'
    end

    it 'return default value concatenated with text' do
      title('New Page')
      expect(@view_flow.content[:title]).to eql 'BVS - New Page'
    end
  end

  describe 'generate_errors_string' do
    before do
      @invalid_user = FactoryGirl.build(:user, firstname: nil)
    end

    it 'stringifies all object errors' do
      expected_str = 'Vorname darf nicht leer sein'
      @invalid_user.valid?
      expect(generate_errors_string(@invalid_user)).to eql expected_str
    end

    it 'separates errors string with ;- sign' do
      @invalid_user.gender = nil
      expected_str = 'Anrede darf nicht leer sein; Vorname darf nicht leer sein'
      @invalid_user.valid?
      expect(generate_errors_string(@invalid_user)).to eql expected_str
    end
  end
end
