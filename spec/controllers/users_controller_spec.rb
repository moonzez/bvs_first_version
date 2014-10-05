require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  setup :activate_authlogic

  before do
    @user = FactoryGirl.create(:user, lastname: 'Baba')
    UserSession.create(username: @user.username, password: @user.password)
  end

  describe 'GET #index' do

    context 'with param selected_letter "A"' do
      it 'assigns params @selected_letter' do
        get :index, selected_letter: 'A'
        expect(assigns(:selected_letter)).to eql 'A'
      end

      it 'assigns all users with lastname starting with selected_letter to @users' do
        user1 = FactoryGirl.create(:user, lastname: 'Achti')
        get :index, selected_letter: 'A'
        expect(assigns(:users)).to match_array [user1]
        expect(assigns(:all_letters)).not_to be_nil
      end
    end

    context 'without selected_letter param' do
      it 'assignes "*" to @selected_letter' do
        get :index
        expect(assigns(:selected_letter)).to eql '*'
      end

      it 'assigns all users to @users' do
        user1 = FactoryGirl.create(:user)
        get :index
        expect(assigns(:users)).to match_array [@user, user1]
        expect(assigns(:all_letters)).not_to be_nil
      end
    end

    it 'renders "index" template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do

    it 'assigns a new user as @user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it 'assigns all languages to @languages' do
      german = FactoryGirl.create(:german)
      english = FactoryGirl.create(:english)
      get :new
      expect(assigns(:languages)).to match_array [german, english]
    end

    it 'assigns all roles to @roles' do
      admin = FactoryGirl.create(:admin_role)
      referent = FactoryGirl.create(:referent_role)
      get :new
      expect(assigns(:roles)).to match_array [admin, referent]
    end

    it 'renders new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET edit' do

    it 'assigns the requested user as @user' do
      get :edit, id: @user
      expect(assigns(:user)).to eq(@user)
    end

    it 'assigns all languages to @languages' do
      german = FactoryGirl.create(:german)
      english = FactoryGirl.create(:english)
      get :edit, id: @user
      expect(assigns(:languages)).to match_array [german, english]
    end

    it 'assigns all roles to @roles' do
      admin = FactoryGirl.create(:admin_role)
      referent = FactoryGirl.create(:referent_role)
      get :edit, id: @user
      expect(assigns(:roles)).to match_array [admin, referent]
    end

    it 'renders edit template' do
      get :edit, id: @user
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do

    before do
      @user_attributes = FactoryGirl.attributes_for(:user)
    end

    describe 'with valid params' do
      it 'creates a new User' do
        expect { post :create, user: @user_attributes }.to change(User, :count).by(1)
      end

      it 'assigns a newly created user as @user' do
        post :create, user: @user_attributes
        expect(assigns(:user)).to be_a(User)
        expect(assigns(:user)).to be_persisted
      end

      it 'redirects to all users' do
        post :create, user: @user_attributes
        expect(flash[:notice]).to eql "Nutzer #{ User.last.full_name } wurde angelegt"
        expect(response).to redirect_to(users_path)
      end
    end

    describe 'with invalid params' do
      before do
        @invalid_user_attrs = FactoryGirl.attributes_for(:invalid_user)
      end

      it 'assigns a newly created but unsaved user as @user' do
        post :create, user: @invalid_user_attrs
        expect(assigns(:user)).to be_a_new(User)
      end

      describe 'with roles given' do

        it 'does not call assign_roles on User instance' do
          admin_role = FactoryGirl.create(:admin_role)
          expect_any_instance_of(User).not_to receive(:assign_roles).with([admin_role.id.to_param])
          post :create, user: @invalid_user_attrs, roles: [admin_role.id]
        end
      end

      describe 'with languages given' do

        it 'does not call assign_languages on User instance' do
          german = FactoryGirl.create(:german)
          expect_any_instance_of(User).not_to receive(:assign_languages).with([german.id])
          post :create, user: @invalid_user_attrs, languages: [german.id.to_param]
        end
      end

      it 're-renders the "new" template' do
        post :create, user: @invalid_user_attrs
        expect(response).to render_template('new')
      end

      describe 'with referent role given but no bank data' do
        before do
          @role = FactoryGirl.create(:referent_role)
        end

        it 'renders new template' do
          post :create, user: @user_attributes, roles: [@role.id]
          expect(response).to render_template('new')
        end

        it 'does not save the user' do
          expect { post :create, user: @user_attributes, roles: [@role.id] }.to change(User, :count).by(0)
        end
      end
    end
  end

  describe 'PUT update' do
    before do
      @referent = FactoryGirl.create(:referent)
    end

    describe 'with valid params' do
      let(:new_attributes) { { lastname: 'Married' } }

      it 'updates the requested user' do
        put :update, id: @referent, user: new_attributes
        @referent.reload
        expect(@referent.lastname).to eql 'Married'
      end

      it 'assigns the requested user as @user' do
        put :update, id: @referent, user: new_attributes
        expect(assigns(:user)).to eq @referent
      end

      it 'calls assign_roles on User instance' do
        admin_role = FactoryGirl.create(:admin_role)
        expect_any_instance_of(User).to receive(:assign_roles).with([admin_role.id.to_param])
        put :update, id: @referent, user: new_attributes, roles: [admin_role.id]
      end

      it 'calls assign_languages on User instance' do
        german = FactoryGirl.build(:german)
        expect_any_instance_of(User).to receive(:assign_languages).with([german.id])
        put :update, id: @referent, user: new_attributes, languages: [german.id]
      end

      it 'redirects to the users_path' do
        put :update, id: @referent, user: new_attributes
        @referent.reload
        expect(flash[:notice]).to eql "Nutzerdaten für #{ @referent.full_name } wurden geändert"
        expect(response).to redirect_to users_path
      end
    end

    describe 'with invalid params' do

      let(:invalid_attributes) { { username: '' } }

      it 'assigns the user as @user' do
        put :update, id: @referent, user: invalid_attributes
        expect(assigns(:user)).to eq(@referent)
      end

      it 'does not update the requested user' do
        put :update, id: @referent, user: invalid_attributes
        @referent.reload
        expect(@referent.username).not_to eql ''
      end

      it 'does not call assign_roles on User instance' do
        admin_role = FactoryGirl.create(:admin_role)
        expect_any_instance_of(User).not_to receive(:assign_roles).with([admin_role.id.to_param])
        put :update, id: @referent, user: invalid_attributes, roles: [admin_role.id]
      end

      it 'does not call assign_languages on User instance' do
        german = FactoryGirl.create(:german)
        expect_any_instance_of(User).not_to receive(:assign_languages).with([german.id])
        put :update, id: @referent, user: invalid_attributes, languages: [german.id]
      end

      it 'renders the "edit" template' do
        put :update, id: @referent, user: invalid_attributes
        expect(flash[:notice]).to be_nil
        expect(response).to render_template('edit')
      end

      describe 'with referent role given but no bank data' do

        it 'renders edit template' do
          put :update, id: @referent, user: { bank: '' }
          expect(response).to render_template('edit')
        end

        it 'does not save the user' do
          expect { put :update, id: @referent, user: { bank: '' } }.to change(User, :count).by(0)
        end
      end
    end
  end

  describe 'DELETE destroy' do

    context 'deleting myself' do
      it 'does not destroy the requested user' do
        expect { delete :destroy, id: User.first }.to change(User, :count).by(0)
      end

      it 'redirects to the users list' do
        delete :destroy, id: User.first
        expect(flash[:alert]).to eql 'Sie können eigenes Profil nicht löschen'
        expect(response).to redirect_to(users_url)
      end
    end

    context 'can_be_removed' do
      before do
        @user = FactoryGirl.create(:reader)
      end

      it 'destroys the requested user' do
        expect { delete :destroy, id: @user }.to change(User, :count).by(-1)
      end

      it 'redirects to the users list' do
        delete :destroy, id: @user
        expect(flash[:notice]).to eql 'Nutzer wurde gelöscht'
        expect(response).to redirect_to(users_url)
      end
    end

    context 'not can_be_removed' do

      before do
        @admin = FactoryGirl.create(:admin)
      end

      it 'does not destroy the requested user' do
        expect { delete :destroy, id: @admin }.to change(User, :count).by(0)
      end

      it 'redirects to the users list' do
        delete :destroy, id: @admin
        expect(flash[:alert]).to eql "#{ @admin.full_name } darf nicht gelöscht werden"
        expect(response).to redirect_to(users_url)
      end
    end
  end

  describe 'GET #home' do
    it 'renders home template' do
      get :home
      expect(response).to render_template :home
    end
  end
end
