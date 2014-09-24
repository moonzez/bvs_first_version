require 'rails_helper'

RSpec.describe LicensesController, type: :controller do
  setup :activate_authlogic

  before do
    @user = FactoryGirl.create(:user)
    UserSession.create(username: @user.username, password: @user.password)
    @license = FactoryGirl.create(:license)
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

    context "license not is_in_use" do

      it "deletes license" do
        expect { delete :destroy, id: @license, format: :js }.to change(License,:count).by -1
      end

      it "renders the destroy.js.erb" do
        delete :destroy, id: @license, format: :js
        expect(response.content_type).to eql "text/javascript"
        expect(response).to render_template :destroy
      end
    end

    context "license is_in_use" do

      it "doesn't delete the license" do
        @user.licenses << @license
        expect { delete :destroy, id: @license, format: :js }.to change(License,:count).by 0
      end

      it "adds error to license" do
        @user.licenses << @license
        delete :destroy, id: @license, format: :js
        expect(assigns(:license).errors[:base]).to include(I18n.t('is_in_use', what: @license.title))
      end

      it "renders the destroy.js.erb" do
        @user.licenses << @license
        delete :destroy, id: @license, format: :js
        expect(response.content_type).to eql "text/javascript"
        expect(response).to render_template :destroy
      end
    end
  end

  describe "GET #index" do

    it "assignes a new license to @license" do
      get :index
      expect(assigns(:license)).to be_new_record
      expect(assigns(:license)).to be_a_kind_of License
    end

    it "assignes all existend licenses to @licenses" do
      license = FactoryGirl.create(:license)
      get :index
      expect(assigns(:licenses)).to match_array [@license, license]
    end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "POST #create" do

    context "with valid attributes" do

      it "saves a new license in the database" do
        expect { post :create, license: { :title => "HTS License", shortcut: "hts" } }.to change(License,:count).by 1
      end

      it "redirects to license_path" do
        post :create, license: { :title => "HTS License", shortcut: "hts" }
        expect(flash[:alert]).to be_nil
        expect(flash[:notice]).not_to be_nil
        expect(response).to redirect_to licenses_path
      end
    end

    context "with invalid attributes" do

      it "does not save a new license in the database" do
        expect { post :create, license: { :title => "" } }.to change(License,:count).by 0
      end

      it "redirects to license_path" do
        post :create, license: { :title => "" }
        expect(flash[:alert]).not_to be_nil
        expect(response).to redirect_to licenses_path
      end
    end
  end

end
