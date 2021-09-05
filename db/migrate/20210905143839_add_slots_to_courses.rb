class AddSlotsToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :slots, :integer
  end
end
