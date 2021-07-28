class CreateAppointments < ActiveRecord::Migration[6.1]
    def change
        create_table :appointments do |t|
            t.references :user, null: false, foreign_key: true
            t.integer :hour, null: false
            t.integer :day, null: false
            t.integer :week, null: false
            t.integer :year, null: false
            t.text :subject
            t.string :note
            t.integer :status, null: false, default: 0

            t.timestamps
        end
    end
end
