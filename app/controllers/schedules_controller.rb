class SchedulesController < ApplicationController
    before_action :require_admin

    def show
        load_schedule_params
        @schedule = Schedule.find_by(course: @course, week: @week_number, year: @year_number)
        @slots = @schedule.slots
    end

    def update
        load_schedule_params
        slots = {}

        for day in 0..6 do
            day_slots = {}
            for hour in 9..17 do
                amount = params[day.to_s + "-" + hour.to_s].to_i
                day_slots[hour] = amount unless amount == 0
            end
            slots[day] = day_slots
        end

        schedule = Schedule.find_by(course: @course,
                                    week: @week_number,
                                    year: @year_number)
        schedule.slots = slots
        schedule.save!

        redirect_to edit_course_path(@course), notice: "Saved!"
    end

    def course_params
        params.require(:course).permit(:name, :slots, :minimum, :location)
    end

    def load_schedule_params
        @course = Course.find params[:course_id]
        @week_number = params[:week_number]
        @multiple_weeks = @week_number.include?('-')
        @year_number = params[:year_number]
    end
end
