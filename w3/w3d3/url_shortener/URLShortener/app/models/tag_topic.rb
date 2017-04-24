class TagTopic < ApplicationRecord
  def change
    create_table :visits do |t|
      t.string :category

      t.timestamps
    end
end
