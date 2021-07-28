class Appointment < ApplicationRecord
    belongs_to :user

    # see https://api.rubyonrails.org/classes/ActiveRecord/Enum.html
    enum status: { active: 0, cancelled: 1, done: 2 }
end
