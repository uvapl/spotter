class AddFeedTokenToUsers < ActiveRecord::Migration[6.1]
    def change
        add_column :users, :feed_token, :string
    end
end
