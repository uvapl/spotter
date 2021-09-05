class AddUuidToAppointments < ActiveRecord::Migration[6.1]
  def change
    add_column :appointments, :uuid, :string
  end
end
