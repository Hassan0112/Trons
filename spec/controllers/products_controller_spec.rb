# spec/controllers/products_controller_spec.rb
require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:valid_attributes) {
    attributes_for(:sellitforme_form).merge(user_id: user.id)
  }
  let(:invalid_attributes) {
    { model_year: nil, car_info: nil }
  }

  before do
    sign_in user
  end

  describe "GET #pakwheels_sell_it_for_me_new" do
    it "initializes a new SellitformeForm" do
      get :pakwheels_sell_it_for_me_new
    end
  end

  describe "POST #submit_form" do
    context "with valid params" do
      it "creates a new SellitformeForm and sends a verification code" do
        post :submit_form, params: { sellitforme_form: valid_attributes }
        expect(session[:verification_code]).not_to be_nil
        expect(response).to redirect_to(account_verification_path)
        expect(flash[:notice]).to eq("Verification code sent successfully.")
      end
    end

    context "with invalid params" do
      it "re-renders the 'pakwheels_sell_it_for_me_new' template" do
        post :submit_form, params: { sellitforme_form: invalid_attributes }
        expect(assigns(:sellitforme_form)).to be_a_new(SellitformeForm)
        expect(assigns(:sellitforme_form).errors).not_to be_empty
        expect(response).to render_template("pakwheels_sell_it_for_me_new")
      end
    end
  end

  describe "POST #verify_code" do
    before do
      session[:verification_code] = "1234"
    end

    context "with correct verification code" do
      it "verfiy the phone number and redirect to root path" do
        post :verify_code, params: { verification_code: "1234" }
        expect(flash[:notice]).to eq("Phone number verified successfully.")
        expect(response).to redirect_to (root_path)
        expect(session[:verification_code]).to be_nil
      end
    end

    context "with incorrect verification code" do
      it "does not verify phone number and redirect to account verfication path" do
        post :verify_code, params: { verification_code: "0000" }
        expect(flash[:alert]).to eq("Invalid verification code. Please try again.")
        expect(response).to redirect_to(account_verification_path)
      end
    end
  end
   
  describe "POST #resend_code" do
    it "resends the verification code and returns success" do
      post :resend_code
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body)["success"]).to be_truthy
    end
  end


end