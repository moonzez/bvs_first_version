require 'rails_helper'

RSpec.describe ReferentsController, type: :controller do
  setup :activate_authlogic

  before do
    @user = FactoryGirl.create(:user, lastname: 'Baba')
    UserSession.create(username: @user.username, password: @user.password)
    FactoryGirl.create(:referent_role)
  end

  describe 'GET #index' do

    context 'with param selected_letter "A"' do
      it 'assigns params @selected_letter' do
        get :index, selected_letter: 'A'
        expect(assigns(:selected_letter)).to eql 'A'
      end

      it 'assigns all referents with lastname starting with selected_letter to @referents' do
        referent1 = FactoryGirl.create(:referent, lastname: 'Achti')
        get :index, selected_letter: 'A'
        expect(assigns(:referents)).to match_array [referent1]
        expect(assigns(:all_letters)).not_to be_nil
      end
    end

    context 'without selected_letter param' do

      it 'assignes "*" to @selected_letter' do
        get :index
        expect(assigns(:selected_letter)).to eql '*'
      end

      it 'assigns all referents to @referents' do
        referent1 = FactoryGirl.create(:referent, lastname: 'Achti')
        FactoryGirl.create(:dbuser, lastname: 'Bachti')
        get :index
        expect(assigns(:referents)).to match_array [referent1]
      end

      it 'assigns only referents first latter to all_letters' do
        referent1 = FactoryGirl.create(:referent, lastname: 'Achti')
        FactoryGirl.create(:dbuser, lastname: 'Bachti')
        get :index
        expect(assigns(:referents)).to match_array [referent1]
        expect(assigns(:all_letters)).to eql ['*', 'A']
      end
    end

    it 'gets only activ and temporary inactiv referents' do
      activ = FactoryGirl.create(:referent, activ: 'activ')
      temporary_inactiv = FactoryGirl.create(:referent, activ: 'temporary')
      FactoryGirl.create(:referent, activ: 'inactiv')
      get :index
      expect(assigns(:referents)).to match_array [activ, temporary_inactiv]
    end

    it 'renders index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do

    it 'assigns a new user as @referent' do
      get :new
      expect(assigns(:referent)).to be_a_new(User)
    end

    it 'assigns all licenses to @licenses' do
      license_a = FactoryGirl.create(:license)
      license_b = FactoryGirl.create(:license)
      get :new
      expect(assigns(:licenses)).to match_array [license_a, license_b]
    end

    it 'assigns all languages to @languages' do
      german = FactoryGirl.create(:german)
      english = FactoryGirl.create(:english)
      get :new
      expect(assigns(:languages)).to match_array [german, english]
    end

    it 'renders new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do

    before do
      @referent_attributes = FactoryGirl.attributes_for(:referent)
    end

    context 'with valid params' do
      it 'creates a new referent User' do
        expect { post :create, referent: @referent_attributes }.to change(User, :count).by(1)
      end

      it 'assigns all licenses to @licenses' do
        license_a = FactoryGirl.create(:license)
        license_b = FactoryGirl.create(:license)
        post :create, referent: @referent_attributes
        expect(assigns(:licenses)).to match_array [license_a, license_b]
      end

      it 'assigns all languages to @languages' do
        german = FactoryGirl.create(:german)
        english = FactoryGirl.create(:english)
        post :create, referent: @referent_attributes
        expect(assigns(:languages)).to match_array [german, english]
      end

      it 'assigns a newly created user as @referent' do
        post :create, referent: @referent_attributes
        expect(assigns(:referent)).to be_a(User)
        expect(assigns(:referent)).to be_persisted
      end

      it 'redirects to all referents' do
        post :create, referent: @referent_attributes
        expect(flash[:notice]).to eql "Referent #{ User.last.full_name } wurde angelegt"
        expect(response).to redirect_to(referents_path)
      end

      context 'save_referent_with_params' do

        it 'calls with languages and nil when no license' do
          german = FactoryGirl.create(:german)
          expect_any_instance_of(User).to receive(:save_referent_with_params).with([german.id.to_param], nil)
          post :create, referent: @referent_attributes, languages: [german.id]
        end

        it 'calls with nil and licenses when no languages' do
          license_a = FactoryGirl.create(:license)
          expect_any_instance_of(User).to receive(:save_referent_with_params)
            .with(nil, [license_a.id.to_param])
          post :create, referent: @referent_attributes, licenses: [license_a.id]
        end

        it 'calls with languages and licenses' do
          german = FactoryGirl.create(:german)
          license_a = FactoryGirl.create(:license)
          expect_any_instance_of(User).to receive(:save_referent_with_params)
            .with([german.id.to_param], [license_a.id.to_param])
          post :create, referent: @referent_attributes, languages: [german.id], licenses: [license_a.id]
        end
      end
    end

    context 'with invalid params' do
      before do
        @invalid_user_attrs = FactoryGirl.attributes_for(:invalid_user)
      end

      it 'assigns a newly created but unsaved user as @referent' do
        post :create, referent: @invalid_user_attrs
        expect(assigns(:referent)).to be_a_new(User)
      end

      it 're-renders the "new" template' do
        post :create, referent: @invalid_user_attrs
        expect(response).to render_template('new')
      end
    end
  end

  describe 'GET #change_activ' do
    before do
      @referent = FactoryGirl.create(:referent, activ: 'temporary')
    end

    it 'assigns referent' do
      put :change_activ, activ: 'activ', id: @referent.id, format: :js
      expect(assigns(:referent)).to be_a_kind_of User
    end

    it 'calls change_activ on referent' do
      expect_any_instance_of(User).to receive(:change_activ).with('activ')
      put :change_activ, activ: 'activ', id: @referent.id, format: :js
    end

    it 'renders change_activ.js.erb' do
      put :change_activ, activ: 'activ', id: @referent.id, format: :js
      expect(response.content_type).to eql 'text/javascript'
      expect(response).to render_template :change_activ
    end
  end

  describe 'GET #edit' do
    before do
      @referent = FactoryGirl.create(:referent, activ: 'temporary')
    end

    it 'assigns referent' do
      get :edit, id: @referent.id
      expect(assigns(:referent)).to eql @referent
    end

    it 'assigns all licenses to @licenses' do
      license_a = FactoryGirl.create(:license)
      license_b = FactoryGirl.create(:license)
      get :edit, id: @referent.id
      expect(assigns(:licenses)).to match_array [license_a, license_b]
    end

    it 'assigns all languages to @languages' do
      german = FactoryGirl.create(:german)
      english = FactoryGirl.create(:english)
      get :edit, id: @referent.id
      expect(assigns(:languages)).to match_array [german, english]
    end

    it 'renders edit template' do
      get :edit, id: @referent.id
      expect(response).to render_template :edit
    end
  end

  describe 'PUT #update' do
    before do
      @referent = FactoryGirl.create(:referent, activ: 'temporary')
    end

    context 'on success' do
      before do
        @update_attrs = { lastname: 'Married' }
      end

      it 'assignes referent' do
        put :update, id: @referent.id, referent: @update_attrs
        expect(assigns(:referent)).to eql @referent
      end

      it 'assigns all licenses to @licenses' do
        license_a = FactoryGirl.create(:license)
        license_b = FactoryGirl.create(:license)
        put :update, id: @referent.id, referent: @update_attrs
        expect(assigns(:licenses)).to match_array [license_a, license_b]
      end

      it 'assigns all languages to @languages' do
        german = FactoryGirl.create(:german)
        english = FactoryGirl.create(:english)
        put :update, id: @referent.id, referent: @update_attrs
        expect(assigns(:languages)).to match_array [german, english]
      end

      it 'updates referent object' do
        put :update, id: @referent.id, referent: @update_attrs
        @referent.reload
        expect(@referent.lastname).to eql 'Married'
      end

      context 'update_referent_with_params' do
        it 'calls with languages and nil when no licenses given' do
          german = FactoryGirl.create(:german)
          expect_any_instance_of(User).to receive(:update_referent_with_params)
            .with(@update_attrs, [german.id.to_param], nil)
          put :update, id: @referent.id, referent: @update_attrs, languages: [german.id]
        end

        it 'calls with nil and licenses when no language given' do
          license_a = FactoryGirl.create(:license)
          expect_any_instance_of(User).to receive(:update_referent_with_params)
            .with(@update_attrs, nil, [license_a.id.to_param])
          put :update, id: @referent.id, referent: @update_attrs, licenses: [license_a.id]
        end

        it 'calls with languages and licenses' do
          german = FactoryGirl.create(:german)
          license_a = FactoryGirl.create(:license)
          expect_any_instance_of(User).to receive(:update_referent_with_params)
            .with(@update_attrs, [german.id.to_param], [license_a.id.to_param])
          put :update, id: @referent.id, referent: @update_attrs,
              languages: [german.id], licenses: [license_a.id]
        end
      end

      it 'redirects_to referents index' do
        put :update, id: @referent.id, referent: @update_attrs
        expect(response).to redirect_to(referents_path)
        expect(flash[:notice]).to eql "Referentendaten für #{ @referent.reload.full_name } wurden geändert"
      end
    end

    it 'renders edit id errors' do
      put :update, id: @referent.id, referent: { firstname: '' }
      expect(response).to render_template :edit
    end
  end

  describe 'DELETE #remove' do
    before do
      @referent = FactoryGirl.create(:referent, activ: 'temporary')
    end

    it 'assignes referent' do
      delete :remove, id: @referent.id, format: :js
      expect(assigns(:referent)).to eql @referent
    end

    it 'renders remove.js.erb template' do
      delete :remove, id: @referent.id, format: :js
      expect(response.content_type).to eql 'text/javascript'
      expect(response).to render_template :remove
    end

  end

  describe 'GET #inactiv' do
    it 'assigns only inactiv referents to @referents' do
      referent1 = FactoryGirl.create(:referent, lastname: 'Achti', activ: 'inactiv')
      FactoryGirl.create(:dbuser, lastname: 'Bachti', activ: 'activ')
      get :inactiv
      expect(assigns(:referents)).to match_array [referent1]
    end

    context 'without selected_letter param' do
      it 'assigns only referents first latter to all_letters' do
        referent1 = FactoryGirl.create(:referent, lastname: 'Achti', activ: 'inactiv')
        referent2 = FactoryGirl.create(:referent, lastname: 'Bachti', activ: 'inactiv')
        get :inactiv
        expect(assigns(:referents)).to match_array [referent1, referent2]
        expect(assigns(:all_letters)).to eql ['*', 'A', 'B']
      end

      it 'assignes "*" to @selected_letter' do
        get :inactiv
        expect(assigns(:selected_letter)).to eql '*'
      end
    end

    context 'with param selected_letter "A"' do
      it 'assigns params @selected_letter' do
        get :inactiv, selected_letter: 'A'
        expect(assigns(:selected_letter)).to eql 'A'
      end

      it 'assigns inactiv referents with lastname starting with selected_letter to @referents' do
        referent1 = FactoryGirl.create(:referent, lastname: 'Achti', activ: 'inactiv')
        FactoryGirl.create(:referent, lastname: 'Bachti', activ: 'inactiv')
        get :inactiv, selected_letter: 'A'
        expect(assigns(:referents)).to match_array [referent1]
        expect(assigns(:all_letters)).not_to be_nil
      end
    end

    it 'renders inactiv template' do
      get :inactiv
      expect(response).to render_template :inactiv
    end
  end
end
