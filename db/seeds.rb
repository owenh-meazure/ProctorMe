# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# start from scratch
College.destroy_all
Exam.destroy_all
User.destroy_all

# create a college
college_id = College.create!.id

# create 2 exams for the college
Exam.create!(college_id: college_id, start_time: 30.minutes.ago, end_time: 30.minutes.from_now)
Exam.create!(college_id: college_id)
first_exam_id, second_exam_id = Exam.all.map(&:id)

# create 2 users for each exam
User.create!([
  { exam_id: first_exam_id },
  { exam_id: first_exam_id, first_name: 'John', last_name: 'Dough' },
  { exam_id: second_exam_id, first_name: 'Kevin', phone_number: '212 222 2222' },
  { exam_id: second_exam_id, last_name: 'Rumplestiltskin', start_time: 1.hour.ago },
])

p "Created #{College.count} colleges"
p "Created #{Exam.count} exams"
p "Created #{User.count} users"