# == Schema Information
#
# Table name: responses
#
#  id               :bigint           not null, primary key
#  user_id          :integer          not null
#  answer_choice_id :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Response < ApplicationRecord

  validate :not_duplicate_response

  belongs_to :respondent,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice

  has_one :question,
    through: :answer_choice,
    source: :question

  def sibling_responses
    self
    .question
    .responses
    .where.not(id: self.id)

    # self
    # .question
    # .responses
    # .where.not('responses.id = ?', self.id)
  end

  def respondent_already_answered?
    sibling_responses.any? { |response| response.user_id == self.user_id }
  end

  private
  def not_duplicate_response
    if respondent_already_answered?
      errors[:user_id] << 'has already answered this question'
    end
  end

end

#  user_id: 61,
#  answer_choice_id: 641,

#  Response.new(user_id: 61, answer_choice_id: 641)