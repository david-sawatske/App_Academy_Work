class FixColumnName < ActiveRecord::Migration[5.0]
  def change
    rename_column :subs, :destcription, :description
  end
end
