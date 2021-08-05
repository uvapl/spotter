class PlannerController < ApplicationController
    def index
        @courses = Course.all
    end

    def show
        @course = Course.find(params[:id])
        @suggestions = []

        # start with 4 suggestions for today
        schedule_this_week = @course.this_week.slots
        day, slots = schedule_this_week.today
        @suggestions += helpers.slots_to_suggestions(
            @course, Date.current.year, Date.current.cweek,
            day, slots, 4)

        if day <= 4
            # if today is Mon-Thu, fill up with suggestions for tomorrow
            day, slots = schedule_this_week.tomorrow
            @suggestions += helpers.slots_to_suggestions(
                @course, Date.current.year, Date.current.cweek,
                day, slots, 6 - @suggestions.count)
        else
            # if it's Friday or weekend, add suggestions for Monday next week
            schedule_next_week = @course.next_week.slots
            day, slots = schedule_next_week.monday
            @suggestions += helpers.slots_to_suggestions(
                @course, (Date.current + 7).year, (Date.current + 7).cweek,
                day, slots, 6 - @suggestions.count)
        end
    end
end
