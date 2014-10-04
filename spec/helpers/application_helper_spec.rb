require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  before do
    @view_flow = ActionView::OutputFlow.new
  end

  describe 'title' do
    it 'return default if no text given' do
      title
      expect(@view_flow.content[:title]).to eql 'BVS'
    end

    it 'return default value concatenated with text' do
      title('New Page')
      expect(@view_flow.content[:title]).to eql 'BVS - New Page'
    end
  end
end
