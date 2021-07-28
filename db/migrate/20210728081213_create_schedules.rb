class CreateSchedules < ActiveRecord::Migration[6.1]
    def change
        create_table :schedules do |t|
            t.integer :week
            t.integer :year
            t.text :slots

            t.timestamps
        end
        add_index :schedules, [:week, :year], unique: true
    end
end
