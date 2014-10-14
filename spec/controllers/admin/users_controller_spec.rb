require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do
  setup :activate_authlogic

  before do
    @admin = FactoryGirl.create(:admin, lastname: 'Baba')
    UserSession.create(username: @admin.username, password: @admin.password)
  end

  describe 'GET #index' do

    context 'not admin user' do
      it 'redirects to rote' do
        UserSession.find.destroy
        @not_admin = FactoryGirl.create(:user, lastname: 'Baba')
        UserSession.create(username: @not_admin.username, password: @not_admin.password)
        get :index
        expect(response).to redirect_to root_path
        expect(flash[:alert]).to eql 'Diese Aktion darf nur vom admin durchgeführt werden'
      end
    end

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
        expect(assigns(:users)).to match_array [@admin, user1]
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
      admin = Role.find_by(title: 'admin')
      referent = FactoryGirl.create(:referent_role)
      get :new
      expect(assigns(:roles)).to match_array [admin, referent]
    end

    it 'assigns all licenses to @licenses' do
      license_a = FactoryGirl.create(:license)
      license_b = FactoryGirl.create(:license)
      get :new
      expect(assigns(:licenses)).to match_array [license_a, license_b]
    end

    it 'renders new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'GET edit' do

    it 'assigns the requested user as @user' do
      get :edit, id: @admin
      expect(assigns(:user)).to eq(@admin)
    end

    it 'assigns all languages to @languages' do
      german = FactoryGirl.create(:german)
      english = FactoryGirl.create(:english)
      get :edit, id: @admin
      expect(assigns(:languages)).to match_array [german, english]
    end

    it 'assigns all roles to @roles' do
      admin = Role.find_by(title: 'admin')
      referent = FactoryGirl.create(:referent_role)
      get :edit, id: @admin
      expect(assigns(:roles)).to match_array [admin, referent]
    end

    it 'assigns all licenses to @licenses' do
      license_a = FactoryGirl.create(:license)
      license_b = FactoryGirl.create(:license)
      get :edit, id: @admin
      expect(assigns(:licenses)).to match_array [license_a, license_b]
    end

    it 'renders edit template' do
      get :edit, id: @admin
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
        expect(response).to redirect_to(admin_users_path)
      end

      it 'assigns all languages to @languages' do
        german = FactoryGirl.create(:german)
        english = FactoryGirl.create(:english)
        post :create, user: @user_attributes
        expect(assigns(:languages)).to match_array [german, english]
      end

      it 'assigns all roles to @roles' do
        admin = Role.find_by(title: 'admin')
        referent = FactoryGirl.create(:referent_role)
        post :create, user: @user_attributes
        expect(assigns(:roles)).to match_array [admin, referent]
      end

      it 'assigns all licenses to @licenses' do
        license_a = FactoryGirl.create(:license)
        license_b = FactoryGirl.create(:license)
        post :create, user: @user_attributes
        expect(assigns(:licenses)).to match_array [license_a, license_b]
      end

      context 'save_with_params' do
        it 'calls with roles, languages, licenses if given' do
          admin_role = Role.find_by(title: 'admin')
          german = FactoryGirl.build(:german)
          license = FactoryGirl.create(:license)
          expect_any_instance_of(User).to receive(:save_with_params)
            .with([admin_role.id.to_param], [german.id.to_param], [license.id.to_param])
          post :create, user: @user_attributes,
            roles: [admin_role.id], languages: [german.id], licenses: [license.id]
        end

        it 'calls with roles, nil, nil if no language and no licenses given' do
          admin_role = Role.find_by(title: 'admin')
          expect_any_instance_of(User).to receive(:save_with_params)
            .with([admin_role.id.to_param], nil, nil)
          post :create, user: @user_attributes, roles: [admin_role.id]
        end

        it 'calls with roles, nil, licenses if given' do
          admin_role = Role.find_by(title: 'admin')
          license = FactoryGirl.create(:license)
          expect_any_instance_of(User).to receive(:save_with_params)
            .with([admin_role.id.to_param], nil, [license.id.to_param])
          post :create, user: @user_attributes, roles: [admin_role.id],
            roles: [admin_role.id], licenses: [license.id]
        end
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

      it 'assigns all languages to @languages' do
        german = FactoryGirl.create(:german)
        english = FactoryGirl.create(:english)
        put :update, id: @referent, user: new_attributes
        expect(assigns(:languages)).to match_array [german, english]
      end

      it 'assigns all roles to @roles' do
        admin_role = Role.find_by(title: 'admin')
        referent = (Role.find_by(title: 'referent') || FactoryGirl.create(:referent_role))
        put :update, id: @referent, user: new_attributes
        expect(assigns(:roles)).to match_array [admin_role, referent]
      end

      it 'assigns all licenses to @licenses' do
        license_a = FactoryGirl.create(:license)
        license_b = FactoryGirl.create(:license)
        put :update, id: @referent, user: new_attributes
        expect(assigns(:licenses)).to match_array [license_a, license_b]
      end

      context 'update_with_params' do
        it 'calls with roles, languages, licenses if given' do
          admin_role = Role.find_by(title: 'admin')
          german = FactoryGirl.build(:german)
          license = FactoryGirl.create(:license)
          expect_any_instance_of(User).to receive(:update_with_params)
            .with(new_attributes, [admin_role.id.to_param], [german.id.to_param], [license.id.to_param])
          put :update, id: @referent, user: new_attributes, roles: [admin_role.id],
            languages: [german.id], licenses: [license.id]
        end

        it 'calls with roles, nil, nil if no language and no licenses given' do
          admin_role = Role.find_by(title: 'admin')
          expect_any_instance_of(User).to receive(:update_with_params)
            .with(new_attributes, [admin_role.id.to_param], nil, nil)
          put :update, id: @referent, user: new_attributes, roles: [admin_role.id]
        end

        it 'calls with roles, nil, licenses if given' do
          admin_role = Role.find_by(title: 'admin')
          license = FactoryGirl.create(:license)
          expect_any_instance_of(User).to receive(:update_with_params)
            .with(new_attributes, [admin_role.id.to_param], nil, [license.id.to_param])
          put :update, id: @referent, user: new_attributes, roles: [admin_role.id], licenses: [license.id]
        end
      end

      it 'redirects to the admin_users_path' do
        put :update, id: @referent, user: new_attributes
        @referent.reload
        expect(flash[:notice]).to eql "Nutzerdaten für #{ @referent.full_name } wurden geändert"
        expect(response).to redirect_to admin_users_path
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

      it 'does not assign roles, languages, licenses' do
        admin_role = Role.find_by(title: 'admin')
        german = FactoryGirl.build(:german)
        license = FactoryGirl.create(:license)
        put :update, id: @referent, user: invalid_attributes, roles: [admin_role.id],
          languages: [german.id], licenses: [license.id]
        @referent.reload
        expect(@referent.roles).to match_array [Role.find_by(title: 'referent')]
        expect(@referent.languages).to match_array []
        expect(@referent.licenses).to match_array []
      end

      it 'does not call assign_roles on User instance' do
        admin_role = Role.find_by(title: 'admin')
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
      it 'assigns user to @user' do
        delete :destroy, id: User.first, format: :js
        expect(assigns(:user)).to eql User.first
      end

      it 'does not destroy the current user' do
        expect { delete :destroy, id: User.first, format: :js }.to change(User, :count).by(0)
      end

      it 'adds error to @user' do
        delete :destroy, id: User.first, format: :js
        expect(assigns(:user).errors[:base]).to eql ['Sie können eigenes Profil nicht löschen']
      end

      it 'renders destroj.js.erb' do
        delete :destroy, id: User.first, format: :js
        expect(response.content_type).to eql 'text/javascript'
        expect(response).to render_template :destroy
      end
    end

    context 'delete user' do
      before do
        @reader = FactoryGirl.create(:reader)
      end

      it 'destroys the requested user' do
        expect { delete :destroy, id: @reader, format: :js }.to change(User, :count).by(-1)
      end

      it 'renders destroj.js.erb' do
        delete :destroy, id: @reader.id, format: :js
        expect(response.content_type).to eql 'text/javascript'
        expect(response).to render_template :destroy
      end
    end
  end
end
