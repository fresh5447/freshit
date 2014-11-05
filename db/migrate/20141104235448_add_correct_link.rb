class AddCorrectLink < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.string :link
    end
  end
end
