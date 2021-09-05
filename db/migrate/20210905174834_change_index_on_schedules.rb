class ChangeIndexOnSchedules < ActiveRecord::Migration[6.1]
    def change
        remove_index :schedules, [:week, :year], unique: true
        add_index :schedules, [:course_id, :week, :year], unique: true
    end
end
