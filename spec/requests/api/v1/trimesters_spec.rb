require 'rails_helper'

RSpec.describe "Trimesters", type: :request do
  describe "GET /trimesters" do
    let!(:trimester1) { 
      Trimester.create!(
        term: "Term 1", 
        year: 2025, 
        start_date: Date.today, 
        end_date: Date.today + 90, 
        application_deadline: Date.today - 30
      ) 
    }
    let!(:trimester2) { 
      Trimester.create!(
        term: "Term 2", 
        year: 2025, 
        start_date: Date.today + 100, 
        end_date: Date.today + 190, 
        application_deadline: Date.today + 70
      ) 
    }

    it "returns a JSON response containing all trimesters" do
      get "/trimesters"
      json_response = JSON.parse(response.body)

      expect(json_response.map { |t| t["term"] }).to include("Term 1", "Term 2")
      expect(json_response.map { |t| t["year"].to_i }).to include(2025)
    end

    it "returns an empty array if no trimesters exist" do
      Trimester.destroy_all
      get "/trimesters"
      json_response = JSON.parse(response.body)

      expect(json_response).to eq([])
    end
  end
end
