class AddSubId < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :sub_id, :integer
  end
end
