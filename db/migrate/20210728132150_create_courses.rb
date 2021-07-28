class CreateCourses < ActiveRecord::Migration[6.1]
    def change
        create_table :courses do |t|
            t.string :name

            t.timestamps
        end

        add_reference :schedules, :course, null: false, foreign_key: true, default: 0
        add_reference :appointments, :course, null: false, foreign_key: true, default: 0
    end
end
