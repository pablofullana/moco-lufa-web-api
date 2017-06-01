require 'rails_helper'

RSpec.describe Api::V1::StaticController, type: :controller do

  describe "GET #info" do
    it "returns http success" do
      get :info
      expect(response).to have_http_status(:success)
    end
  end

end
