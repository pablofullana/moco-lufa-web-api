require 'rails_helper'

RSpec.describe Api::V1::FirmwaresController, type: :controller do
  describe "GET #index" do
    let!(:firmwares) { create_list(:firmware, 5) }

    before do
      get :index
    end

    it 'returns all the existing firmwares' do
      expect(response.body).to eq firmwares.reverse.to_json
    end
  end

  describe "POST #create" do
    pending
  end
end
