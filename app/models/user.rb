class EmailValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
        # generic e-mail pattern
        record.errors.add attribute,
            (options[:message] || "is not an email") unless
            /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.match?(value)
        # filter out 999999@uva.nl-like addresses
        record.errors.add attribute,
            (options[:message] || "is not a valid email address (it's an UvA login, but can't be used as an email)") if
            /\A([\d]+)@((?:[-a-z0-9]+\.)*uva\.nl)\z/i.match?(value)
    end
end

class User < ApplicationRecord
    has_secure_token :feed_token

    has_many :appointments

    validates :name, format: { with: /\A[[:alpha:]]{2,} [[:alpha:]\s]{2,}\z/i, on: :create }
    validates :email, presence: true, email: true
    validates_uniqueness_of :email
end
