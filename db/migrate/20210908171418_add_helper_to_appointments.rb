class AddHelperToAppointments < ActiveRecord::Migration[6.1]
    def change
        add_reference :appointments, :helper, null: true, foreign_key: { to_table: :users }
    end
end
