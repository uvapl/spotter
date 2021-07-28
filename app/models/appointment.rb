class Appointment < ApplicationRecord
    SLOTS_PER_HOUR = 4

    belongs_to :user

    # see https://api.rubyonrails.org/classes/ActiveRecord/Enum.html
    enum status: { active: 0, cancelled: 1, done: 2 }
    
    def starting_time
        # exactly the library function we need
        DateTime.commercial(year, week, day, hour, (slot-1).to_f/SLOTS_PER_HOUR*60)
    end
end
