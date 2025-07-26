require 'rails_helper'

RSpec.describe "Api::Announcements", type: :request do
  include_context 'token authentication header'

  let(:courses) { create_list(:course, 2) }
  let(:instructors) { create_list(:user, 2, role: :instructor) }
  let(:students) { create_list(:user, 2, role: :student) }
  let(:announcements) do
    [
      create(:announcement, category: :all_user),
      create(:announcement, category: :course),
      create(:announcement, category: :course),
      create(:announcement, category: :all_user, end_at: Time.zone.now.prev_day),
      create(:announcement, category: :course, end_at: Time.zone.now.prev_day)
    ]
  end

  before do
    create(:announcement_course, announcement_id: announcements.second.id, course_id: courses.first.id)
    create(:announcement_course, announcement_id: announcements.third.id, course_id: courses.second.id)

    create(:course_user, course_id: courses.first.id, user_id: instructors.first.id, user_type: :instructor)
    create(:course_user, course_id: courses.second.id, user_id: instructors.second.id, user_type: :instructor)
    create(:course_user, course_id: courses.first.id, user_id: students.first.id, user_type: :student)
    create(:course_user, course_id: courses.second.id, user_id: students.second.id, user_type: :student)

    create(:announcement_course, announcement_id: announcements.last.id, course_id: courses.first.id)
  end

  context 'with admin user' do
    let(:user) { create(:user, role: :admin) }

    it do
      get api_announcements_path, headers: auth_headers(user)
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body.size).to eq 3
      expect(body.map { |r| r['id'] }).to match_array announcements[0..2].map(&:id)
    end
  end

  context 'with instructor user' do
    let(:user) { instructors.first }

    it do
      get api_announcements_path, headers: auth_headers(user)
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body.size).to eq 2
      expect(body.map { |r| r['id'] }).to match_array [ announcements.first.id, announcements.second.id ]
    end
  end

  context 'with student user' do
    let(:user) { students.second }

    it do
      get api_announcements_path, headers: auth_headers(user)
      expect(response).to have_http_status(:ok)
      body = JSON.parse(response.body)
      expect(body.size).to eq 2
      expect(body.map { |r| r['id'] }).to match_array [ announcements.first.id, announcements.third.id ]
    end
  end
end
