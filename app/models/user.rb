class User < ApplicationRecord
    validates :name, format: { with: /\A\w{2,} [\w\s]{2,}\z/i, on: :create }
    validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
end
