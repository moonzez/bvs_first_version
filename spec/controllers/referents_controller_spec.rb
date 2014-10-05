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

      it 'assigns all users to @users' do
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

    describe 'with valid params' do
      it 'creates a new referent User' do
        expect { post :create, referent: @referent_attributes }.to change(User, :count).by(1)
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

      it 'calls save_referent_with_params with languages array' do
        german = FactoryGirl.create(:german)
        expect_any_instance_of(User).to receive(:save_referent_with_params).with([german.id.to_param])
        post :create, referent: @referent_attributes, languages: [german.id]
      end
    end

    describe 'with invalid params' do
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
end
