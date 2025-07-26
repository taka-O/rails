require 'rails_helper'

RSpec.describe "Api::Courses", type: :request do
  include_context 'token authentication header'

  let(:courses) { create_list(:course, 3) }
  let(:instructors) { create_list(:user, 2, role: :instructor) }
  let(:students) { create_list(:user, 3, role: :student) }

  before do
    create(:course_user, course_id: courses.first.id, user_id: instructors.first.id, user_type: :instructor)
    create(:course_user, course_id: courses.second.id, user_id: instructors.second.id, user_type: :instructor)
    create(:course_user, course_id: courses.third.id, user_id: instructors.first.id, user_type: :instructor)
    create(:course_user, course_id: courses.third.id, user_id: instructors.second.id, user_type: :instructor)
    create(:course_user, course_id: courses.first.id, user_id: students.first.id, user_type: :student)
    create(:course_user, course_id: courses.second.id, user_id: students.second.id, user_type: :student)
    create(:course_user, course_id: courses.third.id, user_id: students.second.id, user_type: :student)
    create(:course_user, course_id: courses.third.id, user_id: students.third.id, user_type: :student)
  end

  context 'with admin user' do
    let(:user) { create(:user, role: :admin) }

    it do
      get api_courses_path, headers: auth_headers(user)
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body.size).to eq 3
      expect(body.map { |r| r['id'] }).to match_array courses[0..2].map(&:id)
      expect(body.first['instructors'].map { |i| i['id'] }).to match_array [ instructors.first.id ]
      expect(body.second['instructors'].map { |i| i['id'] }).to match_array [ instructors.second.id ]
      expect(body.third['instructors'].map { |i| i['id'] }).to match_array [ instructors.first.id, instructors.second.id ]
      expect(body.first['students'].map { |s| s['id'] }).to match_array [ students.first.id ]
      expect(body.second['students'].map { |s| s['id'] }).to match_array [ students.second.id ]
      expect(body.third['students'].map { |s| s['id'] }).to match_array [ students.second.id, students.third.id ]
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
      expect(body.first['instructors'].map { |i| i['id'] }).to match_array [ instructors.second.id ]
      expect(body.second['instructors'].map { |i| i['id'] }).to match_array [ instructors.first.id, instructors.second.id ]
      expect(body.first['students'].map { |s| s['id'] }).to match_array [ students.second.id ]
      expect(body.second['students'].map { |s| s['id'] }).to match_array [ students.second.id, students.third.id  ]
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
      expect(body.map { |r| r['instructors'].map { |i| i['id'] } }.flatten).to match_array [ instructors.first.id ]
      expect(body.first['students']).to be_blank
    end
  end
end
