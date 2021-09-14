class Course < ApplicationRecord
    has_many :schedules
    has_many :appointments

    def find_week(year, week)
        schedules.where(year: year, week: week).first || Schedule.new
    end

    def this_week
        find_week Date.current.year, Date.current.cweek
    end

    def next_week
        find_week (Date.current + 7).year, (Date.current + 7).cweek
    end

    def to_param
        "#{id}-#{name.parameterize}"
    end

    def first_available_slot_starting_from(year, week, day, hour, slot)
        bookings = appointments.booked_per_slot(year, week, day)
        slots = find_week(year, week).slots.get(day)[1].select{|h,count| h >= hour}

        # run through the available hours
        slots.keys.each do |hour|
            # run through the available slots within the hour
            for i in slot..self.slots do
                # add if no bookings for the slot or less than available
                past_now = create_date(self, year, week, day, hour, i) > DateTime.now
                slot_available = !bookings[[hour,i]] || bookings[[hour,i]] < slots[hour]

                if past_now && slot_available
                    return [hour, i]
                end
            end
        end

        return false
    end

    def create_date(course, year, week, day, hour, slot)
        DateTime.commercial(
                    year, week, day, hour, (slot-1).to_f/course.slots*60, 0, '+2')
    end

end
