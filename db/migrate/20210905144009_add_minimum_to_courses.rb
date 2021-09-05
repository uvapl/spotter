class AddMinimumToCourses < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :minimum, :integer
  end
end
