class CreateUsers < ActiveRecord::Migration[6.1]
    def change
        create_table :users do |t|
            t.string :name
            t.string :email
            t.string :login

            t.timestamps
        end
        add_index :users, :email, unique: true
        add_index :users, :login, unique: true
    end
end
