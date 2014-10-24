require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  setup :activate_authlogic

  before do
    @user = FactoryGirl.create(:user)
    UserSession.create(username: @user.username, password: @user.password)
  end

  describe 'GET #home' do
    it 'renders home template' do
      get :home
      expect(response).to render_template :home
    end
  end
end
