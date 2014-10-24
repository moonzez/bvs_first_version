require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do
  setup :activate_authlogic

  before do
    @user = FactoryGirl.create(:user)
  end

  describe 'GET #new' do
    it 'assignes new session to @user_session' do
      @user.destroy
      get :new
      expect(assigns(:user_session)).to be_new_record
    end
  end

  describe 'POST #create' do

    context 'valid data' do

      it 'creates a new session' do
        post :create, user_session: { username: @user.username, password: @user.password }
        expect(assigns(:user_session))
        expect(flash[:notice]).to eql 'Sie sind angemeldet'
      end

      it 'redirects to root' do
        post :create, user_session: { username: @user.username, password: @user.password }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'invalid data' do

      it 'creates no new session' do
        post :create, user_session: { username: @user.username, password: '' }
        expect(assigns(:user_session).errors).not_to be_nil
        expect(flash[:notice]).to be_nil
      end

      it 'renders "new" template' do
        post :create, user_session: { username: '', password: @user.password }
        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      UserSession.create(username: @user.username, password: @user.password)
    end

    it 'removes user_session' do
      expect(UserSession.find).not_to be_nil
      delete :destroy
      expect(UserSession.find).to be_nil
    end

    it 'redirects to root_path' do
      delete :destroy
      expect(flash[:notice]).to eql 'Sie sind abgemeldet'
      expect(response).to redirect_to(root_path)
    end
  end
end
