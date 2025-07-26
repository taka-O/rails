json.extract! course, :id, :name, :description
if course.instructors.loaded?
  json.set! :instructors do
    json.array! course.instructors, :id, :name
  end
end
if course.students.loaded?
  json.set! :students do
    json.array! course.students, :id, :name
  end
end
