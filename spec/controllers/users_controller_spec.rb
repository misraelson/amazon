require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#new" do
    before { get :new }

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns a new user variable" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "#create" do
      context "user with valid parameters" do
        def valid_request
          post :create, user: FactoryGirl.attributes_for(:user)
        end
        it "add a new user record to the database" do
          count_before = User.count
          valid_request
          count_after = User.count
          expect(count_after).to eq(count_before + 1)
        end
        it "redirects to the home page" do
          valid_request
          expect(response).to redirect_to(root_path)
        end
        it "sends a flash message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end


    context "with invalid user parameters" do
      def invalid_request
        post :create, user: FactoryGirl.attributes_for(:user).merge(first_name: nil)
      end
      it "doesn't add a record to the database" do
        count_before = User.count
        invalid_request
        count_after = User.count
        expect(count_after).to eq(count_before)
      end
      it "renders the new template" do
        invalid_request
        expect(response).to render_template(:new)
      end
    end
  end
end
