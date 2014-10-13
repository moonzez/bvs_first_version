require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
  setup :activate_authlogic

  before do
    @user = FactoryGirl.create(:user)
    UserSession.create(username: @user.username, password: @user.password)
  end

  describe 'GET #edit' do
    it 'assigns crrent user to @profile' do
      get :edit
      expect(assigns(:profile)).to eq(@user)
    end

    it 'assigns all languages to @languages' do
      get :edit
      expect(assigns(:languages)).to eq(Language.all)
    end

    it 'assigns all roles to @roles' do
      get :edit
      expect(assigns(:roles)).to eq(Role.all)
    end

    it 'assigns all licenses to @licenses' do
      get :edit
      expect(assigns(:licenses)).to eq(License.all)
    end

    it 'redirects to login url when not logged in' do
      @user_session = UserSession.find
      @user_session.destroy
      get :edit
      expect(response).to redirect_to(login_url)
    end

    it 'renders edit template' do
      get :edit
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    before do
      @profile_attrs = { lastname: 'Married' }
    end

    it 'assigns current user to @profile' do
      put :update, profile: @profile_attrs
      expect(assigns(:profile)).to eq(@user)
    end

    it 'assigns all languages to @languages' do
      put :update, profile: @profile_attrs
      expect(assigns(:languages)).to eq(Language.all)
    end

    it 'assigns all roles to @roles' do
      put :update, profile: @profile_attrs
      expect(assigns(:roles)).to eq(Role.all)
    end

    it 'assigns all licenses to @licenses' do
      put :update, profile: @profile_attrs
      expect(assigns(:licenses)).to eq(License.all)
    end

    context 'with valid attributes' do
      it 'redirects to root' do
        put :update, profile: @profile_attrs
        expect(response).to redirect_to root_path
        expect(flash[:notice]).to eql 'Ihr Profil wurde geändert'
      end

      it 'calls update_myself on user' do
        role = FactoryGirl.create(:role)
        language = FactoryGirl.create(:language)
        license = FactoryGirl.create(:license)
        expect_any_instance_of(User).to receive(:update_myself)
          .with(@profile_attrs, [role.id.to_param], [language.id.to_param], [license.id.to_param])
        put :update, profile: @profile_attrs,
          languages: [language.id], roles: [role.id], licenses: [license.id]
      end
    end

    context 'with invalid attributes' do
      it 'renders edit template' do
        put :update, profile: { lastname: nil }
        expect(response).to render_template :edit
      end
    end
  end
end
