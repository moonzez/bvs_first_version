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

end
