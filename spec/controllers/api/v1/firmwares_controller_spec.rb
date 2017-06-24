require 'rails_helper'

RSpec.describe Api::V1::FirmwaresController, type: :controller do

  describe "GET #index" do
    let!(:firmwares) do
      5.times { |i| Firmware.create name: i.to_s, manufacturer: i.to_s, arduino_model: 'uno'}
      Firmware.all
    end

    before do
      get :index
    end

    it 'returns all the existing firmwares' do
      expect(response.body).to eq firmwares.order(created_at: :desc).to_json
    end
  end

  describe "POST #create" do
    pending
  end
end
