class Appointment < ApplicationRecord
    belongs_to :user
    belongs_to :course
    belongs_to :helper, class_name: 'User', optional: true
    delegate :name, to: :helper, prefix: true

    # see https://api.rubyonrails.org/classes/ActiveRecord/Enum.html
    enum status: { active: 0, cancelled: 1, done: 2 }

    def starting_time
        # exactly the library function we need
        DateTime.commercial(year, week, day, hour, (slot-1).to_f/course.slots*60)
    end

    def formatted_starting_time(format=:datetime)
        case format
        when :time
            starting_time.strftime '%-H:%M'
        when :datetime
            starting_time.strftime '%A %-d %B %Y, %-H:%M'
        end
    end

    def self.booked_per_slot(year, week, day)
        where(year: year, week: week, day: day).group(:hour, :slot).count
    end

    def to_param
        uuid
    end
end
