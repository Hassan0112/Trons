require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  let(:user)  {create(:user)}

  describe "GET #new" do
    it "renders new template" do
      get :new
      expect(response).to render_template("new")
    end 
  end


  describe "GET #profile" do
    it "renders the profile template" do
      sign_in user
      get :profile
      expect(response).to render_template("profile")
    end
  end
 

  describe "POST #create" do
    context "with valid attributes" do
      it "creates a new user" do
        expect {
          post :create, params: {user: attributes_for(:user)}
        }.to change(User, :count).by(1)
      end
      
      it "redirects to root path" do
        post :create, params:{user: attributes_for(:user)}
        expect(response).to redirect_to(root_path)
      end

    end

    context "with invaid attributes" do 
      it "render the new template" do
        post :create, params: {user: attributes_for(:user, email: nil) }
        expect(response).to render_template("new")
      end
    end

  end


  describe "GET #edit" do
    it "renders the edit template" do
      sign_in user
      get :edit
      expect(response).to render_template("edit")
    end
  end


  describe "PATCH #update" do

    context "with valid attributes" do
      it "updates user profile" do
        sign_in user
        patch :update, params: {user: { full_name: "Updated Name" } }
        expect(user.reload.full_name).to eq("Updated Name")
      end
      
      it "redirect to root path" do
        sign_in user
        patch :update, params: {user: { full_name: "Updated Name" } }
        expect(response).to redirect_to(root_path)
      end
    
    end

    context "with invalid attributes" do
      it "renders the edit template" do
        sign_in user
        patch :update, params: {user: {email: nil } }
        expect(response).to render_template("edit")
      end
    end

  end


  describe "GET #edit_password" do
    it "renders the edit password template" do
      sign_in user
      get :edit_password
      expect(response).to render_template("edit_password")
    end
  end

  describe "PATCH #update_password" do
    context "with valid parameters" do
      it "updates user password and redirects to root path" do
        sign_in user
        patch :update_password, params: { user: { current_password: user.password, password: "new_password", password_confirmation: "new_password" } }
        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Password successfully updated.")
      end
    end

    context "with invalid current password" do
      it "renders the edit password template and sets flash alert" do
        sign_in user
        patch :update_password, params: { user: { current_password: "invalid_password", password: "new_password", password_confirmation: "new_password" } }
        expect(response).to render_template("edit_password")
        expect(flash.now[:custom_alert]).to eq("Incorrect current password.")
      end
    end

    context "with invalid new password confirmation" do
      it "renders the edit password template and sets flash alert" do
        sign_in user
        patch :update_password, params: { user: { current_password: user.password, password: "new_password", password_confirmation: "invalid_confirmation" } }
        expect(response).to render_template("edit_password")
        expect(flash.now[:custom_alert]).to eq("Password confirmation doesn't match Password")
      end
    end
  end

end