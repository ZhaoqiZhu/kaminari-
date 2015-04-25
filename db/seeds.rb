# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
40.times do |i|
	question = Question.create!(title: "Hello - #{i}", body: "Body - #{i}", author: User.where(email: /@/).to_a[0])
	Answer.create!(body: "Answer - #{i}", question: question, author: User.where(email: /@/).to_a[0])
end