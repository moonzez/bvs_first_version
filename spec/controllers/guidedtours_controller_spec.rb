require 'rails_helper'

RSpec.describe GuidedtoursController, type: :controller do
  setup :activate_authlogic

  before do
    @user = FactoryGirl.create(:dbuser)
    UserSession.create(username: @user.username, password: @user.password)
  end

  describe 'GET #new' do
    it 'renders new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'when not dbuser' do
    it 'redirects to root' do
      user_session = UserSession.find
      user_session.destroy
      @reader = FactoryGirl.create(:reader)
      UserSession.create(username: @reader.username, password: @reader.password)
      get :new
      expect(response).to redirect_to root_path
      expect(flash[:alert]).to eql I18n.t('only_dbuser_or_accounter')
    end
  end

  describe 'POST #create' do
    before do
      @guidedtour_attrs = FactoryGirl.attributes_for(:guidedtour)
    end
    context 'with valid params' do

      it 'saves entry in database' do
        expect { post :create, guidedtour: @guidedtour_attrs }.to change(Guidedtour, :count).by(1)
      end

      it 'rendirects to guidedtouts index' do
        post :create, guidedtour: @guidedtour_attrs
        expect(response).to redirect_to(guidedtours_path)
      end
    end

    context 'with invalid params' do
      it 'renders new template' do
        post :create, guidedtour: @guidedtour_attrs.merge(firstname: nil)
        expect(response).to render_template :new
      end
    end
  end

  describe 'GET #opened' do
    it 'assignes opened tours to @opened_tours' do
      opened_tour = FactoryGirl.create(:guidedtour, state: :opened)
      opened_tour2 = FactoryGirl.create(:guidedtour, state: :opened)
      get :opened
      expect(assigns(:opened_tours)).to match_array [opened_tour, opened_tour2]
    end

    it 'renders opened template' do
      get :opened
      expect(response).to render_template :opened
    end
  end

  describe 'GET #edit' do
    it 'assigns guidedtour to @guidedtour' do
      tour = FactoryGirl.create(:guidedtour)
      get :edit, id: tour.id
      expect(assigns(:guidedtour)).to eql tour
    end

    it 'renders edit template' do
      tour = FactoryGirl.create(:guidedtour)
      get :edit, id: tour.id
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do

    it 'assigns guidedtour to @guidedtour' do
      tour = FactoryGirl.create(:guidedtour)
      put :update, id: tour.id, guidedtour: { lastname: 'Doe' }
      expect(assigns(:guidedtour)).to eql tour
    end

    it 'redirects_to guidedtours' do
      tour = FactoryGirl.create(:guidedtour)
      put :update, id: tour.id, guidedtour: { lastname: 'Doe' }
      expect(flash[:notice]).to eql 'Geführter Rundgang wurde geändert'
      expect(response).to redirect_to(guidedtours_path)
    end
  end

  describe 'DELETE #destroy' do
    it 'assigns guidedtour to @guidedtour' do
      tour = FactoryGirl.create(:guidedtour)
      delete :destroy, id: tour.id, format: :js
      expect(assigns(:guidedtour)).to eql tour
    end

    it 'renders destroy.js template' do
      tour = FactoryGirl.create(:guidedtour)
      delete :destroy, id: tour.id, format: :js
      expect(response.content_type).to eql 'text/javascript'
      expect(response).to render_template :destroy
    end
  end
end
