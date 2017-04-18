# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
user1 = User.create(user_name: "user1")
user2 = User.create(user_name: "user2")
user3 = User.create(user_name: "user3")

Poll.destroy_all
poll1 = Poll.create(title: "title1", author_id: user1.id)
poll2 = Poll.create(title: "title2", author_id: user1.id)
poll3 = Poll.create(title: "title3", author_id: user2.id)

Question.destroy_all
question1 = Question.create(poll_id: poll1.id, question: "this is q1")
question2 = Question.create(poll_id: poll1.id, question: "this is q2")
question3 = Question.create(poll_id: poll2.id, question: "this is q3")
question4 = Question.create(poll_id: poll2.id, question: "this is q4")
question5 = Question.create(poll_id: poll3.id, question: "this is q5")

AnswerChoice.destroy_all
answer1 = AnswerChoice.create(question_id: question1.id, answer: "i am a1")
answer2 = AnswerChoice.create(question_id: question1.id, answer: "i am a2")
answer3 = AnswerChoice.create(question_id: question2.id, answer: "i am a3")
answer4 = AnswerChoice.create(question_id: question2.id, answer: "i am a4")
answer5 = AnswerChoice.create(question_id: question3.id, answer: "i am a5")
answer6 = AnswerChoice.create(question_id: question3.id, answer: "i am a6")
answer7 = AnswerChoice.create(question_id: question3.id, answer: "i am a7")
answer8 = AnswerChoice.create(question_id: question4.id, answer: "i am a8")
answer9 = AnswerChoice.create(question_id: question4.id, answer: "i am a9")
answer10 = AnswerChoice.create(question_id: question5.id, answer: "i am a10")
answer11 = AnswerChoice.create(question_id: question5.id, answer: "i am a11")

Response.destroy_all
response1 = Response.create(user_id: user1.id, answer_choice_id: answer5.id)
response2 = Response.create(user_id: user1.id, answer_choice_id: answer10.id)
response3 = Response.create(user_id: user2.id, answer_choice_id: answer3.id)
response4 = Response.create(user_id: user2.id, answer_choice_id: answer1.id)
response5 = Response.create(user_id: user3.id, answer_choice_id: answer1.id)
response6 = Response.create(user_id: user3.id, answer_choice_id: answer2.id)
