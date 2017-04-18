class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_already_answered?

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
      # response = Response.new(
      #   user_id: User.all.first.id,
      #   answer_choice_id: AnswerChoice.all.first.id)
      #
      # question.responses
      #
      # response.save


      question.responses.where.not(id: self.id)
    end

    def respondent_already_answered?
      sibling_responses.any? do |response|
        errors[:respondent] << "already answered!" if response.user_id == self.user_id
      end
    end
end
