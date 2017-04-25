class CreateSubs < ActiveRecord::Migration[5.0]
  def change
    create_table :subs do |t|
      t.string :title
      t.text :destcription
      t.integer :moderator

      t.timestamps
    end
  end
end
