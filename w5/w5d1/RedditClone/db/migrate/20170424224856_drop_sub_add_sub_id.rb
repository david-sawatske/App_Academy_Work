class DropSubAddSubId < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :sub
  end
end
