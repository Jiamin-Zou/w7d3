require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #index" do
    it "renders the user index" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "renders a user's show template" do
      test_user = FactoryBot.create(:user)
      get :show, params: { id: test_user.id }
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "brings up the form to make a new user" do
      # allow(subject).to receive(:logged_in?).and_return(true)

      get :new 
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do

    let(:valid_params) {{user: {username: "BigJer", password: "grandma"}}}
    let(:invalid_params) {{user: {username: "", password: "123"}}}
    context "with valid params" do
      it "creates the user" do
        post :create, params: valid_params
        expect(User.last.username).to eq("BigJer")
      end
      it "redirects to user's show page" do 
        post :create, params: valid_params
        expect(response).to redirect_to(user_url(User.last.id))
      end
  end

    context "with invalid params" do 
        before :each do
            post :create, params: invalid_params
        end

        it "renders new template" do 
            expect(response).to have_http_status(422)
            expect(response).to render_template(:new)
        end

        it "add errors to flash" do 
            expect(flash[:errors]).to be_present
        end
      end
  end

end
