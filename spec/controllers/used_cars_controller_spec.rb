require 'rails_helper'

RSpec.describe UsedCarsController do
  include Devise::Test::ControllerHelpers

  let(:user)  {create(:user)}

  describe "GET #post_ad" do
    it "returns http success" do
      sign_in user
      get :post_ad
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new_ad" do
    it "assigns a new UserAdd to @user_add" do
      sign_in user
      get :new_ad
      user_add = assigns(:user_add)
      expect(user_add).not_to be_nil
      expect(user_add).to be_a_new(UserAdd)
    end
  end

  describe "POST #submit_form" do
    context "with valid parameters" do
      let(:image_paths) do
        [
          Rails.root.join('app', 'assets', 'images', 'carphoto.jpeg'),
          Rails.root.join('app', 'assets', 'images', 'carphoto.jpeg') 
        ]
      end
      let(:images) { image_paths.map { |path| fixture_file_upload(path, 'image/jpeg') } }

      let(:valid_params) do
        FactoryBot.attributes_for(:user_add, user_id: user.id).merge(
          images: images
        )
      end

      it "creates a new advertisement" do
        sign_in user
        expect {
          post :submit_form, params: { user_add: valid_params }
        }.to change(UserAdd, :count).by(1)
      end

      it "sets a success notice" do
        sign_in user
        post :submit_form, params: { user_add: valid_params }
        expect(flash[:notice]).to eq("Car Add Submitted Successfully.")
      end
    end

    context "with invalid params" do
      let(:invalid_params) { { user_add: { city: "", registered_in: "Un-Rigistered", user_id: user.id } } }

      it "does not create a new advertisement" do
        expect {
          post :submit_form, params: invalid_params
        }.not_to change(UserAdd, :count)
      end

      it "renders the new_ad template when submission is invalid" do
        post :submit_form, params: invalid_params
        expect(response).to redirect_to(new_user_session_path)
      end
      
    end
  end
end