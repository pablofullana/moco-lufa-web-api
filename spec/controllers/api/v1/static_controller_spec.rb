require 'rails_helper'

RSpec.describe Api::V1::StaticController, type: :controller do

  describe "GET #server_setup" do
    it "returns http success" do
      get :server_setup
      expect(response).to have_http_status(:success)
    end
  end

end
