require 'rails_helper'

RSpec.describe LanguagesController, :type => :controller do

  setup :activate_authlogic

  before do
    @user = FactoryGirl.create(:user)
    UserSession.create(username: @user.username, password: @user.password)
    @language = FactoryGirl.create(:language)
  end

  describe "when not loggen in" do
    it "redirects to login page" do
      user_session = UserSession.find
      user_session.destroy
      get :index
      expect(response).to redirect_to login_path
    end
  end

  describe "DELETE #destroy" do

    context "language not is_in_use" do

      it "deletes language" do
        expect { delete :destroy, id: @language, format: :js }.to change(Language,:count).by -1
      end

      it "renders the destroy.js.erb" do
        delete :destroy, id: @language, format: :js
        expect(response.content_type).to eql "text/javascript"
        expect(response).to render_template :destroy
      end
    end

    context "language is_in_use" do

      it "doesn't delete the language" do
        @user.languages << @language
        expect { delete :destroy, id: @language, format: :js }.to change(Language,:count).by 0
      end

      it "adds error to language" do
        @user.languages << @language
        delete :destroy, id: @language, format: :js
        expect(assigns(:language).errors[:base]).to include(I18n.t('is_in_use', what: @language.language))
      end

      it "renders the destroy.js.erb" do
        @user.languages << @language
        delete :destroy, id: @language, format: :js
        expect(response.content_type).to eql "text/javascript"
        expect(response).to render_template :destroy
      end
    end
  end

  describe "GET #index" do

    it "assignes a new language to @language" do
      get :index
      expect(assigns(:language)).to be_new_record
      expect(assigns(:language)).to be_a_kind_of Language
    end

    it "assignes all existend languages to @languages" do
      english = FactoryGirl.create(:english)
      get :index
      expect(assigns(:languages)).to match_array [@language, english]
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do

    context "with valid attributes" do

      it "saves a new language in the database" do
        expect { post :create, language: { :language => "German" } }.to change(Language,:count).by 1
      end

      it "redirects to language_path" do
        post :create, language: { :language => "German" }
        expect(flash[:alert]).to be_nil
        expect(flash[:notice]).not_to be_nil
        expect(response).to redirect_to languages_path
      end
    end

    context "with invalid attributes" do

      it "does not save a new language in the database" do
        expect { post :create, language: { :language => "" } }.to change(Language,:count).by 0
      end

      it "redirects to language_path" do
        post :create, language: { :language => "" }
        expect(flash[:alert]).not_to be_nil
        expect(response).to redirect_to languages_path
      end
    end
  end
end
