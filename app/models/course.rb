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
end
