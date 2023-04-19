require 'rails_helper'

RSpec.describe "Users", type: :request do

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
      allow(subject).to reeceive(:logged_in?).and_return(true)

      get :new 
      expect(response).to render_template(:new)
    end
  end

  describe "POST /users" do
    it "" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

end
