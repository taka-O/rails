class AnnouncementCourse < ApplicationRecord
  belongs_to :announcement
  belongs_to :course
end
