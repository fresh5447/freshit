class AddLinkToPosts < ActiveRecord::Migration
  def change
    change_table :topics do |t|
      t.string :link
    end
  end
end
