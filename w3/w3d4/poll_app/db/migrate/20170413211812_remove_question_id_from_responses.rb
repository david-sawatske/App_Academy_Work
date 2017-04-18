class RemoveQuestionIdFromResponses < ActiveRecord::Migration[5.0]
  def change
    remove_column :responses, :question_id
  end
end
