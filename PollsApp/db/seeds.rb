# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

ActiveRecord::Base.transaction do
  Response.destroy_all
  AnswerChoice.destroy_all
  Question.destroy_all
  Poll.destroy_all
  User.destroy_all



  ##############################
  # Users
  ##############################

  10.times.each do 
    User.create(username: Faker::Internet.username(5..8))
  end

  ##############################
  # Poll
  ##############################

  (0..9).each do |i|
    Poll.create(user_id: User.all[i].id, title: Faker::Hipster.sentence(3))
  end
  
  (0..9).each do |i|
    Poll.create(user_id: User.all[i].id, title: Faker::Hipster.sentence(3))
  end

  ##############################
  # Question
  ##############################

  (0..19).each do |poll_i|
    4.times do
      Question.create(poll_id: Poll.all[poll_i].id, text: Faker::Hipster.sentence(6))
    end
  end
  
  ##############################
  # AnswerChoice
  ##############################

  (0..79).each do |q_id|
    4.times do 
      AnswerChoice.create(question_id: Question.all[q_id].id, text: Faker::Hipster.sentences(2))
    end
  end
  
  ##############################
  # Reponse
  ##############################

  user_id = 0

  (0..319).each do |ac_i|
    Response.create(user_id: User.all[user_id].id, answer_choice_id: AnswerChoice.all[ac_i].id)
    user_id = (user_id + 1) % 10
  end

end
