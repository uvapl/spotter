class PlannerController < ApplicationController
    def index
        @courses = Course.all
    end

    def show
        @course = Course.find(params[:id])

        # get this week's slots
        this_week = @course.schedules.where(year: Date.current.year, week: Date.current.cweek).first
        this_week = this_week.slots.select{|k,v| k >= Date.current.wday}

        # get next week's slots
        next_week = @course.schedules.where(year: (Date.current + 7).year, week: (Date.current + 7).cweek).first

        @suggestions = []

        if !this_week.empty? then
            # if there are still days left this week, suggest 4 slots on the first day
            day = this_week.keys.first
            @suggestions += helpers.slots_to_suggestions(@course, Date.current.year, Date.current.cweek, day, this_week[day], 4)

            # fill the remaining slots with the next available day
            remaining = @suggestions.count > 1 ? 2 : 4

            if this_week.keys.count >= 2 then
                day = this_week.keys[1]
                @suggestions += helpers.slots_to_suggestions(@course, Date.current.year, Date.current.cweek, day, this_week[day], remaining)
            else
                day = next_week.keys.first
                @suggestions += helpers.slots_to_suggestions(@course, (Date.current + 7).year, (Date.current + 7).cweek, day, next_week[day], remaining)
            end
        else
            # if there are no more slots available this week, suggest 4 slots on the first available day next week
            day = next_week.keys.first
            @suggestions += helpers.slots_to_suggestions(@course, (Date.current + 7).year, (Date.current + 7).cweek, day, next_week[day], 6)
        end
    end
end
