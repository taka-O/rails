require 'rails_helper'

RSpec.describe "Api::Courses", type: :request do
  include_context 'token authentication header'

  let(:courses) { create_list(:course, 3) }
  let(:instructors) { create_list(:user, 2, role: :instructor) }
  let(:students) { create_list(:user, 3, role: :student) }

  before do
    create(:course_instructor, course_id: courses.first.id, user_id: instructors.first.id)
    create(:course_instructor, course_id: courses.second.id, user_id: instructors.second.id)
    create(:course_instructor, course_id: courses.third.id, user_id: instructors.second.id)
    create(:course_student, course_id: courses.first.id, user_id: students.first.id)
    create(:course_student, course_id: courses.second.id, user_id: students.second.id)
    create(:course_student, course_id: courses.third.id, user_id: students.second.id)
  end

  context 'with admin user' do
    let(:user) { create(:user, role: :admin) }

    it do
      get api_courses_path, headers: auth_headers(user)
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body.size).to eq 3
      expect(body.map { |r| r['id'] }).to match_array courses[0..2].map(&:id)
    end
  end

  context 'with instructor user' do
    let(:user) { instructors.second }

    it do
      get api_courses_path, headers: auth_headers(user)
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body.size).to eq 2
      expect(body.map { |r| r['id'] }).to match_array [ courses.second.id, courses.third.id ]
    end
  end

  context 'with student user' do
    let(:user) { students.first }

    it do
      get api_courses_path, headers: auth_headers(user)
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body.size).to eq 1
      expect(body.map { |r| r['id'] }).to match_array [ courses.first.id ]
    end
  end
end
