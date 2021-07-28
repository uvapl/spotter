class Schedule < ApplicationRecord
    belongs_to :course

    serialize :slots
end
