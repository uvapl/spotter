class Appointment < ApplicationRecord
    SLOTS_PER_HOUR = 4

    belongs_to :user
    belongs_to :course

    # see https://api.rubyonrails.org/classes/ActiveRecord/Enum.html
    enum status: { active: 0, cancelled: 1, done: 2 }

    def starting_time
        # exactly the library function we need
        DateTime.commercial(year, week, day, hour, (slot-1).to_f/SLOTS_PER_HOUR*60)
    end

    def self.booked_per_slot(year, week, day)
        where(year: year, week: week, day: day).group(:hour, :slot).count
    end

    def to_param
        uuid
    end
end
