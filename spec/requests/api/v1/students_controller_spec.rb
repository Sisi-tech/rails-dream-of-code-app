require 'rails_helper'

RSpec.describe "Api::V1::Students", type: :request do
  describe "POST /api/v1/students" do
    let(:valid_attributes) do
      {
        student: {
          first_name: "Jenny",
          last_name: "Kim",
          email: 'JaneKim@example.com'
        }
      }
    end

    it "debug create student" do
      post '/api/v1/students', 
        params: valid_attributes.to_json,
        headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    
      puts "Response status: #{response.status}"
      puts "Response body  : #{response.body}"
    
      expect(response).to have_http_status(:created)
    end
    
    
  end
end
