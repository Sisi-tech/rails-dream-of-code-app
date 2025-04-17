require 'rails_helper'

RSpec.describe "Courses", type: :request do
  # Set up current, past and future trimesters and courses for each
  let!(:current_trimester) {
    Trimester.create!(
      term: "Current term",
      year: "Year",
      start_date: Date.today - 1.month,
      end_date: Date.today + 2.months,
      application_deadline: Date.today - 1.month)
  }
  let!(:past_trimester) {
    Trimester.create!(
      term: "Past term",
      year: "Past Year",
      start_date: Date.today - 1.year,
      end_date: Date.today - 1.year - 3.months,
      application_deadline: Date.today - 1.year)
  }
  let!(:upcoming_trimester) {
    Trimester.create!(
      term: "Upcoming term",
      year: "Future Year",
      start_date: Date.today + 1.year,
      end_date: Date.today + 1.year + 3.months,
      application_deadline: Date.today + 1.month)
  }
  let(:coding_class) {
    CodingClass.create!(
      title: "Intro to Javascript"
    )
  }
  let!(:past_course) {
    Course.create!(
      coding_class_id: coding_class.id,
      trimester_id: past_trimester.id)
  }
  let!(:upcoming_course) {
    Course.create!(
      coding_class_id: coding_class.id,
      trimester_id: upcoming_trimester.id)
  }
  let!(:current_course) {
    Course.create!(
      coding_class_id: coding_class.id,
      trimester_id: current_trimester.id)
  }

  describe "GET /courses" do
    it "returns a list of courses" do
      get '/courses', headers: { 'ACCEPT' => 'application/json' }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['courses']).to be_an(Array)
      expect(JSON.parse(response.body)['courses'].size).to eq(1)
      expect(JSON.parse(response.body)['courses'].first['id']).to eq(current_course.id)
    end

    it "returns empty array when no trimester exists" do
      Course.delete_all 
      Trimester.delete_all 
      get '/courses', headers: { 'ACCEPT' => 'application/json' }

      parsed = JSON.parse(response.body)
      expect(response).to have_http_status(:ok)
      expect(parsed['courses']).to eq([])
    end 
  end

  describe 'GET /course/:id' do 
    it "shows the course" do 
      course = FactoryBot.create(:course)
      student = FactoryBot.create(:student)
      Enrollment.create!(course: course, student: student)

      get course_path(course)

      expect(response.body).to include(course.coding_class.title)
    end 
  end 
end

